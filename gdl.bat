@echo off

set gf_url=%1
for /f "usebackq delims=" %%a in (`curl -w "%%{redirect_url}" -s -o nul %gf_url%`) do set gf_url=%%a
curl -s -c cookie -o nul %gf_url%
aria2c -q -k1M -s16 -x16 --load-cookies=cookie %gf_url:~0,23%download.php?file=%gf_url:~23%
del cookie
