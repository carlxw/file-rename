#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force

; Variblies
targetFile := False

; Initialize Gui
Gui, Show, w160 h90, File Rename
Gui, -MinimizeBox -MaximizeBox
Gui, Add, Edit, r1 vfileName w140 x10 y15, File name
Gui, Add, Button, x40 y50 w80 gSave Default, Save
return

; Methods and Functions
/*
 * If the save button is pressed
*/
Save:
if (targetFile = False){
    Gui, Show, , No file selected!
    Sleep, 2000
    Gui, Show, , File Rename
}
else{
    Gui, Submit
    renameFile(fileLocation, fileName) ; File location, New file name
    Reload ; Resets program
}
return

/*
 * If a file is dropped into the Gui
*/
GuiDropFiles:
targetFile := True
fileLocation := A_GuiEvent
Gui, Show, , File output saved!
Sleep, 2000
Gui, Show, , File Rename
Return

/*
 * Renaming the file
*/
renameFile(fileLocation, fileName){
    fileExtension := getExtension(fileLocation, fileName) ; Gets extension (.mp4)
    fileDate := getDate(fileLocation) ; Gets date through the current file name
    newName = %fileDate% %fileName%%fileExtension% ; Merges the date, inputted name and extension together
    FileMove, %fileLocation%, %A_Desktop%\%newName% ; Renames the file
    Return
}

/*
 * Finds the extension of the file
*/
getExtension(fileLocation, fileName){
    i := StrLen(fileLocation)+1
    While (True){
        char := SubStr(fileLocation, i, 1)
        i--

        if (char = .){
            Return SubStr(fileLocation, i+1)
            Break
        }
        if (i = 0){
            Break
        }
    }
}

/*
 * Finds the date of the file through it's current name
*/
getDate(fileLocation){
    ; Prints out each char individually from left to right
    i := 1
    While (True){
        i++
        
        char1 := SubStr(fileLocation, i, 1)
        char2 := SubStr(fileLocation, i+3, 1)

        ; 2-periods detection
        If (char1 = .){
            If (char2 = .){
                Return SubStr(fileLocation, i-5, 11)
                Break
            }
        }

        If (i = StrLen(fileLocation)+1){
            Break
        }
    }
}

; Exit
F12::ExitApp
GuiCLose:
ExitApp