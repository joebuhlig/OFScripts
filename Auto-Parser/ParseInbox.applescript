tell application "OmniFocus"
	tell front document
		set theInbox to every inbox task
		if theInbox is not equal to {} then
			repeat with n from 1 to length of theInbox
				set currentTask to item n of theInbox
				set taskName to name of currentTask
				if taskName starts with "--" then
					set taskName to ((characters 3 thru -1 of taskName) as string)
					set newTask to parse tasks into with transport text taskName with as single task
					delete currentTask
				end if
			end repeat
		end if
	end tell
end tell