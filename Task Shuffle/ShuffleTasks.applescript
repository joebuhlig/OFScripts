tell application "OmniFocus"
	tell front document
		tell document window 1 -- (first document window whose index is 1)
			set selectedProjects to selected trees of content
			if ((count of selectedProjects) ­ 1) then
				-- try sidebar selection
				set selectedProjects to selected trees of sidebar
			end if
		end tell
		if ((count of selectedProjects) < 1) then
			display alert "You must first select the project to shuffle." message "Select a single project that you want to shuffle." as warning
			return
		end if
		repeat with projNum from 1 to count of selectedProjects
			set selectedProject to value of item projNum of selectedProjects
			set projectName to name of item 1 of selectedProjects
			if (class of selectedProject is not project) then
				display alert "The selected item, Ò" & projectName & "Ó is not a project." message "The script only works with projects, not actions or folders.  Please select a project to use the script." as warning buttons {"OK"} default button 1
				return
			end if
			set projTasks to (tasks of selectedProject where its completion date is missing value)
			repeat with taskNum from 1 to count of projTasks
				set randomNum to random number from 1 to count of projTasks
				move item randomNum of projTasks to beginning of tasks of selectedProject
			end repeat
		end repeat
	end tell
end tell

