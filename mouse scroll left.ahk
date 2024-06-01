#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Shift + Wheel scrolles left / right

+WheelDown::WheelRight
+WheelUp::WheelLeft


; Overwrites the apostrophe key to be actually usefull without dumb extra key presses
    ;SC00D::
    ;String := "`` "
    ;SendRaw %String%
    ;return