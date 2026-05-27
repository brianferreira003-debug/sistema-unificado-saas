@echo off
echo ============================================================
echo   Sistema Unificado SaaS v3.0
echo ============================================================
echo.
cd /d "%~dp0"

REM Crear .env si no existe
if not exist .env (
    echo SECRET_KEY=cambiar-esto-por-un-token-aleatorio> .env
    echo PORT=5000>> .env
    echo FLASK_DEBUG=0>> .env
    echo.
    echo [.env creado - completalo con tus valores]
    echo.
)

REM Crear venv si no existe
if not exist venv (
    echo Creando entorno virtual...
    python -m venv venv
)

REM Instalar deps
call venv\Scripts\activate.bat
pip install -q -r requirements.txt

echo.
echo ============================================================
echo   Abriendo http://localhost:5000
echo ============================================================
echo.

start "" "http://localhost:5000"
python app.py
pause
