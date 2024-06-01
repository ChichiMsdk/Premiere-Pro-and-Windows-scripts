;If you don't want to use Rbutton (the right mouse button), then you don't need to check for colors and things. This simplifies the script siginificantly.
;In the following script, You can change "Mbutton" to anything else. like "Xbutton1", or  even "F12" if you wanted.
;So, assuming you've mapped "move playhead to cursor" to the \ key, the problem is that it fires once, waits 1 second, and only then does it continue to fire.
;that's why I use a loop - to send constant keypresses, for a smooth experience.
;SCRIPT HAS NOT YET BEEN TESTED BY ME.

;;;;;Mbutton::\ ;<----this would be the STUPID way of doing this. BAD BAD BAD! do not want!
#ifwinactive ahk_exe adobe premiere pro.exe
F14::
 if GetKeyState("F12", "P") = 1
		 {
		 loop
			 {
			 Send à ;in premiere, this must be set to "move playhead to cursor."
			 Tooltip, button 5 playhead mod!
			 sleep 16 ;this loop will repeat every 16 milliseconds.
			 if GetKeyState("F12", "P") = 0
				 {
				 ;msgbox,,,time to break,1
				 tooltip,
				 goto theEnd2
				 break
				 }
			 }
 }
 theEnd2:
 Return


