@echo off
REM ==========================================
REM SCRIPT PER SALVARE LO STATO DEL DATABASE
REM ==========================================

echo [1/2] Verifico che il database sia attivo...
docker ps | find "db_universita" >nul
if %errorlevel% neq 0 (
    echo ERRORE: Il database non sembra essere attivo.
    echo Assicurati di aver lanciato 'docker-compose up -d db' o 'run_project.bat'.
    pause
    exit /b
)

echo [2/2] Eseguo il dump del database in init_db/init.sql...
REM Esegue mysqldump dentro il container e salva l'output nel file locale
docker exec db_universita mysqldump -u root -proot universita_db > init_db/init.sql

if %errorlevel% neq 0 (
    echo ERRORE durante il salvataggio del database.
    pause
    exit /b
)

echo.
echo SUCCESSO! Lo stato attuale del database e' stato salvato in 'init_db/init.sql'.
echo Se invii questo progetto a qualcun altro, avra' gia' i dati pronti.
echo.
pause
