
F17::
MouseGetPos, x, y

if (GetKeyState("LButton","P"))
{
    WinGet, hWnd, ID, A, ControlUnderMouse
    WinGet, exStyle, ExStyle, ahk_id %hWnd%
    if (exStyle & 0x00000080)
    {
        WinSet, Style, -0x00000080, ahk_id %hWnd%
        WinMove, ahk_id %hWnd%, ,, x, y, WinGet, w, h, ahk_id %hWnd%
        WinSet, Style, 0x00000080, ahk_id %hWnd%
    }
    else
        WinMove, ahk_id %hWnd%, ,, x, y
}
else if (GetKeyState("RButton","P"))
{
    WinGet, hWnd, ID, A, ControlUnderMouse
    WinGet, Style, Style, ahk_id %hWnd%
    if (Style & 0x00000001)
        WinSet, Style, Style - 0x00000001
    WinGetPos, x, y, w, h, ahk_id %hWnd%
    WinGet, exStyle, ExStyle, ahk_id %hWnd%
    if (exStyle & 0x00000080)
    {
        WinSet, Style, -0x00000080, ahk_id %hWnd%
        WinSet, Resize, WidthxHeight, %x%, %y%, x+w, y+h
        WinSet, Style, 0x00000080, ahk_id %hWnd%
    }
    else
        WinSet, Resize, WidthxHeight, %x%, %y%, x+w, y+h
}
return