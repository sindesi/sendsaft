@echo off
xsltproc.exe ..\dev\from1To3.xslt %1 | xmllint.exe --format - > %~n1_v103.xml
pause