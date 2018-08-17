module.exports =
  getDate: (dateStr)-> new Date(dateStr).toDateString()
  matchStrings: (str1, str2)-> str1? && str2? && str1.match(new RegExp(str2, 'i'))?
