@echo off
REM SPDX-FileCopyrightText: © Vegard IT GmbH (https://vegardit.com) and contributors
REM SPDX-FileContributor: Sebastian Thomschke, Vegard IT GmbH
REM Author: Sebastian Thomschke, Vegard IT GmbH

pushd .

REM cd into project root
cd %~dp0..


if exist dump\%1 (
   echo Cleaning [dump\%1]...
   rd /s /q dump\%1
)
if exist target\%1 (
   echo Cleaning [target\%1]...
   rd /s /q target\%1
)
shift

REM install common libs
echo Checking required haxelibs...
for %%i in (haxe-doctest no-spoon) do (
   haxelib list | findstr %%i >NUL
   if errorlevel 1 (
      echo Installing [%%i]...
      if "%%i" == "no-spoon" (
        haxelib git no-spoon https://github.com/back2dos/no-spoon.git
      ) else (
        haxelib install %%i
      )
   )
)

goto :eof

REM install additional libs
:iterate

   if "%~1"=="" goto :eof

   haxelib list | findstr %1 >NUL
   if errorlevel 1 (
      echo Installing [%1]...
      haxelib install %1
   )

   shift
   goto iterate