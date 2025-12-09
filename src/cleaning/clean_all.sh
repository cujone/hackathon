#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "Starting data cleaning process..."

# Navigate to the raw data directory where the scripts expect input files
cd /app/data/raw

echo "Processing files in /app/data/raw..."

# Execute each cleaning script
# We use python /app/src/cleaning/<script_name> because the scripts are mounted there
# The scripts will read from current dir (raw) and write to current dir (raw)

# Function to run cleaning script if input file exists
run_cleaning() {
    script_name=$1
    input_file=$2
    
    if [ -f "$input_file" ]; then
        echo "Running $script_name..."
        python "/app/src/cleaning/$script_name"
    else
        echo "Skipping $script_name - $input_file not found."
    fi
}

run_cleaning "dyson_accademico_ambito.py" "bdg_serie_academic_staff_ambito.csv"
run_cleaning "dyson_accademico_profilo.py" "bdg_serie_academic_staff_profilo.csv"
run_cleaning "dyson_atenei.py" "cod_atenei.csv"
run_cleaning "dyson_dottorandi.py" "bdg_serie_dottorandi.csv"
run_cleaning "dyson_dottori.py" "bdg_serie_dottori.csv"
run_cleaning "dyson_immatricolati.py" "bdg_serie_immatricolati.csv"
run_cleaning "dyson_iscritti.py" "bdg_serie_iscritti.csv"
run_cleaning "dyson_laureati.py" "bdg_serie_laureati.csv"
run_cleaning "dyson_prevgenere.py" "bdg_classi_prevgenere_serie-triennale.csv"
run_cleaning "dyson_specializzandi.py" "bdg_specializzandi_serie-triennale.csv"
run_cleaning "dyson_DNF.py" "DNFobservatory2022.csv"

echo "All scripts executed successfully."

# Move the generated cleaned files to the processed directory
echo "Moving cleaned files to /app/data/processed..."
mv *_puliti.csv /app/data/processed/

echo "Cleaning process completed!"
