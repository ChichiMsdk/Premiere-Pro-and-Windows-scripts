; Define the hotkey to toggle between the two key presses
;NumpadDown::
^+!3::
SetFormat, Integer, H
WinGet, WinID,, A
ThreadID:=DllCall("GetWindowThreadProcessId", "UInt", WinID, "UInt", 0)
InputLocaleID:=DllCall("GetKeyboardLayout", "UInt", ThreadID, "UInt")
    if (InputLocaleID == 0x80C080C ) {
        Send, ^+2 ; Presses ctrl+shift+2
    }
    else if (InputLocaleID == 0x4110411 ) {
        Send, ^+3 ; Presses Ctrl+Shift+3
    }
	else {
		Send, ^+1 ; Presses Ctrl+Shift+1
		}

Return
