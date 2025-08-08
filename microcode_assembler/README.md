# Microcode Assembler

This directory contains the tools to assemble microcode source files (`.uasm`) into a JSON ROM format that the CPU simulation can load and execute.

## Usage

```bash
python -m microcode_assembler.assembler <input_file.uasm> -o <output_file.json>
```
