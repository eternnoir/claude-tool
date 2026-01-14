"""Common utilities for TailwindPlus skill scripts."""

import glob
import json
import os
import sys
from pathlib import Path

# Data directory location
DATA_DIR = Path("/Users/frankwang/Dropbox/personal_sync_doc/tailwindplus")


def find_latest_data_file() -> Path:
    """Find the most recent TailwindPlus JSON data file."""
    pattern = str(DATA_DIR / "tailwindplus-components-*.json")
    files = glob.glob(pattern)
    if not files:
        print(f"Error: No TailwindPlus data files found in {DATA_DIR}", file=sys.stderr)
        sys.exit(1)
    # Sort by modification time, newest first
    files.sort(key=os.path.getmtime, reverse=True)
    return Path(files[0])


def load_data() -> dict:
    """Load the TailwindPlus JSON data."""
    data_file = find_latest_data_file()
    with open(data_file) as f:
        return json.load(f)


def build_component_index(tailwindplus_data: dict) -> dict:
    """Build lookup index for component access."""
    index = {}

    def traverse(obj: dict, path: list[str] | None = None):
        if path is None:
            path = []
        for key, value in obj.items():
            current_path = path + [key]

            if isinstance(value, dict) and "snippets" in value:
                component_name = ".".join(current_path)
                for snippet in value["snippets"]:
                    framework = snippet["name"]  # html/react/vue
                    version = str(snippet["version"])  # "3" or "4"
                    mode = snippet["mode"]  # light/dark/system/None
                    if mode is None:
                        mode = "none"

                    lookup_key = (component_name, framework, version, mode)
                    index[lookup_key] = snippet
            elif isinstance(value, dict):
                traverse(value, current_path)

    traverse(tailwindplus_data)
    return index


def get_all_component_names(index: dict) -> list[str]:
    """Extract unique component names from index."""
    return sorted({key[0] for key in index})
