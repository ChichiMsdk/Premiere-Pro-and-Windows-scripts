#NoEnv  
SendMode Input 
SetWorkingDir %A_ScriptDir% 


;Made by Chichimsdk and inspired by the instantVFX() function from Taran that I found way too complex

;This script is really useful only in combination with the hottextfix from taran. Otherwise it would require big mouse sensitivy to
;manipulate the hottext properly and many movements which makes it... not really efficient.

;You can quickly move from script to script by simply pressing the hotkey, even quickly (works 95% of the time)
;If you were too rapid then just resets one value and then keep going

;WHENEVER CHANGING POSITION OR SIZE NEEDS TO REDO!!!!!
;Rotation is the exact same script but only need to change the coord of its hottext
;Could be done with opacity also I guess..

;Done on 4K monitor 150% UI and effect controls panel on the upper right of the premiere pro window
;The panel must be active at all time otherwise all of this is pointless
;Tried to use the api instead but haven't succeeded yet...

;Selection follows playhead doesn't work AT ALL (adobe things I guess) so needs to select the clip MANUALLY everytime
;Boring.
;Feel free to add code related to this functionality if "Selection follows playhead" works for you, I'll add it myself
;when it's on again..

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive ahk_class Premiere Pro

;Scale button

XButton1::

BlockInput, MouseMove ;makes the script more "robust" but could be done without it if not moving the mouse AT ALL !


;  Send, {LButton} ;; to select the clip at the same time ( barely useful )



MouseGetPos, startX, startY

MouseMove,2673,273, 0      ;arrow key position pixel must be really important to check

PixelGetColor, color, 2673,  273   ;checks the color of the specific pixel (f.lux changes it ? seems like no but care)

;;seems like you can check different coord for pixel color so maybe its easier to check if there is
;;"blue" somewhere which would mean that panel is open?..

;  msgbox, color(%color%) ;;to check the color
 
IfEqual, color, 0x1D1D1D    ;if it's this one then click left otherwise keep going (varies drastically upon changing UI,DPI, etc..)
  {
    Send, {LButton}
  }


MouseMove, 2870, 331, 0  ;goes to the hottext

Click down left          ;selects the hottext before being able to modify values

Sleep, 50                ;must sleep here otherwise won't perform "enter" properly

GetKeyState, stateFirstCheck,XButton1, P   ;retrieves the current state of the key (either up or down)


  if stateFirstCheck = U        ;if up then ..all of this is meant to either reset to the value wanted previously or maybe input the desired values
    {                           ;by simpling pressing numbers then enter which would end the script
      Click up left           
      Sleep, 50
      Send, 100
      Sleep, 50
      Send, {enter}
      Sleep, 50
      MouseMove, startX, startY, 0  ;sends the mouse back to where it was first
      BlockInput, MouseMoveOff
      Return
    } 


BlockInput, MouseMoveOff           ;gives back control to adjust the size/position/rotation


Loop,                              ;checks if the key is still pressed, if not then leaves the loop and ends it
{

  GetKeyState, state,XButton1, P

    if state = U
      {
      Click up left                     ;the hottext is no longer selected
      MouseMove, startX, startY, 0
      Return 
      }
 
}





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; rotation  button

XButton2::

BlockInput, MouseMove

;  Send, {LButton}
MouseGetPos, startX, startY

 MouseMove,2673,273, 0

 PixelGetColor, color, 2673,  273
;  msgbox, color(%color%)
 
  IfEqual, color, 0x1D1D1D 
{
  Send, {LButton}
}

MouseMove, 2860, 434, 0

Click down left

Sleep, 50

GetKeyState, stateFirstCheck,XButton2, P

  if stateFirstCheck = U 
    {
      Click up left
      Sleep, 50
      Send, 0
      Sleep, 100
      SendInput, {Enter}
      Sleep, 100
      MouseMove, startX, startY, 0
      BlockInput, MouseMoveOff
      Return
    } 

BlockInput, MouseMoveOff

Loop,
{

  GetKeyState, state,XButton2, P

    if state = U
      {
      Click up left
      MouseMove, startX, startY, 0
      Return 
      }
 
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;position, a bit different but the idea remains the same
;issue here is that it clicks on program monitor to move the video but won't work if the so called video
;is too small or off position so need to do it manually or reset position values and perform again unfortunately..

F17::

BlockInput, MouseMove

;  Send, {LButton}

MouseGetPos, startX, startY

 MouseMove,2673,273, 0

 PixelGetColor, color, 2673,273
;  msgbox, color(%color%)
 
  IfEqual, color, 0x1D1D1D 
{
  Send, {LButton}
}

MouseClick, Left, 2788, 270, 1, 0

Sleep, 50

GetKeyState, stateFirstCheck,F17, P


  if stateFirstCheck = U 
    {
      ; Click up left
      MouseClick, left, 2881, 300, 1, 0
      Send, 960
      Sleep, 50
      MouseClick, left, 2948, 311, 1, 0
      Send, 540
      Sleep, 50
      Send, {enter}
      Sleep, 50
      MouseMove, startX, startY, 0
      BlockInput, MouseMoveOff
      Return
    } 

MouseMove, 1730, 400, 0
Click down left
BlockInput, MouseMoveOff
Loop,
{
GetKeyState, state,F17, P

 if state = U 
    {
    Click up Left

    Return
    }
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; crop effect could be done the same, looking to add it in the future might be a bit more complex since there is multiple
;;hottexts...

