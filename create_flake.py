#!/usr/bin/env python3

import os
import shutil

# Get the current working directory
current_dir = os.getcwd()

# Path to the source flake.nix file

source_flake_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'flake.nix')

# Destination paths
dest_flake_path = os.path.join(os.getcwd(), 'flake.nix')
dest_envrc_path = os.path.join(os.getcwd(), '.envrc')

# Copy flake.nix to the current directory
shutil.copyfile(source_flake_path, dest_flake_path)

# Content for .envrc
envrc_content = 'use flake'

# Create .envrc file
with open(dest_envrc_path, 'w') as f:
    f.write(envrc_content.strip())

# Run direnv allow
os.system('direnv allow')
