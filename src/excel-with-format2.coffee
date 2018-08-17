Utility = require './utility'

extractData = (dataRows, date)->
  if date?
    raceDate = Utility.getDate(date)
    results = { data: [] }
    for row, index in dataRows
      if isRaceHeaderRow(row)
        raceNumber = getRaceNumber dataRows[index-1][1]
        track = dataRows[index-1][2]
        inc = 1
        while !isCellBlank(dataRows[index + inc][0])
          runnerRow = dataRows[index + inc]
          results.data.push([raceDate, track, raceNumber, runnerRow[2], runnerRow[9]])
          inc++
  else
    results = {error: 'dateMissing'}
  return results

isCellBlank = (cell)->
  !cell? || typeof(cell) == 'undefined' || cell == ''

getRaceNumber = (raceString)->
  raceString.replace(/race/i, '').trim()

isRaceHeaderRow = (row)->
  Utility.matchStrings('no', row[0]) && Utility.matchStrings('last 10', row[1]) && Utility.matchStrings('horse', row[2])

module.exports =
  extractData: extractData
  isRaceHeaderRow: isRaceHeaderRow
