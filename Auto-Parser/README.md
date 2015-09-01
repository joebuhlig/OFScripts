# OmniFocus Auto-Parser

This is a launch agent designed to automatically parse the inbox of OmniFocus behind the scenes. You can email into OmniFocus and have it automatically parsed into the correct project and context. It can even have due dates, defer dates, flags, and estimated time.

To use it, you simply need to create a string that is to be parsed and pass it to the OmniFocus inbox. You can learn more about creating the string for this [here][SM_OF_Article].


# Installation

There's a little bit of work involved in setting this up, but it's not too complicated if you'll follow each step.

## 1. Download and alter the files

Download the Auto-Parser files and make a couple changes. 

First change the path in the pList file to match the location of the AppleScript file.

`<string>/Users/Username/DropBox/AppleScripts/BackgroundScripts/ParseInbox.applescript</string>`

Alter the start interval to the amount of time you'd like the script to run. This number is in seconds, so 300 is equal to five minutes. The script will run every five minutes.

`<key>StartInterval</key>`
`<integer>300</integer>`

## 2. Place the files

Make sure you place the AppleScript file in the path you entered into the pList file.

Place the pList file at the following location:

`/Users/Username/Library/LaunchAgents`

## 3. Log off/log in

When you've altered the files and placed them, log off of your account and then log back in. This is what will trigger the agent to run the first time.

## 4. Test and enjoy

Create a test string and pass it to your inbox. Wait until your StartInterval time has passed and watch the magic happen!

# Development

I'm certainly open to the submission of Pull Requests to make this better. It's very basic at the moment. If you find issues and fix them, please let me know and I'll be happy to update and give you credit.
