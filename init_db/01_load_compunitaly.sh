#!/bin/bash
# Script to run SQL files from "CompUnItaly DB" folder

# Exit immediately if a command exits with a non-zero status
set -e

echo "Starting execution of CompUnItaly DB scripts..."

# Define the directory containing the SQL files
# Docker mounts local ./init_db to /docker-entrypoint-initdb.d
SQL_DIR="/docker-entrypoint-initdb.d/CompUnItaly DB"

# Check if directory exists
if [ -d "$SQL_DIR" ]; then
    echo "Directory found: $SQL_DIR"
    
    # Enable nullglob to handle case with no matching files
    shopt -s nullglob
    
    # Iterate through all .sql files in the directory
    # Alphabetical order is default and usually correct for these exports if named wisely
    for f in "$SQL_DIR"/*.sql; do
        if [ -f "$f" ]; then
            echo "Executing: $f"
            # Execute SQL against the universita_db
            # Pass existing environment variables for user/password if needed, 
            # but usually the entrypoint handles auth. 
            # However, for manual execution here we use the credentials.
            # $MYSQL_DATABASE, $MYSQL_USER etc are available in the container.
            
            mysql -u root -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE" < "$f"
        fi
    done
    
    echo "All scripts executed successfully."
else
    echo "Directory '$SQL_DIR' not found!"
    exit 1
fi
