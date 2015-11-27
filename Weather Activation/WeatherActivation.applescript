tell application "JSON Helper"
	set theURL to "http://api.wunderground.com/api/XXXXX_APIKEY_XXXXX/forecast/q/IL/Chicago.json"
	set weather to fetch JSON from (theURL)
	set highTemp to (fahrenheit of high of item 1 of forecastday of simpleforecast of forecast of weather) as integer
	set lowTemp to (fahrenheit of low of item 1 of forecastday of simpleforecast of forecast of weather) as integer
	set condition to (|in| of qpf_day of item 1 of forecastday of simpleforecast of forecast of weather)
	
end tell

tell application "OmniFocus"
	tell front document
		-- Get all the projects
		set theProjects to every flattened project
		repeat with projNum from 1 to length of theProjects
			
			-- Get the current project
			set curProject to item projNum of theProjects
			set projNote to note of curProject
			if projNote contains "<Activate>" then
				set projectTriggers to text ((offset of "<Activate>" in projNote) + 10) thru ((offset of "</Activate>" in projNote) - 1) of projNote
				set triggerFlag to my getTriggerFlag(projectTriggers, highTemp, lowTemp)
				if triggerFlag is true then
					set status of curProject to active
				end if
			end if -- if note contains <Activate>
			if projNote contains "<Deactivate>" then
				set projectTriggers to text ((offset of "<Deactivate>" in projNote) + 12) thru ((offset of "</Deactivate>" in projNote) - 1) of projNote
				set triggerFlag to my getTriggerFlag(projectTriggers, highTemp, lowTemp)
				if triggerFlag is true then
					set status of curProject to on hold
				end if
			end if -- if note contains <Deactivate>
		end repeat -- Project loop
	end tell
end tell

on getTriggerFlag(projectTriggers, highTemp, lowTemp)
	set AppleScript's text item delimiters to {";"}
	set weatherTriggers to every text item of projectTriggers
	set AppleScript's text item delimiters to {" "}
	set triggerFlag to true
	repeat with n from 1 to (length of weatherTriggers) - 1
		set weatherTrigger to item n of weatherTriggers
		set AppleScript's text item delimiters to {":"}
		set triggerItems to every text item of weatherTrigger
		set AppleScript's text item delimiters to {" "}
		set triggerType to (my trim(item 1 of triggerItems)) as string
		set triggerValue to (my trim(item 2 of triggerItems)) as string
		try
			if (text 1 thru 1 of triggerValue) is "-" then
				set firstIntLoc to 1
			end if
			set intCheck to (text 1 thru 1 of triggerValue) as integer
			set firstIntLoc to 1
		on error
			try
				if (text 2 thru 2 of triggerValue) is "-" then
					set firstIntLoc to 2
				end if
				set intCheck to (text 2 thru 2 of triggerValue) as integer
				set firstIntLoc to 2
			on error
				try
					if (text 3 thru 3 of triggerValue) is "-" then
						set firstIntLoc to 3
					end if
					set intCheck to (text 3 thru 3 of triggerValue) as integer
					set firstIntLoc to 3
				end try
			end try
		end try
		set triggerOperator to text 1 thru (firstIntLoc - 1) of triggerValue
		set triggerInt to (text firstIntLoc thru (length of triggerValue) of triggerValue) as integer
		set tempFlag to my activateProject(triggerType, triggerOperator, triggerInt, highTemp, lowTemp)
		if tempFlag is false then
			set triggerFlag to false
		end if
	end repeat -- weatherTrigger loop
	return triggerFlag
end getTriggerFlag

on activateProject(triggerType, triggerOperator, triggerInt, highTemp, lowTemp)
	if triggerType = "LowTemp" then
		set weatherData to lowTemp
		set dataCheck to my dataCheck(weatherData, triggerOperator, triggerInt)
	end if
	
	if triggerType = "HighTemp" then
		set weatherData to highTemp
		set dataCheck to my dataCheck(weatherData, triggerOperator, triggerInt)
	end if
	if triggerType = "Precip" then
		set weatherData to condition
		set dataCheck to my dataCheck(weatherData, triggerOperator, triggerInt)
	end if
	return dataCheck
end activateProject

on dataCheck(weatherData, triggerOperator, triggerInt)
	set dataPass to false
	if triggerOperator is "=" then
		if weatherData = triggerInt then
			set dataPass to true
		end if
	else if triggerOperator is "<" then
		if weatherData is less than triggerInt then
			set dataPass to true
		end if
	else if triggerOperator is ">" then
		if weatherData is greater than triggerInt then
			set dataPass to true
		end if
	else if triggerOperator is "<=" then
		if weatherData is less than or equal to triggerInt then
			set dataPass to true
		end if
	else if triggerOperator is ">=" then
		if weatherData is greater than or equal to triggerInt then
			set dataPass to true
		end if
	else if triggerOperator = "<>" then
		if weatherData is not equal to triggerInt then
			set dataPass to true
		end if
	else
		set dataPass to false
	end if
	return dataPass
end dataCheck

on trim(someText)
	set AppleScript's text item delimiters to {return & linefeed, return, linefeed, character id 8233, character id 8232}
	set newText to text items of someText
	set AppleScript's text item delimiters to {" "}
	set someText to newText as text
	repeat until someText does not start with " "
		set someText to text 2 thru -1 of someText
	end repeat
	
	repeat until someText does not end with " "
		set someText to text 1 thru -2 of someText
	end repeat
	
	return someText
end trim