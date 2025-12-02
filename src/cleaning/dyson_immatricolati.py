import pandas as pd

df = pd.read_csv("bdg_serie_immatricolati.csv", sep=";", encoding="latin1")

#print(df.head())

valori_sporchi={
    "AteneoNOME": ["TOTALE ATENEI"],
    "AteneoREGIONE": ["ITALIA"],
    "DESC_FoET2013" :["Services"],
}

for colonna, valori_non_validi in valori_sporchi.items():
    if colonna in df.columns:
        df = df[~df[colonna].isin(valori_non_validi)]

df['AteneoNOME'] = df['AteneoNOME'].str.replace('à', "a'")
df['COD_FoET2013'] = df['COD_FoET2013'].astype(str).str.zfill(2)
df = df.drop(columns=["AteneoAREAGEO"], errors="ignore")

df.to_csv("dati_immatricolati_puliti.csv", index=False)
print("Pulizia completata!")