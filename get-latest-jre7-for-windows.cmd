@echo off
set path=%path%;%~dp0
set dl=%~dp0dlpage.log
set o=--no-check-certificate --no-cookies --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F"
setlocal EnableDelayedExpansion

for /f "tokens=*" %%a in ('^
wget -qO- http://www.oracle.com/technetwork/java/javase/downloads/index.html ^|
sed "s/\d034/\n/g" ^|
sed -n "/jre7/p" ^|
grep -v "server"') do wget http://www.oracle.com%%a -O"%dl%"

for /f "tokens=*" %%i in ('^
sed "s/\d034/\n/g" "%dl%" ^|
sed -n "/i586.exe/p" ^|
sed -n "/download.oracle/p"') do (
for /f "tokens=7 delims=/" %%n in ('echo %%i') do wget %o% "%%i" -O"%~dp0%%n"
)

for /f "tokens=*" %%x in ('^
sed "s/\d034/\n/g" "%dl%" ^|
sed -n "/x64.exe/p" ^|
sed -n "/download.oracle/p"') do (
for /f "tokens=7 delims=/" %%n in ('echo %%x') do wget %o% "%%x" -O"%~dp0%%n"
)

)

endlocal
pause
