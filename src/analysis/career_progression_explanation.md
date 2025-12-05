# Explanation of career_progression.py

Here is a line-by-line explanation of the `career_progression.py` script:

### Imports
**Line 1:** `import pandas as pd` - Imports the pandas library, which is the standard tool in Python for data manipulation and analysis, and aliases it as `pd`.
**Line 2:** `import os` - Imports the `os` module, which provides functions for interacting with the operating system (like handling file paths).
**Line 3:** `import glob` - Imports the `glob` module, used for finding files matching a specified pattern (though it's not strictly used in the final logic, it's often imported for file searching).

### Function: `load_data`
**Line 5:** `def load_data(base_dir):` - Defines a function named `load_data` that takes the project's base directory as an argument.
**Line 6:** `"""Loads relevant CSV files into pandas DataFrames."""` - A docstring explaining what the function does.
**Line 7:** `data_dir = os.path.join(base_dir, 'data', 'processed')` - Constructs the absolute path to the directory where the processed CSV files are stored.
**Line 9-15:** Defines a dictionary named `files` where keys are descriptive names (e.g., 'students') and values are the corresponding CSV filenames.
**Line 17:** `dfs = {}` - Initializes an empty dictionary to store the loaded DataFrames.
**Line 18:** `for key, filename in files.items():` - Starts a loop to iterate through each item in the `files` dictionary.
**Line 19:** `file_path = os.path.join(data_dir, filename)` - Constructs the full file path for the current CSV file.
**Line 20:** `if os.path.exists(file_path):` - Checks if the file actually exists at that path.
**Line 21:** `print(f"Loading {filename}...")` - Prints a message to the console indicating the file is being loaded.
**Line 22:** `dfs[key] = pd.read_csv(file_path)` - Reads the CSV file into a pandas DataFrame and stores it in the `dfs` dictionary under the corresponding key.
**Line 23-25:** `else:` block that prints a warning and sets the value to `None` if the file is missing.
**Line 26:** `return dfs` - Returns the dictionary containing the loaded DataFrames.

### Function: `clean_gender`
**Line 28:** `def clean_gender(df, gender_col='Genere'):` - Defines a helper function to standardize the gender column.
**Line 30:** `if df is not None and gender_col in df.columns:` - Checks if the DataFrame exists and contains the specified gender column.
**Line 32:** `df[gender_col] = df[gender_col].astype(str).str.upper().str.strip()` - Converts the gender column to string, makes it uppercase, and removes leading/trailing whitespace to ensure consistency (e.g., 'f', 'F ', 'F' all become 'F').
**Line 33:** `return df` - Returns the cleaned DataFrame.

### Aggregation Functions
**Line 35-43:** `def aggregate_students(df):`
- Cleans the gender column.
- Groups the data by `ANNO` (Year) and `Genere`.
- Sums the `ISC` (Enrolled Students) column.
- Renames `ISC` to `Enrolled_Students` for clarity.

**Line 45-51:** `def aggregate_graduates(df):`
- Similar to above, but sums the `LAU` (Graduates) column and renames it to `Graduates`.

**Line 53-59:** `def aggregate_phd_students(df):`
- Sums the `DOTTORANDI` column and renames it to `PhD_Students`.

**Line 61-67:** `def aggregate_phd_graduates(df):`
- Sums the `DOTTORI` column and renames it to `PhD_Graduates`.

### Function: `aggregate_staff`
**Line 69:** `def aggregate_staff(df):` - Defines function to aggregate academic staff data.
**Line 71:** Checks if DataFrame is not None.
**Line 72:** `df = clean_gender(df, gender_col='GENERE')` - Cleans gender column, noting that in this specific file the column name is 'GENERE' (uppercase).
**Line 88:** `agg = df.groupby(['ANNO', 'GENERE', 'COD_QUALIFICA'])['N_AcStaff'].sum().reset_index()` - Groups by Year, Gender, and Qualification Code, then sums the number of academic staff (`N_AcStaff`).
**Line 91:** `pivot = agg.pivot_table(...)` - Pivots the table so that each Qualification Code (`COD_QUALIFICA`) becomes its own column (e.g., columns for '1PO', '2PA', etc.), making it easier to compare roles side-by-side.
**Line 96:** `return pivot` - Returns the pivoted DataFrame.

### Main Execution Block
**Line 98:** `def main():` - Defines the main function that orchestrates the script.
**Line 100:** `base_dir = ...` - Calculates the project root directory by going up 3 levels from the script's location (`src/analysis/career_progression.py` -> `src/analysis` -> `src` -> `hackathon`).
**Line 103:** `dfs = load_data(base_dir)` - Calls `load_data` to get all the raw DataFrames.
**Line 106-110:** Calls the respective aggregation functions for each dataset (students, graduates, PhDs, staff).

**Line 131-134:** `def normalize_year(df, year_col='ANNO'):` - Defines an inner helper function to fix year formats.
- It takes a DataFrame and converts entries like "2023/2024" into just "2023" by splitting on the "/" character and taking the first part. This is crucial for merging data that uses different year formats.

**Line 136-140:** Applies `normalize_year` to all aggregated DataFrames.

**Line 143-144:** Checks if `staff_agg` exists and renames its 'GENERE' column to 'Genere' so it matches the other DataFrames for merging.

**Line 149:** `merged = students_agg` - Initializes the `merged` DataFrame with the student data.
**Line 151:** `for df_to_merge in [...]:` - Loops through the other aggregated DataFrames.
**Line 156:** `merged = pd.merge(merged, df_to_merge, on=['ANNO', 'Genere'], how='outer')` - Merges the current `merged` DataFrame with the next one.
- `on=['ANNO', 'Genere']`: Matches rows based on Year and Gender.
- `how='outer'`: Ensures we keep all years/genders, even if data is missing in one of the files (e.g., if we have student data for 2024 but no graduates yet).

**Line 159:** `merged.fillna(0, inplace=True)` - Replaces any `NaN` (Not a Number) values created by the merge (missing data) with 0.
**Line 162:** `merged.sort_values(...)` - Sorts the final dataset by Year and Gender for readability.

**Line 165:** `output_path = ...` - Defines the path where the result CSV will be saved (`data/results/career_progression_summary.csv`).
**Line 166:** `merged.to_csv(output_path, index=False)` - Saves the final DataFrame to a CSV file without the pandas index numbers.

**Line 168-170:** Prints a success message and the first 10 rows of the result to the console.
**Line 173-174:** Prints total counts grouped by Gender to give a quick summary of the data balance.

**Line 176-177:** `if __name__ == "__main__": main()` - Standard Python boilerplate to ensure `main()` runs only if the script is executed directly (not imported as a module).
