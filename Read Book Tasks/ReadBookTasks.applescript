set myContext to "Read"
set dateFormat to "mmddyyyy" -- choose "mmddyyyy" or "ddmmyyyy" based on your region

set bookTitle to text returned of (display dialog "What's the title of the book?" default answer "")
set numPages to text returned of (display dialog "How many pages are in the book?" default answer 0) as integer
set startDate to text returned of (display dialog "When should this start?" default answer "yyyymmdd")
set endDate to text returned of (display dialog "When should this end?" default answer "yyyymmdd")
set deferYear to text 1 thru 4 of startDate
set deferMonth to text 5 thru 6 of startDate
set deferDay to text 7 thru 8 of startDate

set endYear to text 1 thru 4 of endDate
set endMonth to text 5 thru 6 of endDate
set endDay to text 7 thru 8 of endDate

if (dateFormat = "mmddyyyy") then
	set endDateString to endMonth & "/" & endDay & "/" & endYear
	set endDate to date endDateString
	set dateString to deferMonth & "/" & deferDay & "/" & deferYear
	set deferDate to date dateString
else if (dateFormat = "ddmmyyyy") then
	set endDateString to endDay & "/" & endMonth & "/" & endYear
	set endDate to date endDateString
	set dateString to deferDay & "/" & deferMonth & "/" & deferYear
	set deferDate to date dateString
end if

set numDays to ((endDate - deferDate) div days) + 1

tell application "OmniFocus"
	tell document of front window
		set pagesPer to numPages / numDays
		set startPage to 1
		set endPage to pagesPer as integer
		set i to 2
		set taskTitle to "Read pages " & startPage & " - " & endPage & " of " & bookTitle
		set theContext to first flattened tag where its name is myContext
		set newTask to make new inbox task with properties {name:taskTitle, defer date:deferDate, primary tag:theContext}
		repeat (numDays - 1) times
			set startPage to endPage + 1
			set endPage to round (pagesPer * i) rounding up
			set taskTitle to "Read pages " & startPage & " - " & endPage & " of " & bookTitle
			set deferDate to deferDate + (60 * 60 * 24)
			set newTask to make new inbox task with properties {name:taskTitle, defer date:deferDate, primary tag:theContext}
			set i to i + 1
		end repeat
		return bookTitle & ": " & numPages
	end tell
end tell