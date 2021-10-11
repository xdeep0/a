@echo off

curl -OL https://raw.githubusercontent.com/xdeep0/a/main/7z_aria2.zip
unzip 7z_aria.zip

rem download gigafile
set gf_url=%1
for /f "usebackq delims=" %%a in (`curl -w "%%{redirect_url}" -s -o nul %gf_url%`) do set gf_url=%%a
curl -s -c cookie -o nul %gf_url%
start aria2c -q -k1M -s16 -x16 -o erg.7z --load-cookies=cookie %gf_url:~0,23%download.php?file=%gf_url:~23%
del cookie

7z x -p%2 erg.7z

del 7z_aria.zip cookie erg.7z