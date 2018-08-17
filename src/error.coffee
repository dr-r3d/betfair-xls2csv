errorMessages =
  'unknownFormat': 'Excel sheet has unknown format'
  'invalidDate': 'is not a valid date'
  'dateMissing': 'Please provide date'
  'invalidFile': 'not found'


print = (errorName)->
  console.error 'Error: '+ errorMessages[errorName]

printWithValue = (errorName, errorValue)->
  console.error 'Error: '+ errorValue + ' ' + errorMessages[errorName]

module.exports=
  print: print
  printWithValue: printWithValue
