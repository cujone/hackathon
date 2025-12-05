import pandas as pd
import os

# Define input and output paths
# Docker mounts /app/data so paths are relative to /app (which is current working dir usually, or handled by script path)
# The script is likely run from the root of the project in the container

input_path = "data/DNFobservatory2022.csv"
output_path = "data/processed/DNFobservatory_clean.csv"

# Ensure output directory exists (although processed probably exists)
os.makedirs(os.path.dirname(output_path), exist_ok=True)

try:
    print(f"Reading from {input_path}...")
    # Read the CSV. Assuming semicolon separator based on typical Italian CSVs or previous file peek
    # but I should check. The previous 'type' command showed semicolon.
    df = pd.read_csv(input_path, sep=";", encoding="latin1")
    
    # Define columns to keep based on user request
    columns_to_keep = [
        "Aziende_nel_Database",
        "Settore",
        "ATECO",
        "Attivita",
        "Regioni",
        "N_uomini_dipendenti",
        "N_donne_dipendenti",
        "Donne_nel_CdA_(%)",
        "Donne_in_posizioni_manageriali_di_vertice_(%)",
        "Disuguaglianza_salariale_di_genere_(%)",
        "Eta_media_dipendenti_(%)",
        "Dipendenti_con_eta_30_per",
        "Dipendenti_con_eta_30_50_per",
        "Dipendenti_con_eta_50_per",
        "Eta_media_in_CdA_(%)",
        "Membri_del_CdA_con_eta_30_per",
        "Membri_del_CdA_con_eta_30_50_per",
        "Membri_del_CdA_con_eta_50_per"
    ]
    
    print(f"Total columns found in file: {len(df.columns)}")
    
    # Filter for columns that actually exist in the dataframe to avoid errors
    existing_cols = [col for col in columns_to_keep if col in df.columns]
    missing_cols = [col for col in columns_to_keep if col not in df.columns]
    
    if missing_cols:
        print("WARNING: The following requested columns were not found in the CSV:")
        for col in missing_cols:
            print(f"  - {col}")
    
    # Select columns
    df_clean = df[existing_cols]
    
    print(f"Selected {len(df_clean.columns)} columns.")
    
    # Save to CSV
    df_clean.to_csv(output_path, index=False, sep=";")
    print(f"Saved cleaned data to {output_path}")

except Exception as e:
    print(f"Error: {e}")
