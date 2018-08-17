Utility = require './utility'

extractData = (dataRows, date)->
  sheetHeader = getSheetHeader(dataRows)
  if sheetHeader?
    track = getTrack(sheetHeader[0])
    raceDate = dateInSheet = Utility.getDate(sheetHeader[0])
    raceDate = Utility.getDate(date) if raceDate == 'Invalid Date' && date?
    results = getRunnerData(dataRows, raceDate, track)
  else
    results = { error: 'unknownFormat' }
  return results

getRunnerData = (dataRows, raceDate, track)->
  if raceDate != 'Invalid Date'
    results = { data: [] }
    for row, index in dataRows
      if isRaceHeaderRow(row)
        raceNumber = getRaceNumber dataRows[index-2][0]
        inc = 1
        while dataRows[index + inc][0].toString().toUpperCase() != 'TOTALS'
          runnerRow = dataRows[index + inc]
          results.data.push([raceDate, track, raceNumber, runnerRow[2], runnerRow[3]])
          inc++
  else
    results = {error: 'dateMissing'}
  return results

getSheetHeader = (dataRows)->
  dataRows.find (row)->
    typeof(row[0]) == 'string' && row[0].toLowerCase().indexOf('ratings -') != -1

getTrack = (trackString)->
  trackString.split('-')[0].replace(/ratings/i, '').trim()

getRaceNumber = (raceString)->
  raceString.split('-')[0].replace(/race/i, '').trim()

isRaceHeaderRow = (row)->
  Utility.matchStrings('number', row[0]) && Utility.matchStrings('form', row[1]) && Utility.matchStrings('horse', row[2])

module.exports =
  extractData: extractData
  isRaceHeaderRow: isRaceHeaderRow
