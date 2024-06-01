#IfWinActive ahk_exe neovide.exe
^F5::
if WinExist("ahk_class CASCADIA_HOSTING_WINDOW_CLASS")
{
	GroupAdd, WindowsTerminal, ahk_class CASCADIA_HOSTING_WINDOW_CLASS
	GroupActivate, WindowsTerminal
	sleep 20
	Send make{enter}
	return
}

if not WinExist("ahk_class CASCADIA_HOSTING_WINDOW_CLASS")
{	
	Run, C:\Users\chiha\AppData\Local\Microsoft\WindowsApps\wt.exe
	sleep 2000
	Send make{enter}
	return
}

+^F5::
if WinExist("ahk_class CASCADIA_HOSTING_WINDOW_CLASS")
{
	GroupAdd, WindowsTerminal, ahk_class CASCADIA_HOSTING_WINDOW_CLASS
	GroupActivate, WindowsTerminal
	sleep 20
	Send make run{enter}
	return
}

if not WinExist("ahk_class CASCADIA_HOSTING_WINDOW_CLASS")
{	
	Run, C:\Users\chiha\AppData\Local\Microsoft\WindowsApps\wt.exe
	sleep 2000
	Send make run{enter}
	return
}
