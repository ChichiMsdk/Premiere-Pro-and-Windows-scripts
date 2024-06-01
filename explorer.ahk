#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
^F2::
if WinExist("ahk_class CabinetWClass")
{
	GroupAdd, CabinetWClass, ahk_class CabinetWClass
	GroupActivate, CabinetWClass
	return
}

if not WinExist("ahk_class CabinetWClass")
{	
	Run, explorer
	return
}

+^F2::
	Run, explorer
	return