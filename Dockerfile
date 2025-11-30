# Usa un'immagine Python ufficiale leggera (versione 3.9, puoi mettere 3.10 o 3.11)
FROM python:3.9-slim

# Imposta la cartella di lavoro dentro il container
WORKDIR /app

# 1. Copia PRIMA solo i requirements (Strategia di Cache)
# Questo trucco fa sì che Docker non riscarichi le librerie se cambi solo il codice
COPY requirements.txt .

# 2. Installa le librerie
RUN pip install --no-cache-dir -r requirements.txt

# 3. Copia tutto il codice dalla tua cartella 'src' locale dentro il container
COPY src/ .

# Comando che lancia il tuo script principale all'avvio
# (Assicurati che il tuo file principale si chiami 'main.py' o cambia il nome qui sotto)
CMD ["python", "main.py"]

# Se ci sono prolemi nel cercare il file python, esegui questo per avviare in background il docker 
# ed entrarci allàinterno per vedere il suo "punto di vista"
# con il comando "docker exec -it app_universita bash"
# CMD ["tail", "-f", "/dev/null"]
