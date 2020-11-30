#!/bin/bash

# Main url for future use !
bing='https://www.bing.com'

# url for the bing.com background json file
pic='https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=en-US'

# Fetching the Day Picture url from json file
# sed will remove the double quotation marks in the link
# Note: This Line (12) will execute curl and saves output in url variable as a String
url=$(curl -X GET $pic | jq '.images[0] .url' | sed 's/"//g')

# Fetching Start Date from json file which equals to today's date
date=$(curl -X GET $pic | jq '.images[0] .startdate' | sed 's/"//g')

# Adding jpg extension to the file
date+=".jpg"

# concatenate main url with the day picture url
bing+=$url

# Download and Rename the picture
wget -O "$date" "$bing"

# Move the picture to the ~/Pictures Folder
mv "$date" ~/Pictures/

# Changing desktop background using gnome setting
gsettings set org.gnome.desktop.background picture-uri file:////$HOME/Pictures/$date