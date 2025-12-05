import pandas as pd
import os
import glob

def load_data(base_dir):
    """Loads relevant CSV files into pandas DataFrames."""

    # works on Docker (Linux)
    #data_dir = base_dir + "/data/processed"

    # works everywhere (Windows, Mac, Linux, Docker) and is more professional
    data_dir = os.path.join(base_dir, 'data', 'processed')
    
    #defines a dictionary named files 
    #where keys are descriptive names (e.g., 'students') 
    #and values are the corresponding CSV filenames
    files = {
        'students': 'dati_iscritti_puliti.csv',
        'graduates': 'dati_laureati_puliti.csv',
        'phd_students': 'dati_dottorandi_puliti.csv',
        'phd_graduates': 'dati_dottori_puliti.csv',
        'staff': 'dati_accademico_ambito_puliti.csv'
    }
    
    #initializes an empty dictionary to store the loaded DataFrames
    dfs = {}
    
    #starts a loop to iterate through each item in the files dictionary
    for key, filename in files.items():
        #constructs the full file path by joining the data directory with the filename
        file_path = os.path.join(data_dir, filename)
        
        #checks if the file exists at the constructed path
        if os.path.exists(file_path):
            print(f"Loading {filename}...")
            #Reads the CSV file into a pandas DataFrame 
            #and stores it in the dfs dictionary under the corresponding key
            dfs[key] = pd.read_csv(file_path)
        else:
            print(f"Warning: {filename} not found.")
            dfs[key] = None
    return dfs

def clean_gender(df, gender_col='Genere'):
    """Standardizes gender column values."""
    if df is not None and gender_col in df.columns:
        # Ensure uppercase and remove whitespace
        df[gender_col] = df[gender_col].astype(str).str.upper().str.strip()
    return df

def aggregate_students(df):
    """Aggregates student enrollment data."""
    if df is None: return None
    df = clean_gender(df)
    #group by Year and Gender, sum ISC
    # Year column might be 'ANNO'
    agg = df.groupby(['ANNO', 'Genere'])['ISC'].sum().reset_index()
    agg.rename(columns={'ISC': 'Enrolled_Students'}, inplace=True)
    return agg

def aggregate_graduates(df):
    """Aggregates graduate data."""
    if df is None: return None
    df = clean_gender(df)
    agg = df.groupby(['ANNO', 'Genere'])['LAU'].sum().reset_index()
    agg.rename(columns={'LAU': 'Graduates'}, inplace=True)
    return agg

def aggregate_phd_students(df):
    """Aggregates PhD student data."""
    if df is None: return None
    df = clean_gender(df)
    agg = df.groupby(['ANNO', 'Genere'])['DOTTORANDI'].sum().reset_index()
    agg.rename(columns={'DOTTORANDI': 'PhD_Students'}, inplace=True)
    return agg

def aggregate_phd_graduates(df):
    """Aggregates PhD graduate data."""
    if df is None: return None
    df = clean_gender(df)
    agg = df.groupby(['ANNO', 'Genere'])['DOTTORI'].sum().reset_index()
    agg.rename(columns={'DOTTORI': 'PhD_Graduates'}, inplace=True)
    return agg

def aggregate_staff(df):
    """Aggregates academic staff data."""
    if df is None: return None
    df = clean_gender(df, gender_col='GENERE') # Note: GENERE is uppercase in staff file
    
    # Map qualifications to broader categories if needed
    # For now, let's keep the codes or descriptions
    # We want to sum N_AcStaff
    
    # Let's pivot to have columns for each role
    # Roles of interest: 
    # 1PO - Prof. I fascia (ordinario) -> Full Professor
    # 2PA - Prof. II fascia (associato) -> Associate Professor
    # 3RU - Ricercatore a tempo indeterminato -> Researcher (Permanent)
    # 3RTD - Ricercatore a tempo determinato ... -> Researcher (Temp)
    # 4AR - Titolare di assegno di ricerca -> Research Fellow
    
    # Filter for these codes to simplify or just group by COD_QUALIFICA
    
    agg = df.groupby(['ANNO', 'GENERE', 'COD_QUALIFICA'])['N_AcStaff'].sum().reset_index()
    
    # Pivot
    pivot = agg.pivot_table(index=['ANNO', 'GENERE'], columns='COD_QUALIFICA', values='N_AcStaff', fill_value=0).reset_index()
    
    # Rename columns for clarity (optional, but good for analysis)
    # We'll keep the codes for now as they are short
    
    return pivot

def main():
    # Determine base directory (3 levels up from src/analysis/career_progression.py)
    base_dir = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
    print(f"Base directory: {base_dir}")
    
    dfs = load_data(base_dir)
    
    # Aggregate
    students_agg = aggregate_students(dfs['students'])
    graduates_agg = aggregate_graduates(dfs['graduates'])
    phd_students_agg = aggregate_phd_students(dfs['phd_students'])
    phd_graduates_agg = aggregate_phd_graduates(dfs['phd_graduates'])
    staff_agg = aggregate_staff(dfs['staff'])
    
    # Merge all into a single timeline
    # We need to standardize Year column name and format
    # Student data has '2023/2024' format often, while staff might have '2024'
    # Let's inspect Year formats.
    # From previous `view_file`:
    # students: 2023/2024
    # graduates: 2023
    # staff: 2024
    # phd: 2023/2024 (students), 2023 (graduates)
    
    # We need to normalize year. 
    # For 'YYYY/YYYY', we usually take the first year or second. 
    # Let's take the first year (start of academic year) as the integer year for simplicity, 
    # or keep it as string if we want to be precise.
    # However, to merge with '2023' (calendar year), we need a decision.
    # Graduates in 2023 likely correspond to Academic Year 2022/2023 or 2023/2024?
    # Usually degrees are awarded in sessions. 
    # Let's try to convert 'YYYY/YYYY' to 'YYYY' (first part) for now.
    
    def normalize_year(df, year_col='ANNO'):
        if df is None: return None
        df[year_col] = df[year_col].astype(str).apply(lambda x: x.split('/')[0] if '/' in x else x)
        return df

    students_agg = normalize_year(students_agg)
    graduates_agg = normalize_year(graduates_agg)
    phd_students_agg = normalize_year(phd_students_agg)
    phd_graduates_agg = normalize_year(phd_graduates_agg)
    staff_agg = normalize_year(staff_agg)
    
    # Rename GENERE to Genere in staff_agg to match others
    if staff_agg is not None:
        staff_agg.rename(columns={'GENERE': 'Genere'}, inplace=True)

    # Merge
    # Start with students as base? Or outer merge on Year/Genere
    
    merged = students_agg
    
    for df_to_merge in [graduates_agg, phd_students_agg, phd_graduates_agg, staff_agg]:
        if df_to_merge is not None:
            if merged is None:
                merged = df_to_merge
            else:
                merged = pd.merge(merged, df_to_merge, on=['ANNO', 'Genere'], how='outer')
    
    # Fill NaNs with 0
    merged.fillna(0, inplace=True)
    
    # Sort
    merged.sort_values(by=['ANNO', 'Genere'], inplace=True)
    
    # Save
    output_path = os.path.join(base_dir, 'data', 'results', 'career_progression_summary.csv')
    merged.to_csv(output_path, index=False)
    
    print(f"\nAnalysis complete. Summary saved to {output_path}")
    print("\nFirst 10 rows of aggregated data:")
    print(merged.head(10))
    
    # Print some stats
    print("\nTotal Counts by Gender:")
    print(merged.groupby('Genere').sum(numeric_only=True))

if __name__ == "__main__":
    main()
