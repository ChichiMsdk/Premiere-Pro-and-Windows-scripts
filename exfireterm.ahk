#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
  ; Ensures a consistent starting directory.
^F1::
if WinExist("ahk_class CASCADIA_HOSTING_WINDOW_CLASS")
{
	GroupAdd, WindowsTerminal, ahk_class CASCADIA_HOSTING_WINDOW_CLASS
	GroupActivate, WindowsTerminal
	return
}

if not WinExist("ahk_class CASCADIA_HOSTING_WINDOW_CLASS")
{	
	Run, C:\Users\chiha\AppData\Local\Microsoft\WindowsApps\wt.exe
	return
}

+^F1::
	Run, C:\Users\chiha\AppData\Local\Microsoft\WindowsApps\wt.exe
	return

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
	
^F3::
if WinExist("ahk_class MozillaWindowClass")
{
	GroupAdd, firefox, ahk_class MozillaWindowClass
	GroupActivate, firefox
	return
}

if not WinExist("ahk_class MozillaWindowClass")
{	
	Run, firefox
	return
}

+^F3::
	Run, firefox
	return

^F4::
if WinExist("ahk_class Window Class")
{
	GroupAdd, neovide, ahk_class Window Class
	GroupActivate, neovide
	return
}

if not WinExist("ahk_class Window Class")
{	
	Run, "C:\Users\chiha\Desktop\moiquicodedesfonctions\bg_script.vbs"
	; Run, cmd.exe "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvars64.bat" && neovide --no-vsync --size=1400x1900, C:\users\chiha\Desktop
	return
}

+^F4::
	Run, "C:\Users\chiha\Desktop\moiquicodedesfonctions\bg_script.vbs"
	; Run, cmd.exe "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvars64.bat" && neovide --no-vsync --size=1400x1900, C:\users\chiha\Desktop
	; Run, pwsh.exe neovide --no-vsync --size=1400x1900, C:\users\chiha\Desktop
	return
