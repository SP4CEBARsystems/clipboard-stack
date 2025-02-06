#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

global register := []

showIndicator()

!c::copyToRegister()
!v::pasteFromRegister()

copyToRegister()
{
	global register
	Clipboard := ""
	send ^c
	ClipWait, 5 ; Wait for max. 5 seconds
	register.Push(clipboard)
	updateIndicator()
}

pasteFromRegister()
{
	global register
	global bank
	clipboard := register.Pop()
	send ^v
	updateIndicator()
}

showIndicator(){
	; source: https://www.autohotkey.com/boards/viewtopic.php?style=1&t=96934#p430774
	global vMyEdit
	Gui, +LastFound +AlwaysOnTop
	Gui, % CLICKTHROUGH := "+E0x20"
	Gui, Color, F0F0F0
	Gui, Font, s0,
	Gui, Add, Edit, vMyEdit w200 h220 -E0x200
	Gui, Font, s15, Verdana
	updateIndicator()
	Gui, Show, x1600 y100 NoActivate
}

updateIndicator(){
	global register
	global MyEdit
	contents := ""
	For index, value in register
		contents .= register.Length() - index + 1 . ": " . value . "`n"
	If (contents = "")
	{
		contents := "Your clipboard is empty. When you use alt + c to copy multiple things they will appear here. Use alt + v to paste the bottom item."
	}
	GuiControl,, MyEdit, %contents%
}