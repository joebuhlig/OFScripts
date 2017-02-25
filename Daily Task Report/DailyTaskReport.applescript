on hazelProcessFile(theFile)
	set filePath to "/Users/USERNAME/TaskReports/" -- Where to save the resulting text file (Be sure to add the trailing "/")
	
	-- Create the new filename as YYYYMMDD.txt
	set todayDate to current date
	set yestDate to todayDate - 1 * days
	set {year:y, month:m, day:d} to yestDate
	set fileName to y * 10000
	set fileName to fileName + (m * 100)
	set fileName to fileName + d
	
	-- Set the starting date of the report
	set startDate to todayDate - 1 * days
	set startDate's hours to 0
	set startDate's minutes to 0
	set startDate's seconds to 0
	
	-- Set the ending date of the report
	set endDate to todayDate - 1 * days
	set endDate's hours to 23
	set endDate's minutes to 59
	set endDate's seconds to 59
	
	-- Create the blank report to build from
	set reportText to ""
	
	tell application "OmniFocus"
		tell front document
			-- Get the list of projects that were modified within the date span
			set theProjects to every flattened project where its modification date is greater than startDate and modification date is less than endDate
			-- Loop through the matching project list
			repeat with a from 1 to length of theProjects
				-- Get the current project to work with
				set currentProj to item a of theProjects
				-- Get the tasks that were completed within the date span
				set theTasks to (every flattened task of currentProj where its completed = true and completion date is greater than startDate and completion date is less than endDate)
				-- If there are tasks that meet the criteria
				if theTasks is not equal to {} then
					-- Add a dividing line and then enter the project name
					set reportText to reportText & return & return & "------------------------------" & return & name of currentProj & return
					-- Loop through the tasks
					repeat with b from 1 to length of theTasks
						-- Get the current task to work with
						set currentTask to item b of theTasks
						-- Save the completed date to a variable
						set completedDate to completion date of currentTask
						-- Get the time of the completed date
						set completedTime to time string of completedDate
						-- Add the task to the report text with the completed time
						set reportText to reportText & return & name of currentTask & " ----- " & completedTime
					end repeat
				end if
			end repeat
			-- If there were no tasks to write to the report
			if reportText is equal to "" then
				set reportText to "Nothing completed for this day."
			end if
			
			-- Get the yesterday's date for the top of the report
			set runTime to date string of (todayDate - 1 * days)
			-- Add the date to the top of the report, enter down a couple lines, and add the report text
			set reportText to runTime & return & return & reportText
			-- Create the new report file
			set newFile to open for access filePath & fileName & ".txt" with write permission
			-- Add the report text to the new file
			write reportText to newFile
			-- Close the report file
			close access newFile
		end tell -- end tell front document
	end tell -- end tell application "OmniFocus"
end hazelProcessFile