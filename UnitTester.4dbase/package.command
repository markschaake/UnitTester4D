#!/bin/sh

#Delete the currently installed UnitTester component
rm -r ./Demo/Demo.4dbase/Components/UnitTester.4dbase

#Copy the latest build into the Components folder
cp -R ./build/Components/UnitTester.4dbase Demo/Demo.4dbase/Components/UnitTester.4dbase

#Zip it up and put to the website folder for download
zip -r /Applications/MAMP/htdocs/UnitTester4d/public/153/Demo.zip Demo/Demo.4dbase