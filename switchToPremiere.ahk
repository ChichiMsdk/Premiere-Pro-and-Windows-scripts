Capslock::

SetTitleMatchMode, 2

If WinExist ("ahk_exe chrome.exe")

{
WinActivate, ahk_exe chrome.exe
Send ^t
}
