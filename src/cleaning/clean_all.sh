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

echo "Running dyson_accademico_ambito.py..."
python /app/src/cleaning/dyson_accademico_ambito.py

echo "Running dyson_accademico_profilo.py..."
python /app/src/cleaning/dyson_accademico_profilo.py

echo "Running dyson_atenei.py..."
python /app/src/cleaning/dyson_atenei.py

echo "Running dyson_dottorandi.py..."
python /app/src/cleaning/dyson_dottorandi.py

echo "Running dyson_dottori.py..."
python /app/src/cleaning/dyson_dottori.py

echo "Running dyson_immatricolati.py..."
python /app/src/cleaning/dyson_immatricolati.py

echo "Running dyson_iscritti.py..."
python /app/src/cleaning/dyson_iscritti.py

echo "Running dyson_laureati.py..."
python /app/src/cleaning/dyson_laureati.py

echo "Running dyson_prevgenere.py..."
python /app/src/cleaning/dyson_prevgenere.py

echo "Running dyson_specializzandi.py..."
python /app/src/cleaning/dyson_specializzandi.py

echo "All scripts executed successfully."

# Move the generated cleaned files to the processed directory
echo "Moving cleaned files to /app/data/processed..."
mv *_puliti.csv /app/data/processed/

echo "Cleaning process completed!"
