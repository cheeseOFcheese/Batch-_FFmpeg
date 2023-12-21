@echo off
setlocal enabledelayedexpansion

set count=0
for /R %%F in (*.png) do (
    set /a COUNT+=1
    set "fileName=%%~nF"
    set "extension=%%~xF"
    
    set "PADDED_COUNT=0000!COUNT!"
    set "padded_count=!PADDED_COUNT:~-5!"
    
    set "newName=frame_!padded_count!!extension!"
    
    ren "%%F" "!newName!"
)

ffmpeg -y -framerate 9.0 -i frame_%%05d.png -c:v libvpx-vp9 -crf 30 -b:v 0 -c:a libvorbis video.webm

endlocal
echo Renaming and video creation done.
