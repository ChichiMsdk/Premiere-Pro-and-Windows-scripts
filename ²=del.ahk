²::
Send {Delete}
return

;while alt + shift is pressed down, the following keys are remapped : h = left, j = down, k = up, l = right, u = home, i = end

if(GetKeyState("LShift", "P")  && GetKeyState("LAlt", "P")) {
	while(GetKeyState("LShift", "P")  && GetKeyState("LAlt", "P")) {
		h::left
		j::down
		k::up
		l::right
		u::home
		i::end
		if (!GetKeyState("LShift", "P") || !GetKeyState("LAlt", "P"))
			break
	}
	return
}

; ;alt + k = arrow up
; !k::
; Send {Up}
; return
; ;alt + j = arrow down
; !j::
; Send {Down}
; return
; ;alt + h = arrow left
; !h::
; Send {Left}
; return
; ;alt + l = arrow right
; !l::
; Send {Right}
; return

; ;alt + u = home
; !u::
; Send {Home}
; return
; ;alt + i = end
; !i::
; Send {End}
; return

; CapsLock::	
; 	KeyWait CapsLock, T0.2
; 	if ErrorLevel
; 		Send ^x
; 	elses
; 		{
; 		KeyWait CapsLock, D T0.2
; 		if ErrorLevel
; 			Send ^c
; 		else
; 			Send ^v
; 		}
; 	KeyWait CapsLock
; return

; Shift::
;     KeyWait, Shift
;     KeyWait, Shift, D T0.2		
;     if ErrorLevel 
;         Send {Shift}
;     Else
;         SetCapsLockState % !GetKeyState("CapsLock", "T") 
; Return


