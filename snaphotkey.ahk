#Requires AutoHotkey v2.0

; at own your risk -- I know you are concerned so please check the entire
; script before using it.

SNAP_EXEC := "steam://rungameid/1997040"
UNTAPPED_EXE := EnvGet("LocalAppData") . "\Programs\untapped-companion\Untapped.gg Companion.exe"

SNAP_Click(x, y, btn) {
    MouseGetPos( , , &id)
    if WinGetTitle("ahk_id" . id) != "SNAP" {
        return
    }

    WinGetPos( , , &width, &height, "ahk_id" . id)
    style := WinGetStyle("ahk_exe SNAP.exe")

    x_offset := 0
    y_offset := 0
    if ((style & 0xC40000) != 0) {
        width -= 16
        height -= 39

        x_offset := 8
        y_offset := 31
    }
    x := width * x
    y := height * y

    Click x_offset + x, y_offset + y, btn
}

#F1:: Run "https://snap.untapped.gg/en/meta/decks?collectionLevel=pool3p&minGames=200&missingCards=12&playerRank=AllRanks&rankRange=70-70&sort=GameCount&timeFrame=Last7DaysNoHotLocation"
#F2:: Run "https://snap.untapped.gg/en/profile/f1499c50-8410-44d1-a474-a3633eb93595/cc1eb9dc-5dbc-4c05-a9c7-91d4ecad3cbe?playerRank=AllRanks&profileViewMode=matchups&rankRange=10-100&sortBy=mostRecent&timeRange=last7days"
#F4:: Run "https://marvelsnapzone.com/tier-list/"
#F5:: Reload
#F6:: {
    SendMode "Event"
    SetDefaultMouseSpeed 0
    MouseMove(13, 830)
    SetDefaultMouseSpeed 20
    MouseClickDrag("Left", 13, 830, 13, 300)
    SetDefaultMouseSpeed 0
    MouseMove(13, 830)
}

#HotIf WinActive("ahk_exe SNAP.exe")
MButton:: SNAP_Click(0.85, 0.925, "Left")
; XButton1:: SNAP_Click(0.5, 0.9)
XButton1:: SNAP_Click(0.5, 0.9, "Left")
XButton2:: {
    SNAP_Click(0.9, 0.1, "Left")
    SNAP_Click(0.67, 0.29, "Left")
    ; SNAP_Click(0.67, 0.31, "Left")
}
F1:: {
    w := 793
    h := 1080
    WinMove (1920 - w) / 2, 0, w, h, "ahk_exe SNAP.exe"
    
    style := WinGetStyle("ahk_exe SNAP.exe")
    if ((style & 0xC40000) == 0) {
        WinSetStyle "+0xC40000", "ahk_exe SNAP.exe"
    }
}

F2:: {
    w := 824
    h := 1119
    WinMove (1920 - w) / 2, -31, w, h, "ahk_exe SNAP.exe"
    
    style := WinGetStyle("ahk_exe SNAP.exe")
    if ((style & 0xC40000) == 0) {
        WinSetStyle "+0xC40000", "ahk_exe SNAP.exe"
    }
}

F3:: {
    w := 808
    h := 1080

    style := WinGetStyle("ahk_exe SNAP.exe")

    if ((style & 0xC40000) != 0) {
        WinSetStyle "-0xC40000", "ahk_exe SNAP.exe"
    }
    WinMove (1920 - w) / 2, 0, w, h, "ahk_exe SNAP.exe"
}

!F4:: {
    ProcessClose("SNAP.exe")
}

#HotIf

TraySetIcon("snaphotkey.ico")

if ProcessExist("Untapped.gg Companion.exe") == 0 {
    Run UNTAPPED_EXE
    if WinWait("Untapped.gg", , 10) {
        WinClose("Untapped.gg")
    }
}

if ProcessExist("SNAP.exe") == 0 {
    Run(SNAP_EXEC)
}

if WinWait("Steam Games List", , 10) {
    WinClose("Steam Games List")
}

ProcessWait("SNAP.exe")
ProcessWaitClose("SNAP.exe")

ProcessClose("Untapped.gg Companion.exe")
ProcessClose("steam.exe")

ExitApp
