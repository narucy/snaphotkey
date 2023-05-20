#Requires AutoHotkey v2.0

; at own your risk -- I do recommend to stop script while accessing shop

F5:: Reload

SNAP_EXE := A_ProgramFiles . " (x86)\Steam\steamapps\common\MARVEL SNAP\SNAP.exe"
UNTAPPED_EXE := EnvGet("LocalAppData") . "\Programs\untapped-companion\Untapped.gg Companion.exe"

SNAP_Click(x, y) {
    MouseGetPos( , , &id)
    if WinGetTitle("ahk_id" . id) != "SNAP" {
        return
    }

    WinGetPos( , , &width, &height, "ahk_id" . id)

    board_width := height * 3 / 4
    x := (width - board_width) / 2 + board_width * x
    y := height * y

    Click x, y
}

#HotIf WinActive("ahk_exe SNAP.exe")
MButton:: SNAP_Click(0.85, 0.9)
; XButton1:: SNAP_Click(0.5, 0.9)
XButton1:: Esc
XButton2:: {
    SNAP_Click(0.9, 0.1)
    SNAP_Click(0.8, 0.25)
    SNAP_Click(0.5, 0.5)
}
F1:: {
    ; WinMove (1920 - 772) / 2, 5, 772, 1045, "A"
    WinMove (1920 - 788) / 2, 05, 788, 1080, "A"
}
F2:: {
    WinMove (1920 - 1755) / 2, 10, 1755, 1024, "A"
}
!F4:: {
    ProcessClose("SNAP.exe")
}

#HotIf

TraySetIcon("snaphotkey.ico")

if ProcessExist("Untapped.gg Companion.exe") == 0 {
    Run UNTAPPED_EXE
    if WinWait("ahk_exe Untapped.gg Companion.exe", , 5) {
        WinClose("ahk_exe Untapped.gg Companion.exe")
    }
}

if ProcessExist("SNAP.exe") == 0 {
    Run SNAP_EXE
}

ProcessWaitClose("SNAP.exe")
ProcessClose("Untapped.gg Companion.exe")

ExitApp
