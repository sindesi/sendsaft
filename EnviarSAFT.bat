@echo off
 setlocal

::######################################################################################################
::ScriptName...............: SendMail.bat
::Author...................: Cleptography
::ScriptPurpose............: Sends email using the SendEmail.exe
::Required Files...........: SendEmail.exe(http://caspian.dotconf.net/menu/Software/SendEmail/#download)
::                           colorx.exe(http://www.westmesatech.com/sst.html)
::Date.....................: 03/04/2011
::Time.....................: 13:22:25.13
::System Requirements......: N/A
::Syntax...................: SendMail.bat
::Notes....................: Must have a Gmail account to use
::######################################################################################################

REM Set Variables
set Server=smtp.gmail.com
set Port=587
set Message-File=System\message.htm


REM Grab Variables from Config File
for /f "tokens=2 delims==" %%a in ('"find /i "Email" "System\Config""') do (
    set MyEmail=%%a
)
for /f "tokens=2 delims==" %%a in ('"find /i "Password" "System\Config""') do (
    set MyPassword=%%a
)

for /f "tokens=2 delims==" %%a in ('"find /i "Recipients" "System\recipients.txt""') do (
    set Recipients=%%a
)

for /f "tokens=2 delims==" %%a in ('"find /i "Subject" "System\recipients.txt""') do (
    set Subject=%%a
)

for /f "tokens=2 delims==" %%a in ('"find /i "Message" "System\recipients.txt""') do (
    set Message=%%a
)

for /f "tokens=2 delims==" %%a in ('"find /i "Store" "System\recipients.txt""') do (
    set store=%%a
)
REM Grab Variables from Config File




cls
call :Saft
REM call :Header
echo O ficheiro XML mais recente:
REM FOR /F "delims=|" %%I IN ('DIR "*.XML" /B /O:D') DO SET NewestFile=%%I
 FOR /F "delims=|" %%I IN ('DIR "V*.XML" /B /O:D') DO SET NewestFile=%%I
echo "%NewestFile%"

set mydate=%date:~6,4%-%date:~3,2%-%date:~0,2%
echo "%mydate%"


set SaftFile=saft_%store%_%mydate%.xml
set DeliverFile=saft_%store%_%mydate%_v103.xml

echo "Ficheiro  a enviar: %DeliverFile%"

::  move o ficheiro para outro nome
:: copy "%NewestFile%" saft_%store%_%mydate%.xml
REM del "%SaftFile%"
REM del "%DeliverFile%"
echo "-------------------------------"
echo "A criar ficheiro ....
copy "%NewestFile%" "%SaftFile%"
echo "-------------------------------"
echo "A converter...."

REM echo "win32\xsltproc.exe dev\from1To3.xslt %SaftFile% | win32\xmllint.exe --format - > %DeliverFile%"

REM PAUSE
win32\xsltproc.exe dev\from1To3.xslt %SaftFile% | win32\xmllint.exe --format - > %DeliverFile%

REM win32\xsltproc.exe ..\dev\from1To3.xslt %1 | xmllint.exe --format - > %~n1_v103.xml
REM win32\xsltproc.exe ..\dev\from1To3.xslt "%DeliverFile%" | win32\xmllint.exe --format - > %DeliverFile%_v103.xml

echo "-------------------------------"
echo "A Validar...."
win32\xmllint.exe --noout --schema dev\SAFTPT1.03_01.xsd %DeliverFile%




REM Send Email
call :Header
echo "-------------------------------"
echo.A enviar para "%Recipients%"
REM echo "System\SendEmail.exe -f "%MyEmail%" -t "%Recipients%" -u "%Subject%" -m "%Message%" -q -s %Server%:%Port% -xu %MyEmail% -xp %MyPassword%" -a "%DeliverFile%"
System\SendEmail.exe -o tls=yes -f "%MyEmail%" -t "%Recipients%" -u "%Subject%" -o message-file=%Message-File% -q -s %Server%:%Port% -xu %MyEmail% -xp %MyPassword%   -a "%DeliverFile%"

REM cls
call :Sent
echo.Enviado!!!
PAUSE



:Header
System\colorx -c 10
echo.*******************************************************************************
System\colorx -c 0e
echo.            ____________
echo.           /     _.'\   \
echo.          /   _.'    \   \
echo.         /_.-'        \___\
echo.        ^|\_\ ``   .-   \ _/^|
echo.        ^|  _\___________.  ^|
echo.        ^| /              \ ^|
echo.        ^|/                \^|
echo.        ^|__________________^|
echo.
System\colorx -c 10
echo.*******************************************************************************
System\colorx -c 0f
goto :eof



:Sent
System\colorx -c 10
echo.*******************************************************************************
System\colorx -c 0a
echo.                       __________________
echo.                      ^|             .__. ^|
echo.           ------     ^|  ._-..      ^|  ^| ^| 
echo.              ------  ^|             '""' ^| 
echo.           ------     ^|           -.,-_  ^| 
echo.                      ^|__________________^| 
echo.
System\colorx -c 10
echo.*******************************************************************************
System\colorx -c 0f
goto :eof

:Saft
System\colorx -c 10
echo.*******************************************************************************
System\colorx -c 0a
echo.            _________   _____  ______________________
echo.           /   _____/  /  _  \ \_   _____/\__    ___/
echo.           \_____  \  /  /_\  \ ^|    __)    ^|    ^|   
echo.           /        \/    ^|    \^|     \     ^|    ^|   
echo.          /_______  /\____^|__  /\___  /     ^|____^|   
echo.                  \/         \/     \/  
System\colorx -c 10
echo.*******************************************************************************
System\colorx -c 0f
