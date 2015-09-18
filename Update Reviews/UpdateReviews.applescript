-- weeklyReviewDay is the day of the week of your Weekly Review.
set weeklyReviewDay to Friday

-- monthlyReviewDay is the day of the month of your Monthly Review.
set monthlyReviewDay to 1

-- annualReviewMonth is the month of your Annual Review.
set annualReviewMonth to January

-- annualReviewDay is the day of the month for your Annual Review.
set annualReviewDay to 1

-- Get the current date as a base for new review dates
set nextWeeklyReview to current date
set nextMonthlyReview to current date
set nextAnnualReview to current date

-- Get the next available review date for each scenario
set nextWeeklyReview to nextWeekDay(nextWeeklyReview, weeklyReviewDay)
set nextMonthlyReview to nextMonthDay(nextMonthlyReview, monthlyReviewDay)
set nextAnnualReview to nextYearDay(nextAnnualReview, annualReviewMonth, annualReviewDay)

-- Confirm that the user wants to move forward with this
set question to display dialog "The next review dates of your projects will be adjusted.

Review intervals of:
Once weekly will be " & date string of nextWeeklyReview & "
Once monthly will be " & date string of nextMonthlyReview & "
Once yearly will be: " & date string of nextAnnualReview & "

Are you sure you want to do this?" buttons {"Yes", "No"} default button 2
set answer to button returned of question

-- If they say No, cancel the remainder of the script
if answer is equal to "No" then
	return
end if

-- Create the increment counter for the notification at the end
set projectCNT to 0

tell application "OmniFocus"
	tell front document
		-- Get all the projects
		set theProjects to every flattened project
		-- Loop through the list of projects
		repeat with projNum from 1 to length of theProjects
			
			-- Get the current project
			set curProject to item projNum of theProjects
			-- Get the next review date of the project
			set origReviewDate to next review date of curProject
			-- Get the review interval of the project
			set reviewInterval to review interval of curProject
			-- Get the units from the review interval of the project
			set reviewUnits to unit of reviewInterval
			-- Get the number of steps from the review interval of the project
			set reviewSteps to steps of reviewInterval
			-- Time to get to work
			if (reviewUnits = week and reviewSteps = 1) or (reviewUnits = day and reviewSteps = 7) then -- If the project is reviewed weekly...
				-- Apply the new review date to the project
				set curProject's next review date to nextWeeklyReview
				-- If the review date has changed, increment the counter by one
				if curProject's next review date is not equal to origReviewDate then
					set projectCNT to projectCNT + 1
				end if
			else if (reviewUnits = month and reviewSteps = 1) then -- If the project is reviewed monthly...
				-- Apply the new review date to the project
				set curProject's next review date to nextMonthlyReview
				-- If the review date has changed, increment the counter by one
				if curProject's next review date is not equal to origReviewDate then
					set projectCNT to projectCNT + 1
				end if
			else if (reviewUnits = year and reviewSteps = 1) then -- If the project is review annually...
				-- Apply the new review date to the project
				set curProject's next review date to nextAnnualReview
				-- If the review date has changed, increment the counter by one
				if curProject's next review date is not equal to origReviewDate then
					set projectCNT to projectCNT + 1
				end if
			end if -- End reviewUnits check
			
		end repeat -- End project loop
	end tell -- End tell for front document
end tell -- End tell for OmniFocus

display notification "All done" with title "OFScripts: Update Reviews" subtitle (projectCNT as string) & " projects updated"

on nextWeekDay(curDate, weeklyDay) -- (Starting Date, Weekday) - Returns a date
	-- If the current date's weekday isn't correct
	if curDate's weekday is not equal to weeklyDay then
		-- Add a day at a time until the required weekday is reached
		repeat until curDate's weekday is weeklyDay
			set curDate's day to (curDate's day) + 1
			-- Reset at the end of the week to go into the next. 
			if curDate's weekday is Saturday then set i to 1
		end repeat
	end if
	
	-- Return the new date
	return curDate
end nextWeekDay

on nextMonthDay(reviewDate, monthlyDay) -- (Starting Date, Day of Month) - Returns a date
	-- If the review date is past the monthlyReviewDay
	if reviewDate's day > monthlyDay then
		-- Set the day to 32 to make it roll into the next month
		set reviewDate's day to 32
		-- Set the day to the correct day of the month
		set reviewDate's day to monthlyDay
	else -- If the review date is not past the monthlyReviewDay
		-- Set the day to the correct day of the month
		set reviewDate's day to monthlyDay
	end if
	
	-- Return the new date
	return reviewDate
end nextMonthDay

on nextYearDay(reviewDate, annualMonth, annualDay) -- (Starting Date, Month, Day of Month) - Returns a date
	-- Convert the next review month to a number
	set reviewMonthNum to reviewDate's month as integer
	-- Convert the annual review month to a number
	set annualMonthNum to annualMonth as integer
	
	-- If the review month is past the annualReviewMonth...
	if reviewMonthNum > annualMonthNum then
		-- Set the year for next year
		set reviewDate's year to (reviewDate's year) + 1
		-- Set the month to the annualReviewMonth
		set reviewDate's month to annualMonth
		-- Set the day to the annualReviewDay
		set reviewDate's day to annualDay
	else if reviewMonthNum = annualMonthNum then -- If the review month is correct...
		-- Set the correct day of the month
		set reviewDate to nextMonthDay(reviewDate, annualDay)
	else if reviewMonthNum < annualMonthNum then -- If the annual review month is later than the next review month...
		-- Set the correct month
		set reviewDate's month to annualMonth
		-- Set the correct day of the month
		set reviewDate to nextMonthDay(reviewDate, annualDay)
	end if
	
	-- Return the new date
	return reviewDate
end nextYearDay