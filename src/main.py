import mysql.connector
import os
import time
import pandas as pd
from sqlalchemy import create_engine
import glob

def get_db_url():
    # Configurazione per Docker (default) o Locale
    db_host = os.environ.get('DB_HOST', 'localhost')
    db_port = int(os.environ.get('DB_PORT', '3306'))
    
    # Se siamo in locale (host è localhost), usiamo la porta mappata 3307
    if db_host == 'localhost':
        db_port = 3307

    db_user = os.environ.get('DB_USER', 'root')
    db_password = os.environ.get('DB_PASSWORD', 'root')
    db_name = os.environ.get('DB_NAME', 'universita_db')
    
    return f"mysql+mysqlconnector://{db_user}:{db_password}@{db_host}:{db_port}/{db_name}"

def wait_for_db():
    """Attende che il database sia pronto."""
    max_retries = 30
    for i in range(max_retries):
        try:
            # Tentativo di connessione grezza per vedere se il socket è aperto
            db_url = get_db_url()
            engine = create_engine(db_url)
            with engine.connect() as connection:
                print("✅ Database pronto!")
                return engine
        except Exception as e:
            print(f"⏳ In attesa del database... ({i+1}/{max_retries})")
            time.sleep(2)
    raise Exception("Impossibile connettersi al database dopo vari tentativi.")

def load_data():
    engine = wait_for_db()
    
    # Percorso della cartella processed
    # Se siamo in Docker, il path è /app/data/processed (mappato dal volume)
    # Se siamo in locale, è ./data/processed
    # Usiamo un path relativo che funzioni in entrambi i casi se lanciato dalla root del progetto
    base_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    data_dir = os.path.join(base_dir, 'data', 'processed')
    
    if not os.path.exists(data_dir):
        print(f"⚠️ Cartella {data_dir} non trovata. Assicurati di aver eseguito lo script di pulizia o di aver montato i volumi corretti.")
        return

    csv_files = glob.glob(os.path.join(data_dir, "*.csv"))
    
    if not csv_files:
        print("⚠️ Nessun file CSV trovato in data/processed.")
        return

    print(f"📂 Trovati {len(csv_files)} file CSV da importare.")

    for file_path in csv_files:
        filename = os.path.basename(file_path)
        # Nome tabella: rimuovi estensione e pulisci caratteri strani se necessario
        table_name = os.path.splitext(filename)[0]
        # Semplificazione nome tabella (opzionale, es: dati_immatricolati_puliti -> dati_immatricolati_puliti)
        
        print(f"🔄 Elaborazione {filename} -> Tabella: {table_name}...")
        
        try:
            # Leggi CSV
            df = pd.read_csv(file_path)
            
            # Scrivi su DB
            # if_exists='replace' fa esattamente DROP TABLE IF EXISTS e poi CREATE
            df.to_sql(name=table_name, con=engine, if_exists='replace', index=False)
            
            print(f"✅ {table_name} importata con successo ({len(df)} righe).")
        except Exception as e:
            print(f"❌ Errore nell'importazione di {filename}: {e}")

if __name__ == "__main__":
    load_data()