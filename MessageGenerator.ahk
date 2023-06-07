; CHANGE THESE VALUES

GroupRole := "Healer"
TwitchName := "SocialSlot"

; DON'T CHANGE BELOW HERE

WarLocationText := a_scriptdir "\WarLocation.txt"
WarVersusText := a_scriptdir "\WarVS.txt"
FlavorText := a_scriptdir "\FlavorTexts.txt"


;Import all the files
if FileExist(WarLocationText) {
    FileRead, WarLocation, %WarLocationText%
}
else {
	MsgBox, The War Location File does not exist or can't be found.
}

if FileExist(WarVersus) {
    FileRead, WarVersus, %WarVersusText%
}
else {
	;MsgBox, The War Versus File does not exist or can't be found.
}

if FileExist(FlavorText) {
    FileRead, fileContent, %FlavorText%
}
else {
	MsgBox, The FlavorText File does not exist or can't be found.
}


; Hotkey to send the random text
^r::
    GenerateText()
return

; Function to generate the random text
GenerateText()
{
	global GroupRole
	global TwitchName
	global WarLocation
	global WarVersus
	global FlavorText
	global fileContent

	Random, lineNum, 1, % CountLines(FlavorText)
	lines := StrSplit(fileContent, "`n")
	line := lines[lineNum]

	CombinedTexts := WarLocation " - " GroupRole " Pov | " line " | ttv/" TwitchName
	StringReplace, CombinedTexts, CombinedTexts, `r, , All
	
	send, %CombinedTexts% 
}


; Function to count the number of lines in a file
CountLines(filePath) {
    lineCount := 0
    FileRead, fileContent, %filePath%
    Loop, Parse, fileContent, `n, `r
    {
        lineCount++
    }
    return lineCount
}

#SingleInstance Force