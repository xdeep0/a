@echo off

ren download vb_cable
start curl -L -o vb.zip https://download.vb-audio.com/Download_CABLE/VBCABLE_Driver_Pack43.zip && mkdir vb && tar xf vb.zip -C vb

curl -OL https://raw.githubusercontent.com/xdeep0/a/main/7z_aria.tgz
tar xf 7z_aria.tgz
del 7z_aria.tgz

rem download gigafile
set gf_url=%1
for /f "usebackq delims=" %%a in (`curl -w "%%{redirect_url}" -s -o nul %gf_url%`) do set gf_url=%%a
curl -s -c cookie -o nul %gf_url%
aria2c -k1M -s16 -x16 -o erg.7z --load-cookies=cookie %gf_url:~0,23%download.php?file=%gf_url:~23%

7z x -p%2 erg.7z

del 7z_aria.zip cookie erg.7z
