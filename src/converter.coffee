XLSX = require 'xlsx'
fs = require 'fs'
Error = require('./error')
ExcelWithFormat1 = require('./excel-with-format1')
ExcelWithFormat2 = require('./excel-with-format2')

ChampionBetsFormat1 = 0
ChampionBetsFormat2 = 1

convertToCSV = (filepath, date)->
  dateIsValid = !date? || isDateValid(date)
  if dateIsValid && isFilePresent(filepath)
    dataRows = getDataRows(filepath)
    results = {}
    format = detectDataFormat(dataRows)
    switch format
      when ChampionBetsFormat1
        results = ExcelWithFormat1.extractData(dataRows, date)
      when ChampionBetsFormat2
        results = ExcelWithFormat2.extractData(dataRows, date)
      else
        Error.print('unknownFormat')

    if results.error?
      Error.print results.error
    else
      console.log results.data
      createCSV results.data

getDataRows = (filepath)->
  wb = XLSX.read(filepath, type: 'file')
  ws = wb.Sheets[wb.SheetNames[0]]
  return XLSX.utils.sheet_to_json(ws, {header:1, raw:true}).slice(1)

createCSV = (csvData)->
  headers = ['Date', 'Track name', 'Race number', 'Horse name', 'Rated Price']
  csvData.unshift headers
  csv_ws = XLSX.utils.aoa_to_sheet(csvData)
  csv_wb = XLSX.utils.book_new()
  XLSX.utils.book_append_sheet(csv_wb, csv_ws, "CSV");
  XLSX.writeFile(csv_wb, "ratings.csv", {type: 'file', bookType: 'csv'})
  console.info "ratings.csv is created"

detectDataFormat = (dataRows)->
  format = -1
  for row, index in dataRows
    if ExcelWithFormat1.isRaceHeaderRow(row)
      format = ChampionBetsFormat1
    else if ExcelWithFormat2.isRaceHeaderRow(row)
      format = ChampionBetsFormat2
    break if format >= 0
  return format

isDateValid = (dateStr)->
  date = Date.parse(dateStr)
  state = !isNaN(date) && date > 0
  Error.printWithValue('invalidDate', dateStr) unless state
  return state

isFilePresent = (filepath)->
  state = fs.existsSync(filepath)
  Error.printWithValue('invalidFile', filepath) unless state
  return state

module.exports =
  convertToCSV: convertToCSV
  createCSV: createCSV
