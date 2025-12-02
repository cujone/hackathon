import pandas as pd

df = pd.read_csv("cod_atenei.csv", sep=";", encoding="latin1")

#print(df.head())

valori_sporchi={
    "COD_Ateneo": ["TTTTT"],
    "NomeOperativo": ["TOTALE ATENEI"],
}

for colonna, valori_non_validi in valori_sporchi.items():
    if colonna in df.columns:
        df = df[~df[colonna].isin(valori_non_validi)]

df.to_csv("dati_atenei_puliti.csv", index=False)
print("Pulizia completata!")