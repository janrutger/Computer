import os

def merge_stacks_files(source_dir, output_filename):
    """
    Zoekt alle .stacks bestanden in source_dir en submappen, 
    en voegt ze samen in output_filename.
    """
    if not os.path.exists(source_dir):
        print(f"Fout: De map '{source_dir}' bestaat niet.")
        return

    with open(output_filename, 'w', encoding='utf-8') as outfile:
        for root, _, files in os.walk(source_dir):
            for file in sorted(files):
                if file.endswith('.stacks'):
                    full_path = os.path.join(root, file)
                    outfile.write(f"FILE: {full_path}\n")
                    outfile.write("-" * 60 + "\n")
                    with open(full_path, 'r', encoding='utf-8') as infile:
                        outfile.write(infile.read())
                    outfile.write("\n\n")  # Extra witregel tussen bestanden

if __name__ == "__main__":
    merge_stacks_files('src', 'merged_stacks.txt')
    print("Klaar! Alle bestanden zijn samengevoegd in 'merged_stacks.txt'.")