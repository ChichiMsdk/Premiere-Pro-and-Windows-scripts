#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
;#If GetKeyState("NumLock","T")
; T = active/exists

F20::^F1
return

<+F20::+^F1
return

F21::^F2
return

<+F21::+^F2
return

F22::^F3
return

<+F22::+^F3
return

F24::^F4
return

<+F24::+^F4
return

F18::^F5
return

<+F18::+^F5
return

F19::^F6
return

<+F19::+^F6
return

;NumpadDel::
;Run, powershell.exe -command "ssh chichi-i3"
;return

; vk33 = " or 3 open/cycle powerhsell.exe/terminal

; vk32 = e accent or 2 open/cycle explorer

;^F4::
;Send, {Alt down}{Tab down}{Alt up}{Tab up}
;return

;vk34 = ' or 4 open/cycle notes
;NumpadSub::
;Send, {RCtrl down}{RWin down}{vk34}{RWin up}{RCtrl up}
;return
;
;NumpadEnter::
;Send, {LCtrl down}{Tab}
;Send, {LCtrl up}
;return
;
;NumpadAdd::
;Send, {LCtrl down}{LShift down}{Tab}
;Send, {LCtrl up}{LShift up}
;return
;;
;opens powershell and using the command "ssh chichi@192.168.1.23" to connect to my server


;;
;Numpad7::
;shutdowns the computer
;Shutdown, 1

;;;;;;not supported so not necessary

;+NumpadSub::
;Send, {LShift down}{RWin down}{vk34}{RWin up}{LShift up}
;return

;NumpadMult::
;Reload
;return

