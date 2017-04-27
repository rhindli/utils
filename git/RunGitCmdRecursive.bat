::Run git command recurrsively for all repositories
::found in first level subfolders of the indicated folder.
::
::Parameters
:: %1 - folder name
:: %2

@echo off

set FOLDER_PATH=%1

::read arguments

if %2==git (
	shift
)

set ARG1=%2
set ARG2=%3
set ARG3=%4
set ARG4=%5
set ARG5=%6
set ARG6=%7
set ARG7=%8
set ARG8=%9

shift
set ARG9=%9
shift
set ARG10=%9

shift
if NOT [%9]==[] (
	echo Maximum 10 git arguments accepted
	exit /b 1
)

echo Run git command on all repositories in "%FOLDER_PATH%"
echo.

pushd %FOLDER_PATH%

for /D %%G in (%FOLDER_PATH%\*) do (
	pushd %%G
	
	if exist .git (
		echo.
		echo %%G
		git %ARG1% %ARG2% %ARG3% %ARG4% %ARG5% %ARG6% %ARG7% %ARG8% %ARG9% %ARG10%
	)
	
	popd
)

popd

echo.

pause.