on hazelProcessFile(theFile)
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
	
	-- Get the last review date for each scenario
	set lastWeeklyReview to lastWeekDay(nextWeeklyReview)
	set lastMonthlyReview to lastMonthDay(nextMonthlyReview)
	set lastAnnualReview to lastYearDay(nextAnnualReview)
	
	set projectCNT to 0
	
	tell application "OmniFocus"
		tell front document
			set theProjects to every flattened project where its status is active or its status is on hold
			repeat with projNum from 1 to length of theProjects
				
				set curProject to item projNum of theProjects
				set origReviewDate to next review date of curProject
				set reviewInterval to review interval of curProject
				set reviewUnits to unit of reviewInterval
				set reviewSteps to steps of reviewInterval
				if (reviewUnits = week and reviewSteps = 1) or (reviewUnits = day and reviewSteps = 7) then
					set curProject's last review date to lastWeeklyReview
					if curProject's next review date is not equal to origReviewDate then
						set projectCNT to projectCNT + 1
					end if
				else if (reviewUnits = month and reviewSteps = 1) then
					set curProject's last review date to lastMonthlyReview
					if curProject's next review date is not equal to origReviewDate then
						set projectCNT to projectCNT + 1
					end if
				else if (reviewUnits = year and reviewSteps = 1) then
					set curProject's last review date to lastAnnualReview
					if curProject's next review date is not equal to origReviewDate then
						set projectCNT to projectCNT + 1
					end if
				end if -- End reviewUnits
				
			end repeat -- End project loop
		end tell -- End tell for front document
	end tell -- End tell for OmniFocus
end hazelProcessFile

on nextWeekDay(curDate, weeklyDay)
	if curDate's weekday is not equal to weeklyDay then
		repeat until curDate's weekday is weeklyDay
			set curDate's day to (curDate's day) + 1
			if curDate's weekday is Saturday then set i to 1
		end repeat
	end if
	
	return curDate
end nextWeekDay

on nextMonthDay(reviewDate, monthlyDay)
	if reviewDate's day > monthlyDay then
		set reviewDate's day to 32
		set reviewDate's day to monthlyDay
	else
		set reviewDate's day to monthlyDay
	end if
	
	return reviewDate
end nextMonthDay

on nextYearDay(reviewDate, annualMonth, annualDay)
	set reviewMonthNum to reviewDate's month as integer
	set annualMonthNum to annualMonth as integer
	
	if reviewMonthNum > annualMonthNum then
		set reviewDate's year to (reviewDate's year) + 1
		set reviewDate's month to annualMonth
		set reviewDate's day to annualDay
	else if reviewMonthNum = annualMonthNum then
		if reviewDate's day > annualDay then
			set reviewDate's year to (reviewDate's year) + 1
			set reviewDate's day to annualDay
		else
			set reviewDate's day to annualDay
		end if
	else if reviewMonthNum < annualMonthNum then
		set reviewDate's month to annualMonth
		set reviewDate to nextMonthDay(reviewDate, annualDay)
	end if
	
	return reviewDate
end nextYearDay


on lastWeekDay(curDate)
	set curDate to curDate - (1 * weeks)
	return curDate
end lastWeekDay

on lastMonthDay(curDate)
	if ((curDate's month) * 1) is 1 then
		set curDate's year to (curDate's year) - 1
		set curDate's month to 12
	else
		set curDate's month to (curDate's month) - 1
	end if
	
	return curDate
end lastMonthDay

on lastYearDay(curDate)
	set curDate's year to (curDate's year) - 1
	return curDate
end lastYearDay