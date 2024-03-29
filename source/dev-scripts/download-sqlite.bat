@echo off

SET script_dir=%~dp0
SET work_dir=%script_dir%..\..\libs
SET download_path=%work_dir%\"script-temp"

cd %work_dir%
MKDIR %download_path%

CALL :curl7z "https://sqlite.org/2023/sqlite-android-3420000.aar" "android"
CALL :curl7z "https://sqlite.org/2023/sqlite-dll-win32-x86-3420000.zip" "win32"
CALL :curl7z "https://sqlite.org/2023/sqlite-dll-win64-x64-3420000.zip" "win64"


RD /S /Q %download_path%

:curl7z
	set arcname=%~2.zip
	cd %download_path%
	curl %~1 --output %arcname% 		
	
	cd %work_dir%
	MKDIR %~2 && cd %~2
	7z x %download_path%\%arcname% 
	cd %work_dir%
EXIT /B 0


EXIT /B 0

