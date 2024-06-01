#SingleInstance force 

IfWinNotExist, ahk_class After Effects
	{
	;Run, AfterFX.exe
	;Adobe Premiere Pro 2022
	; Run, C:\Program Files\Adobe\Adobe After Effects 2022\Support Files\AfterFX.exe ;if you have more than one version instlaled, you'll have to specify exactly which one you want to open.
	;Run, AfterFX.exe
	Run, C:\Program Files\Adobe\Adobe After Effects 2022\Support Files\AfterFX.exe
	}
if WinActive("ahk_class AfterFX")
	{
	IfWinNotExist, ahk_exe notepad++.exe
		{
		Run, notepad++.exe
		sleep 200
		}
	WinActivate ahk_exe notepad++.exe ;so I have this here as a workaround to a bug. Sometimes Premeire becomes unresponsive to keyboard input. (especially after timeline scrolling, especially with a playing video.) Switching to any other application and back will solve this problem. So I just hit the premiere button again, in those cases.g
	sleep 10
	WinActivate ahk_class AfterFX
	}
else
	WinActivate ahk_class AfterFX


; ; StringToSend = After direct
; ; result := Send_WM_COPYDATA(StringToSend, TargetScriptTitle)

; ; switchToPremiere()

Exitapp


; ; SetWorkingDir %A_ScriptDir%
; ; #Include %A_ScriptDir%/REDIRECTOR Windows.ahk

