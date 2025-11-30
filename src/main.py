import mysql.connector
import os
import time

def get_connection():
    # Riprova a connetterti finché il DB non è pronto (il DB ci mette qualche secondo ad accendersi)
    while True:
        try:
            connection = mysql.connector.connect(
                host=os.environ.get('DB_HOST', 'db'), # 'db' è il nome del servizio nel docker-compose
                user=os.environ.get('DB_USER', 'root'),
                password=os.environ.get('DB_PASSWORD', 'root'),
                database=os.environ.get('DB_NAME', 'universita_db')
            )
            print("✅ Connessione al DB riuscita!")
            return connection
        except mysql.connector.Error as err:
            print(f"⏳ Il DB non è ancora pronto, riprovo tra 5 secondi... ({err})")
            time.sleep(5)

# Uso
conn = get_connection()
# ... qui fai le tue query ...