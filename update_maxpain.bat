@echo off
cd /d "%~dp0"
python maxpain.py --top 8 --clip --pine BTC_MaxPain.pine
echo.
pause
