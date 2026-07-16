@echo off
cd /d "%~dp0"
python maxpain.py --currency HYPE --top 8 --clip --pine HYPE_MaxPain.pine
echo.
pause
