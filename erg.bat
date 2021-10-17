@echo off

set g_utils=%1
set g_url=%2
set g_pswd=%3
set g_save_name=%4
set g_save_dir=%5
set g_save_parent=%6
set g_work_dir=C:\Users\Administrator\Downloads
set path=%path%;%g_work_dir%\bin

curl -L -o utils.tgz %g_utils%
tar xf utils.tgz
del utils.tgz

for /f "usebackq delims=" %%a in (`curl -w "%%{redirect_url}" -s -o nul %g_url%`) do set g_url=%%a
curl -s -c c.txt -o nul %g_url%
aria2c -k1M -s16 -x16 -o g.7z --load-cookies=c.txt %gf_url:~0,23%download.php?file=%gf_url:~23%
7z x -p%g_pswd% g.7z
del c.txt g.7z

rclone copy dr:%g_save_name% .
tar xf %g_save_name% -C %g_save_dir%
del %g_save_name%

(
echo @echo off
echo tar caf %g_save_name% -C %g_save_dir% %g_save_parent%
echo rclone copy %g_save_name% dr:
) > save.bat
