# OFScripts

This is a repository of the automated systems I use to enhance OmniFocus. If you find errors or would like to contribute to these, feel free to send me a pull request.

# Which Files?

In each of the directories you'll find two versions of the script - `.scpt` and `.applescript`. In order to run them from OmniFocus, you'll want to use the `.scpt` version. The `.applescript` format is purely there so you can view the code online.

# Auto-Parser

This is a launch agent designed to automatically parse the inbox of OmniFocus behind the scenes. You can email into OmniFocus and have it automatically parsed into the correct project and context. It can even have due dates, defer dates, flags, and estimated time.

To use it, you simply need to create a string that is to be parsed and pass it to the OmniFocus inbox. You can learn more about creating the string for this [here](http://joebuhlig.com/using-omnifocus-for-somedaymaybe-lists/).

# Bible Reading Plan

A taskpaper template for a one-year Bible reading plan project.

# Daily Task Report

I like keeping a log of the work I've done every day. And since I keep all of my work in OmniFocus, it only makes sense to automatically create a report off of yesterdays completed tasks. That's exactly what this script does.

# Duration Titles

This script takes the Estimated Duration and appends it to the title of the task. The main reason for this is that the duration isn't easily accessed on iOS. So by putting it at the end of the task name, it now becomes visible everywhere you see the task.

# Project Codes

A [TextExpander](https://joebuhlig.com/go/textexpander) snippet for creating and managing project codes.

# Read Book Tasks

I read books on a schedule so I needed a quick way to create tasks for how much to read in a day. This script adds these tasks automatically after asking a handful of questions about the book and your timeframe. You can learn more about it [here](http://joebuhlig.com/reading-books-on-a-schedule/).

# Task Shuffle

I've found that reviewing my idea lists generates more and new ideas if I can shuffle the tasks within a given project. So that's what this does. Select a project or projects and run this script to shuffle the tasks within each project.

# Update Reviews

If that flag beside the Review perspective drives you crazy, this is for you. You can set dates for your scheduled reviews and move the Next Review Date of each project forward to the next instance of your reviews. You can learn more about it [here](http://joebuhlig.com/scheduled-reviews-in-omnifocus/).

# Weather Activation

This is one of the more involved scripts I use. It will activate or deactivate a project in OmniFocus based on tomorrow's weather forecast. The project will go from On Hold to Active if it's being activated. It will go from Active to On Hold if deactivated.
