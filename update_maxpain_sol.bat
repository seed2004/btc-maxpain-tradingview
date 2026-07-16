@echo off
cd /d "%~dp0"
python maxpain.py --currency SOL --top 8 --clip --pine SOL_MaxPain.pine
echo.
pause
