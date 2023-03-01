@echo off
REM SPDX-FileCopyrightText: © Vegard IT GmbH (https://vegardit.com) and contributors
REM SPDX-FileContributor: Sebastian Thomschke, Vegard IT GmbH
REM SPDX-License-Identifier: Apache-2.0

call %~dp0_test-prepare.cmd lua

echo Compiling...
haxe %~dp0..\tests.hxml
set rc=%errorlevel%
popd
if not %rc% == 0 exit /b %rc%

echo Testing...
C:\apps\dev\coredev\console\bin\clink\clink.bat lua "%~dp0..\target\lua\TestRunner.lua"
