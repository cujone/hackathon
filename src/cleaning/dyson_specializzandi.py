import pandas as pd

df = pd.read_csv("bdg_specializzandi_serie-triennale.csv", sep=";", encoding="latin1")

#print(df.head())

valori_sporchi={
    "AteneoCOD": ["TTTTT"],
    "AteneoNOME": ["TOTALE ATENEI"],
    "AteneoREGIONE": ["ITALIA"],
}

for colonna, valori_non_validi in valori_sporchi.items():
    if colonna in df.columns:
        df = df[~df[colonna].isin(valori_non_validi)]

df['AteneoNOME'] = df['AteneoNOME'].str.replace('à', "a'")
df = df.drop(columns=["AteneoAREAGEO","CorsoTIPO"], errors="ignore")

df.to_csv("dati_specializzandi_puliti.csv", index=False)
print("Pulizia completata!")