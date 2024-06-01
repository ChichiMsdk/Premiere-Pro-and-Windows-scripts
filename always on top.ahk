#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
#NoEnv
; #NoTrayIcon
SetBatchLines, -1
SetWinDelay, 0
ToggleOnTop := new ToggleAlwaysOnTop( Func("Filter") )
Return

^SPACE:: ToggleOnTop.Toggle()

Filter(hWnd) {
   WinGetClass, winClass, ahk_id %hWnd%
   ; filter taskbar and desktop, some windows could be added
   if (winClass ~= "^(Shell_TrayWnd|Progman|WorkerW)$")
      Return true
}
     
class ToggleAlwaysOnTop
{
   EVENT_OBJECT_HIDE           := 0x8003
 , EVENT_OBJECT_LOCATIONCHANGE := 0x800B
   
   __New(Filter) {
      this.Filter := Filter
      this.Markers := {}
      this.Hook := new WinEventHook( this.EVENT_OBJECT_HIDE
                                   , this.EVENT_OBJECT_LOCATIONCHANGE
                                   , ObjBindMethod(this, "WatchWindows") )
   }
   
   Toggle() {
      static WS_EX_TOPMOST := 0x8
      
      hWnd := WinExist("A")
      if this.Filter.Call(hWnd)
         Return

      WinSet, AlwaysOnTop
      WinGet, styles, ExStyle
      if (styles & WS_EX_TOPMOST)
         this.CreateMarker(hWnd)
      else
         this.RemoveMarker(hWnd)
   }
   
   CreateMarker(ownerID) {
      static DWMWA_EXTENDED_FRAME_BOUNDS := 9
      WinGetPos, X, Y
      dX := dY := 0
      VarSetCapacity(RECT, 16, 0)
      if DllCall("Dwmapi\DwmGetWindowAttribute", "Ptr", ownerID, "UInt", DWMWA_EXTENDED_FRAME_BOUNDS, "Ptr", &RECT, "UInt", 16) = 0
         dX := NumGet(RECT, "Int") - X, dY := NumGet(RECT, 4, "Int") - Y
      Gui, New, -Caption +AlwaysOnTop +ToolWindow +Disabled +hwndhGui +Owner%ownerID%
      Gui, Color, Red
      Gui, Show, % "NA x" . X + dX + 5 . " y" . Y + dY + 5 . " w10 h10"
      this.Markers[ownerID] := {m: hGui, dx: dX, dy: dY}
   }
   
   RemoveMarker(hWnd) {
      if this.Markers.HasKey(hWnd)
         Gui, % this.Markers.Delete(hWnd).m . ": Destroy"
   }
   
   WatchWindows(hWinEventHook, event, hwnd, idObject, idChild, idEventThread, dwmsEventTime) {
      static OBJID_WINDOW := 0
      if (idObject != OBJID_WINDOW)
         Return
      
      if (event = this.EVENT_OBJECT_HIDE)
         this.RemoveMarker(hwnd)
      
      if (event = this.EVENT_OBJECT_LOCATIONCHANGE) {
         if this.Markers.HasKey(hwnd) {
            WinGetPos, X, Y,,, ahk_id %hwnd%
            o := this.Markers[hwnd]
            try Gui, % o.m . ": Show", % "NA x" . X + o.dx + 5 . " y" . Y + o.dy + 5
         }
      }
   }
}

class WinEventHook
{
   __New(eventMin, eventMax, hookProc, idProcess := 0, idThread := 0, dwFlags := 0) {
      this.hHook := DllCall("SetWinEventHook", "UInt", eventMin, "UInt", eventMax
                                             , "Ptr", 0, "Ptr", CallbackCreate(hookProc, "F", 7)
                                             , "UInt", idProcess, "UInt", idThread, "UInt", dwFlags, "Ptr")
   }
   __Delete() {
      DllCall("UnhookWinEvent", "Ptr", this.hHook)
   }
}

CallbackCreate(Function , Options := "", ParamCount := ""){
   ; Address := CallbackCreate(Function , Options := "", ParamCount := Function.MinParams)
   ; see: https://lexikos.github.io/v2/docs/commands/CallbackCreate.htm
   ; Note that the v2 version doesn't affect A_EventInfo, this version does.
   /*
   This function fails when:
   Function is not an object or a valid function name.
   Function has a MinParams property which exceeds the number of parameters that the callback will supply.
   ParamCount is negative.
   ParamCount is omitted and: 1) Function has no MinParams property; or 2) the & option is used with the standard 32-bit calling convention.
   */
   local
   ; Input validation start. This is partly 'ported' from BIF_CallbackCreate (a097)
   if (!io := isobject(Function)) && !isfunc(Function)
      throw exception("Parameter #1 invalid.", -1)
   
   fn := "" ; If a function name was passed, retrieve the function reference below.
   minparams := ( io ? Function : fn := func(Function) ).MinParams 
   
   if (minparams != "")   
      if minparams is not number   ; if the MinParams property doesn't return a number, minparams is 0.
         minparams := 0
   has_minparams := minparams != "" ? true : false
   minparams := has_minparams ? minparams : 0
   
   use_cdecl := instr(options, "C")
   
   require_param_count := a_ptrsize == 4 && !use_cdecl
   pass_params_pointer := instr(options, "&", true)
      
   if (ParamCount != "") {
      actual_param_count := ParamCount
      if ( actual_param_count < 0 || ( has_minparams && (pass_params_pointer ? 1 : actual_param_count) < minparams ) )
         throw exception("Parameter #3 invalid.", -1)
   } else if (!has_minparams || (pass_params_pointer && require_param_count)) {
      throw exception("Parameter #3 must not be blank in this case.", -1)
   } else {
      actual_param_count := minparams
   }
   if (a_ptrsize == 4 && (!use_cdecl && actual_param_count > 31) )
      throw exception("Parameter #3 invalid.", -1)
   ; Input validation end.
   
   Function := io ? Function : fn ; Make sure Function is a function reference and not just a name, avoids finding the reference on each callback.
   
   cbo := {    actual_param_count : actual_param_count         ; Callback object, its address is passed to the callback router vi a_eventinfo
         ,   pass_params_pointer : pass_params_pointer
         ,    Function : Function } 
   
   if (fn && !pass_params_pointer && !fn.isvariadic) {
      ; Meaning the name of a non variadic function was passed as Function, and not using the '&' option.
      ; No need to route the callback.
      cb := registercallback(fn.name, options, actual_param_count)
   } else {
      ; A Function object or name of a variadic function or '&' option was passed. Needs to route the callback
      static router_fn := "__callbackcreate_router__"
      cb := registercallback(router_fn, options, actual_param_count, &cbo)
   }
   if !cb   ; Hopefully, this shouldn't happen
      throw exception("registercallback failed")   
      
   objaddref( &cbo )      ; This is decremented in CallbackFree when freeing the callback.
   CallbackFree(cbo, cb)   ; Add to cache.
   return cb            ; Return the callback address
}

CallbackFree(Address, cb := "")   {
   ; Address, the address to free.
   ; cb, internal use, always omit. Used for setting/getting callback functions
   ; see: https://lexikos.github.io/v2/docs/commands/CallbackCreate.htm
   static callback_cache := []   ; Contains all callback objects.
   if cb { ; add to cache
      if isobject(Address)
         return callback_cache[ cb ] := Address
      throw exception("?")
   }
   if address is not number
      address := 0
   if (address < 65536 && address >= 0)
      throw exception("Parameter #1 invalid.", -1)
   ; Free the address and callback object.
   dllcall("GlobalFree", "Ptr", Address, "Ptr")
   objrelease( &callback_cache.delete( Address ) )
   return
}

__callbackcreate_router__(p*) {   
   ; Help function.
   ; Routes all callbacks.
   ; Since this function is variadic, all parameters are passed by address.
   static p_type := a_ptrsize == 4 ? "uint" : "int64"
   local
   cbo := object( a_eventinfo )   ; a_eventinfo contains the address of the callback object.
   if !cbo.pass_params_pointer {   ; The '&' option was not used, fetch all parameters and pass directly to the script callback.
      args := []
      loop % cbo.actual_param_count
         args.push( numget(p+0, a_ptrsize * (a_index-1), p_type) )
   } else {                  ; using the "&" option, just pass the pointer to the arguments to the script callback.
      args := [p]
   }
   return cbo.function.call( args* )   ; Call script callback
}