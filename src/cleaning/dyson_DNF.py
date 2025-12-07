import pandas as pd

df = pd.read_csv("DNFobservatory2022.csv", sep=";", encoding="latin1")
righe_csv_sporco = len(df)
print(f"Righe lette dal CSV sporco: {righe_csv_sporco}")

try: 
    Colonne_da_tenere= [
        "Aziende_nel_Database",
        "Settore",
        "ATECO",
        "Regioni",
        "N_uomini_dipendenti",
        "N_donne_dipendenti",
        "Disuguaglianza_salariale_di_genere_(%)",
        "Eta_media_dipendenti_(%)",
    ]
    
    print(f"Totale colonne trovate nel file: {len(df.columns)}")
    
    # Controlla quante colonne esistono nel DataFrame
    existing_cols = [col for col in Colonne_da_tenere if col in df.columns]
    missing_cols = [col for col in Colonne_da_tenere if col not in df.columns]
    
    colonne_rinominate={
        "Disuguaglianza_salariale_di_genere_(%)":"Disuguaglianza_salariale_di_genere_(€)",
        "Eta_media_dipendenti_(%)":"Eta_media_dipendenti"
    }

    if missing_cols:
        print("ATTENZIONE: Le colonne che hai richiesto non si trovano nel file CSV:")
        for col in missing_cols:
            print(f"  - {col}")

    # Seleziona solo le colonne esistenti
    df_clean = df[existing_cols]
    df_clean = df_clean.dropna(how='all')
    print(f"Selezionate {len(df_clean.columns)} colonne.")

    # Calcola il conteggio dei valori null per colonna
    conteggio_null = df_clean.isnull().sum()
    print("\nConteggio dei valori mancanti (NULL) per colonna:")
    print(conteggio_null)

    # Elimina le righe dove la colonna settore è null
    df_clean = df_clean.dropna(subset="Settore")

    # Controlla se la colonna ATECO contine solo valori di 6 cifre
    df_clean['ATECO'] = df_clean['ATECO'].astype(str).str.strip()
    requisito_6_cifre = df_clean['ATECO'].str.match(r'^\d{6}$')
    df_clean = df_clean[requisito_6_cifre]

    # Filtra le colonne per rimuovere il .0
    df_clean['N_uomini_dipendenti'] = df_clean['N_uomini_dipendenti'].astype('Int64')
    df_clean['N_donne_dipendenti'] = df_clean['N_donne_dipendenti'].astype('Int64')

    # Prende solo valori compresi tra 0 e 400 e rimuove il .0 finale
    df_clean = df_clean[df_clean['Disuguaglianza_salariale_di_genere_(%)'].between(0, 400, inclusive="both")]
    df_clean['Disuguaglianza_salariale_di_genere_(%)'] = df_clean['Disuguaglianza_salariale_di_genere_(%)'].astype(int)

    # Prende solo valori compresi tra 18 e 67 e rimuove il .0 finale
    df_clean = df_clean[df_clean['Eta_media_dipendenti_(%)'].between(18, 67, inclusive="both")]
    df_clean['Eta_media_dipendenti_(%)'] = df_clean['Eta_media_dipendenti_(%)'].astype('Int64')

    # Rinomina le colonne
    df_clean = df_clean.rename(columns=colonne_rinominate)

    righe_csv_pulito = len(df_clean)

    df_clean.to_csv("dati_DNF_puliti.csv", index=False, sep=";")
    print(f"File CSV creato! Righe totali nel CSV pulito: {righe_csv_pulito}")

    # Crea un file .txt di report per il conteggio dei valori null
    nome_file_output = "Report_valori_null.txt"
    try:
        with open(nome_file_output, 'w', encoding='utf-8') as f:
            f.write("Conteggio dei valori mancanti (NULL) per colonna:\n")
            f.write(conteggio_null.to_string())

            accurateza = (righe_csv_pulito / righe_csv_sporco) * 100
            f.write(f"\n\nAccuratezza del dataset pulito: {accurateza:.2f}%\n")

        print(f"Creato un file di nome {nome_file_output} per il conteggio dei NULL.")
    except Exception as e:
        print(f"Errore : problema durante la creazione del file : {nome_file_output}. {e}")
    
except Exception as e:
    print(f"Errore: {e}")