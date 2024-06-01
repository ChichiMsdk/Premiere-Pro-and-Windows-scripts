#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
if WinExist("ahk_class MozillaWindowClass")
{
	GroupAdd, firefox, ahk_class MozillaWindowClass
	GroupActivate, firefox
	return
}

if not WinExist("ahk_class MozillaWindowClass")
{	
	Run, C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Firefox
	return
}