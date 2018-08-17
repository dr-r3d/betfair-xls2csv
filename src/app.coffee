`#!/usr/bin/env node
`

program = require('commander')
converter = require('./converter')
program.version('0.0.1').description('Extract betfair races from excel sheet into csv file')
  .option('-p, --filepath <filepath>', 'path to excel file')
  .option('-d, --date <date>', 'date of races')
  .parse(process.argv)

if program.filepath?
  converter.convertToCSV(program.filepath, program.date)
else
  program.help()
