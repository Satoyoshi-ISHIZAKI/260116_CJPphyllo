#!/usr/bin/env python3
"""
Script to convert capital letters in MD5sum values to lowercase
"""

def convert_md5sums_to_lowercase(file_path):
    """
    Read md5sums.txt, convert MD5 values to lowercase, and write back
    """
    try:
        # Read the file
        with open(file_path, 'r') as f:
            lines = f.readlines()
        
        # Convert each line
        converted_lines = []
        for line in lines:
            # Split the line into MD5 hash and filename
            parts = line.split()
            if len(parts) >= 2:
                # Convert the MD5 hash (first part) to lowercase
                md5_hash = parts[0].lower()
                # Reconstruct the line with lowercase hash
                converted_line = md5_hash + '  ' + '  '.join(parts[1:]) + '\n'
                converted_lines.append(converted_line)
            else:
                # Keep empty lines or malformed lines as is
                converted_lines.append(line)
        
        # Write back to the file
        with open(file_path, 'w') as f:
            f.writelines(converted_lines)
        
        print(f"Successfully converted MD5sums to lowercase in {file_path}")
        
    except FileNotFoundError:
        print(f"Error: File '{file_path}' not found")
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    # Path to the md5sums.txt file
    md5_file = "md5sums.txt"
    
    # Convert to lowercase
    convert_md5sums_to_lowercase(md5_file)
