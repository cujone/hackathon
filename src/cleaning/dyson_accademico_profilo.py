import pandas as pd

df = pd.read_csv("bdg_serie_academic_staff_profilo.csv", sep=";", encoding="latin1")

#print(df.head())

valori_sporchi={
    "CODICE_ATENEO": ["TTTTT"],
    "NOME_ATENEO": ["TOTALE ATENEI"],
    "REGIONE": ["ITALIA"],
}

for colonna, valori_non_validi in valori_sporchi.items():
    if colonna in df.columns:
        df = df[~df[colonna].isin(valori_non_validi)]

df['NOME_ATENEO'] = df['NOME_ATENEO'].str.replace('à', "a'")
df = df.drop(columns=["AREA_GEO"], errors="ignore")

df.to_csv("dati_accademico_profilo_puliti.csv", index=False)
print("Pulizia completata!")