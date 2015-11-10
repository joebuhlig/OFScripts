# Daily Task Report

I like keeping a log of the work I've done every day. And since I keep all of my work in OmniFocus, it only makes sense to automatically create a report off of yesterdays completed tasks. That's exactly what this script does.

It will generate a plain text file with the following format:

```
Weekday, Month Day, Year
------------------------
Project Name
Task Name ----- HH:MM:SS AM/PM
Task Name ----- HH:MM:SS AM/PM
Task Name ----- HH:MM:SS AM/PM
------------------------
Project Name
Task Name ----- HH:MM:SS AM/PM
Task Name ----- HH:MM:SS AM/PM
Task Name ----- HH:MM:SS AM/PM
```

# Running the Script

You could manually run this every day, but I've found Hazel to be much more reliable than me. Here's a screenshot of the rule I use to run this:

![Hazel Rule](https://github.com/joebuhlig/OFScripts/blob/master/Daily%20Task%20Report/HazelRule.jpg)

# Setup

All you need to do is tell it where you want to save the files. Change this line:

`set filePath to "/Users/USERNAME/TaskReports/"`

# Development

I'm certainly open to the submission of Pull Requests to make this better. If you find issues and fix them, please let me know and I'll be happy to update and give you credit.
