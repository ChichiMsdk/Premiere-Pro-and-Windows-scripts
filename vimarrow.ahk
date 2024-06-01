flag := false 
+Alt:: flag := !flag 
#If (flag)
	;display a tool tip
	; ToolTip , VIM MODE, 3037, 382
	if(flag)
		ToolTip , "VIM MODE"
	h::left
	j::down
	k::up
	l::right
	u::home
	i::end
#If
