chcp 65001

@REM Source
set sourceMkv=<mkvContainAudioFileName>.mkv
set encodedMp4=<compressedMp4FileName>.mp4
set targetFileName=<resultFileName>.mp4
set sourceFps=60

@REM Bin
set eac3toBin=C:\MeGUI\tools\eac3to\eac3to.exe
set mp4boxBin=C:\MeGUI\tools\mp4box\mp4box.exe

@REM Temp
set tempFolder=%~dp0
set tempPrefix=temp_QVNq3DYjYz

set tempH264Export=%tempFolder%%tempPrefix%_h264Export
set tempH264=%tempH264Export%.h264

set tempAacExport=%tempFolder%%tempPrefix%_aacExport
set tempAac=%tempAacExport%.aac

set eac3toLog=%tempAacExport% - Log.txt

@REM Execute

@REM Clear exist file
del "%targetFileName%"
del "%tempH264%"
del "%tempAac%"
del "%eac3toLog%"

@REM Extract temp track
"%eac3toBin%" "%sourceMkv%" 2:"%tempAac%"
"%mp4boxBin%" -raw 1:output="%tempH264%" "%encodedMp4%"

@REM Merge to mp4
"%mp4boxBin%" -add "%tempH264%#trackID=1:fps=%sourceFps%:par=1:1:name=" -add "%tempAac%#trackID=1:name=" -new "%targetFileName%"

@REM Clear temp file
del "%tempH264%"
del "%tempAac%"
del "%eac3toLog%"

pause