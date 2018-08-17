# betfair-xls2csv
Node CLI app to extract betfair race details from spreadsheet to csv file

### Usage: 
bf-xls2csv [options]  
Extract betfair races from excel sheet into csv file

Options:

  -V, --version              output the version number  
  -p, --filepath <filepath>  path to excel file  
  -d, --date <date>          date of races  
  -h, --help                 output usage information
  
###Installation
git clone git@github.com:dr-r3d/betfair-xls2csv.git

cd betfair-xls2csv

npm install && npm run build
chmod +x app.js
npm link

