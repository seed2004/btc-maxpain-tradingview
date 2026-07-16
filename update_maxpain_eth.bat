@echo off
cd /d "%~dp0"
python maxpain.py --currency ETH --top 8 --clip --pine ETH_MaxPain.pine
echo.
pause
