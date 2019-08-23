set notesDirectory to "/Users/joebuhlig/notes.joebuhlig/notes/"
set projectsFileName to "project-codes.md"
tell application "Finder"
	if exists (notesDirectory & projectsFileName) as POSIX file then
	else
		do shell script "echo '' > " & quoted form of (the POSIX path of (notesDirectory & projectsFileName))
	end if
end tell

set projectsFilePath to (the POSIX path of (notesDirectory & projectsFileName))

set projectsList to last item of (read projectsFilePath using delimiter linefeed)
if projectsList is not equal to "" then
	set oldDelimiters to AppleScript's text item delimiters
	set AppleScript's text item delimiters to " | "
	set dateCode to first text item of projectsList
	set AppleScript's text item delimiters to "-"
	set existingYear to text 3 thru 6 of (first text item of dateCode)
	set existingCode to last text item of dateCode
	set AppleScript's text item delimiters to oldDelimiters
else
	set existingYear to "1900"
end if
set currentYear to year of (current date) as string
if existingYear = currentYear then
	set newNumber to "0000" & ((existingCode as number) + 1) as string
	set numberString to text ((length of newNumber) - 3) thru (length of newNumber) of newNumber
else
	set numberString to "0001"
end if

set newCode to currentYear & "-" & numberString
set projectName to "%filltext:name=field 1%"

set projectText to newCode & " | " & projectName
do shell script "echo " & (quoted form of ("[[" & projectText & "]]")) & " >> " & (quoted form of projectsFilePath)
do shell script "echo '' > " & notesDirectory & quoted form of projectText & ".md"
return projectText
