@echo off

set SOURCE_WORKSPACE=%1
set DEST_WORKSPACE=%2

if "%SOURCE_WORKSPACE%"=="" (
	echo Usage:
	echo.
	echo %~n0 source [destination]
	echo.
	echo source          source workspace directory
	echo destination     destination workspace directory
	echo                 If not specified copy is performed in current directory

	exit /b 1
)

if not exist "%SOURCE_WORKSPACE%" (
	echo Source workspace folder "%SOURCE_WORKSPACE%" does not exists.
	exit /b 1
)

if "%DEST_WORKSPACE%"=="" (
	set DEST_WORKSPACE=.
)

::remove previous projects
if exist "%DEST_WORKSPACE%"\.metadata rmdir /s /q "%DEST_WORKSPACE%"\.metadata
if exist "%DEST_WORKSPACE%"\capi rmdir /s /q "%DEST_WORKSPACE%"\capi
if exist "%DEST_WORKSPACE%"\core-business rmdir /s /q "%DEST_WORKSPACE%"\core-business
if exist "%DEST_WORKSPACE%"\core-framework rmdir /s /q "%DEST_WORKSPACE%"\core-framework
if exist "%DEST_WORKSPACE%"\csec rmdir /s /q "%DEST_WORKSPACE%"\csec
if exist "%DEST_WORKSPACE%"\db rmdir /s /q "%DEST_WORKSPACE%"\db
if exist "%DEST_WORKSPACE%"\dev rmdir /s /q "%DEST_WORKSPACE%"\dev
if exist "%DEST_WORKSPACE%"\extend rmdir /s /q "%DEST_WORKSPACE%"\extend
if exist "%DEST_WORKSPACE%"\installer rmdir /s /q "%DEST_WORKSPACE%"\installer
if exist "%DEST_WORKSPACE%"\jclient rmdir /s /q "%DEST_WORKSPACE%"\jclient
if exist "%DEST_WORKSPACE%"\jclientEar rmdir /s /q "%DEST_WORKSPACE%"\jclientEar
if exist "%DEST_WORKSPACE%"\lib rmdir /s /q "%DEST_WORKSPACE%"\lib
if exist "%DEST_WORKSPACE%"\pbit rmdir /s /q "%DEST_WORKSPACE%"\pbit
if exist "%DEST_WORKSPACE%"\pirw rmdir /s /q "%DEST_WORKSPACE%"\pirw
if exist "%DEST_WORKSPACE%"\prks rmdir /s /q "%DEST_WORKSPACE%"\prks
if exist "%DEST_WORKSPACE%"\prop rmdir /s /q "%DEST_WORKSPACE%"\prop
if exist "%DEST_WORKSPACE%"\reporting rmdir /s /q "%DEST_WORKSPACE%"\reporting
if exist "%DEST_WORKSPACE%"\sagr rmdir /s /q "%DEST_WORKSPACE%"\sagr
if exist "%DEST_WORKSPACE%"\scld rmdir /s /q "%DEST_WORKSPACE%"\scld
if exist "%DEST_WORKSPACE%"\scqm rmdir /s /q "%DEST_WORKSPACE%"\scqm
if exist "%DEST_WORKSPACE%"\scwi rmdir /s /q "%DEST_WORKSPACE%"\scwi
if exist "%DEST_WORKSPACE%"\sdei rmdir /s /q "%DEST_WORKSPACE%"\sdei
if exist "%DEST_WORKSPACE%"\sedi rmdir /s /q "%DEST_WORKSPACE%"\sedi
if exist "%DEST_WORKSPACE%"\sems rmdir /s /q "%DEST_WORKSPACE%"\sems
if exist "%DEST_WORKSPACE%"\server rmdir /s /q "%DEST_WORKSPACE%"\server
if exist "%DEST_WORKSPACE%"\sfro rmdir /s /q "%DEST_WORKSPACE%"\sfro
if exist "%DEST_WORKSPACE%"\sfxa rmdir /s /q "%DEST_WORKSPACE%"\sfxa
if exist "%DEST_WORKSPACE%"\sgap rmdir /s /q "%DEST_WORKSPACE%"\sgap
if exist "%DEST_WORKSPACE%"\shrmWs rmdir /s /q "%DEST_WORKSPACE%"\shrmWs
if exist "%DEST_WORKSPACE%"\smlm rmdir /s /q "%DEST_WORKSPACE%"\sicm
if exist "%DEST_WORKSPACE%"\smlm rmdir /s /q "%DEST_WORKSPACE%"\smlm
if exist "%DEST_WORKSPACE%"\smon rmdir /s /q "%DEST_WORKSPACE%"\smon
if exist "%DEST_WORKSPACE%"\smrp rmdir /s /q "%DEST_WORKSPACE%"\smrp
if exist "%DEST_WORKSPACE%"\smstr rmdir /s /q "%DEST_WORKSPACE%"\smstr
if exist "%DEST_WORKSPACE%"\smstrWS rmdir /s /q "%DEST_WORKSPACE%"\smstrWS
if exist "%DEST_WORKSPACE%"\sobk rmdir /s /q "%DEST_WORKSPACE%"\sobk
if exist "%DEST_WORKSPACE%"\soff rmdir /s /q "%DEST_WORKSPACE%"\soff
if exist "%DEST_WORKSPACE%"\sohh rmdir /s /q "%DEST_WORKSPACE%"\sohh
if exist "%DEST_WORKSPACE%"\spos rmdir /s /q "%DEST_WORKSPACE%"\spos
if exist "%DEST_WORKSPACE%"\sprc rmdir /s /q "%DEST_WORKSPACE%"\sprc
if exist "%DEST_WORKSPACE%"\sprx rmdir /s /q "%DEST_WORKSPACE%"\sprx
if exist "%DEST_WORKSPACE%"\srpd rmdir /s /q "%DEST_WORKSPACE%"\srpd
if exist "%DEST_WORKSPACE%"\stln rmdir /s /q "%DEST_WORKSPACE%"\stln
if exist "%DEST_WORKSPACE%"\strl rmdir /s /q "%DEST_WORKSPACE%"\strl
if exist "%DEST_WORKSPACE%"\sweb rmdir /s /q "%DEST_WORKSPACE%"\sweb
if exist "%DEST_WORKSPACE%"\sweb-themes rmdir /s /q "%DEST_WORKSPACE%"\sweb-themes
if exist "%DEST_WORKSPACE%"\swms rmdir /s /q "%DEST_WORKSPACE%"\swms
if exist "%DEST_WORKSPACE%"\swss rmdir /s /q "%DEST_WORKSPACE%"\swss


::create directories
mkdir "%DEST_WORKSPACE%"\.metadata
mkdir "%DEST_WORKSPACE%"\capi
mkdir "%DEST_WORKSPACE%"\core-business
mkdir "%DEST_WORKSPACE%"\core-framework
mkdir "%DEST_WORKSPACE%"\csec
mkdir "%DEST_WORKSPACE%"\db
mkdir "%DEST_WORKSPACE%"\dev
mkdir "%DEST_WORKSPACE%"\extend
mkdir "%DEST_WORKSPACE%"\installer
mkdir "%DEST_WORKSPACE%"\jclient
mkdir "%DEST_WORKSPACE%"\jclientEar
mkdir "%DEST_WORKSPACE%"\lib
mkdir "%DEST_WORKSPACE%"\pbit
mkdir "%DEST_WORKSPACE%"\pirw
mkdir "%DEST_WORKSPACE%"\prks
mkdir "%DEST_WORKSPACE%"\prop
mkdir "%DEST_WORKSPACE%"\reporting
mkdir "%DEST_WORKSPACE%"\sagr
mkdir "%DEST_WORKSPACE%"\scld
mkdir "%DEST_WORKSPACE%"\scqm
mkdir "%DEST_WORKSPACE%"\scwi
mkdir "%DEST_WORKSPACE%"\sdei
mkdir "%DEST_WORKSPACE%"\sedi
mkdir "%DEST_WORKSPACE%"\sems
mkdir "%DEST_WORKSPACE%"\server
mkdir "%DEST_WORKSPACE%"\sfro
mkdir "%DEST_WORKSPACE%"\sfxa
mkdir "%DEST_WORKSPACE%"\sgap
mkdir "%DEST_WORKSPACE%"\shrmWs
mkdir "%DEST_WORKSPACE%"\sicm
mkdir "%DEST_WORKSPACE%"\smlm
mkdir "%DEST_WORKSPACE%"\smon
mkdir "%DEST_WORKSPACE%"\smrp
mkdir "%DEST_WORKSPACE%"\smstr
mkdir "%DEST_WORKSPACE%"\smstrWS
mkdir "%DEST_WORKSPACE%"\sobk
mkdir "%DEST_WORKSPACE%"\soff
mkdir "%DEST_WORKSPACE%"\sohh
mkdir "%DEST_WORKSPACE%"\spos
mkdir "%DEST_WORKSPACE%"\sprc
mkdir "%DEST_WORKSPACE%"\sprx
mkdir "%DEST_WORKSPACE%"\srpd
mkdir "%DEST_WORKSPACE%"\stln
mkdir "%DEST_WORKSPACE%"\strl
mkdir "%DEST_WORKSPACE%"\sweb
mkdir "%DEST_WORKSPACE%"\sweb-themes
mkdir "%DEST_WORKSPACE%"\swms
mkdir "%DEST_WORKSPACE%"\swss

::copy projects
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\.metadata "%DEST_WORKSPACE%"\.metadata
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\capi "%DEST_WORKSPACE%"\capi
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\core-business "%DEST_WORKSPACE%"\core-business
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\core-framework "%DEST_WORKSPACE%"\core-framework
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\csec "%DEST_WORKSPACE%"\csec
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\db "%DEST_WORKSPACE%"\db
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\dev "%DEST_WORKSPACE%"\dev
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\extend "%DEST_WORKSPACE%"\extend
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\installer "%DEST_WORKSPACE%"\installer
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\jclient "%DEST_WORKSPACE%"\jclient
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\jclientEar "%DEST_WORKSPACE%"\jclientEar
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\lib "%DEST_WORKSPACE%"\lib
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\pbit "%DEST_WORKSPACE%"\pbit
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\pirw "%DEST_WORKSPACE%"\pirw
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\prks "%DEST_WORKSPACE%"\prks
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\prop "%DEST_WORKSPACE%"\prop
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\reporting "%DEST_WORKSPACE%"\reporting
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\sagr "%DEST_WORKSPACE%"\sagr
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\scld "%DEST_WORKSPACE%"\scld
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\scqm "%DEST_WORKSPACE%"\scqm
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\scwi "%DEST_WORKSPACE%"\scwi
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\sdei "%DEST_WORKSPACE%"\sdei
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\sedi "%DEST_WORKSPACE%"\sedi
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\sems "%DEST_WORKSPACE%"\sems
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\server "%DEST_WORKSPACE%"\server
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\sfro "%DEST_WORKSPACE%"\sfro
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\sfxa "%DEST_WORKSPACE%"\sfxa
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\sgap "%DEST_WORKSPACE%"\sgap
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\shrmWs "%DEST_WORKSPACE%"\shrmWs
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\sicm "%DEST_WORKSPACE%"\sicm
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\smlm "%DEST_WORKSPACE%"\smlm
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\smon "%DEST_WORKSPACE%"\smon
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\smrp "%DEST_WORKSPACE%"\smrp
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\smstr "%DEST_WORKSPACE%"\smstr
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\smstrWS "%DEST_WORKSPACE%"\smstrWS
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\sobk "%DEST_WORKSPACE%"\sobk
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\soff "%DEST_WORKSPACE%"\soff
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\sohh "%DEST_WORKSPACE%"\sohh
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\spos "%DEST_WORKSPACE%"\spos
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\sprc "%DEST_WORKSPACE%"\sprc
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\sprx "%DEST_WORKSPACE%"\sprx
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\srpd "%DEST_WORKSPACE%"\srpd
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\stln "%DEST_WORKSPACE%"\stln
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\strl "%DEST_WORKSPACE%"\strl
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\sweb "%DEST_WORKSPACE%"\sweb
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\sweb-themes "%DEST_WORKSPACE%"\sweb-themes
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\swms "%DEST_WORKSPACE%"\swms
robocopy /E /NFL /NDL /ETA "%SOURCE_WORKSPACE%"\swss "%DEST_WORKSPACE%"\swss
