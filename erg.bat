@echo off

ren download vb_cable
curl -L -o vb.zip https://download.vb-audio.com/Download_CABLE/VBCABLE_Driver_Pack43.zip
mkdir vb
tar xf vb.zip -C vb

rem download directx
curl -OL https://download.microsoft.com/download/1/7/1/1718CCC4-6315-4D8E-9543-8E28A4E18C4C/dxwebsetup.exe

curl -OL https://raw.githubusercontent.com/xdeep0/a/main/7z_aria.tgz
tar xf 7z_aria.tgz
del 7z_aria.tgz

rem download gigafile
set gf_url=%1
for /f "usebackq delims=" %%a in (`curl -w "%%{redirect_url}" -s -o nul %gf_url%`) do set gf_url=%%a
curl -s -c cookie -o nul %gf_url%
aria2c -k1M -s16 -x16 -o erg.7z --load-cookies=cookie %gf_url:~0,23%download.php?file=%gf_url:~23%

rem download save file
curl -L -o save.7z %2

7z x -p%3 erg.7z
7z x -p%3 save.7z

del 7z_aria.zip cookie erg.7z
