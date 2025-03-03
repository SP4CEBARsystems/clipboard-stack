#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

global register := []
; global shouldIgnoreNextClipboardChange = false

showIndicator()

#Persistent
OnClipboardChange("pushClipboardToRegister")
return

!c::copyToRegister()
!v::popFromRegister()
; ^v::pasteFromRegister()s

pushClipboardToRegister()
{
	; global shouldIgnoreNextClipboardChange
	; if (shouldIgnoreNextClipboardChange) {
	; 	shouldIgnoreNextClipboardChange = false
    ;     return
    ; }
	global register
	register.Push(clipboard)
	updateIndicator()
}

pasteText(text)
{
	SendInput % text
	; ControlSend,, %text%, A
	; global shouldIgnoreNextClipboardChange = true
	; shouldIgnoreNextClipboardChange = true  ; Disable monitoring
    ; savedClip := ClipboardAll      ; Backup existing clipboard
    ; Clipboard := text              ; Set clipboard to text
    ; ClipWait, 1                    ; Ensure clipboard is set
    ; Send, ^v                       ; Paste
    ; Sleep, 50                      ; Short delay to ensure paste completes
    ; Clipboard := savedClip          ; Restore clipboard
}

copyToRegister()
{
	Clipboard := ""
	send ^c
	ClipWait, 5 ; Wait for max. 5 seconds
	pushClipboardToRegister()
}

; unShiftClipboardToRegister()
; {
; 	global register
; 	register.Push(clipboard)
; 	updateIndicator()
; }

pasteFromRegister()
{
	global register
	pasteText( register[register.MaxIndex()] )
	updateIndicator()
}

popFromRegister()
{
	global register
	pasteText( register.Pop() )
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
	For index, value in register {
		displayedIndex := register.Length() - index + 1
		; ifequal displayedIndex,1,
		; (displayedIndex = 1 ? ">" : displayedIndex)
		If (displayedIndex = 1){
			contents .= displayedIndex . ": > " . value . " < `n"
		} Else {
			contents .= displayedIndex . ": " . value . "`n"
		}
	}
	If (contents = "")
	{
		contents := "Your clipboard is empty. When you use alt + c to copy multiple things they will appear here. Use alt + v to paste the bottom item."
	}
	GuiControl,, MyEdit, %contents%
}