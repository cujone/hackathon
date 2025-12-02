@echo off
REM ==========================================
REM SCRIPT DI AVVIO AUTOMATICO PROGETTO (Windows)
REM ==========================================

REM 1. Avvia il database Docker in background
REM Il comando 'up -d db' fa partire solo il servizio db definito nel docker-compose.yml
echo [1/2] Avvio il database Docker...
docker-compose up -d db

REM 2. Attesa di sicurezza
REM Diamo tempo al database di inizializzarsi completamente prima di connetterci
echo Attendo 5 secondi che il database sia pronto...
timeout /t 5 /nobreak >nul

REM 3. Esegue lo script Python
REM Utilizza il python presente nella cartella .venv per eseguire il main.py
echo [2/2] Eseguo lo script Python per importare i dati...
.venv\Scripts\python src/main.py

REM 4. Pausa finale
REM Mantiene la finestra aperta per permetterti di leggere l'esito (Successo/Errore)
echo.
echo Operazione completata. Premi un tasto per chiudere.
pause
