#!/usr/bin/env python3
"""Search TailwindPlus components by keyword."""

import sys

from common import build_component_index, get_all_component_names, load_data


def search_components(search_term: str) -> list[str]:
    """Search for components matching the search term."""
    data = load_data()
    index = build_component_index(data["tailwindplus"])
    names = get_all_component_names(index)

    # Case-insensitive search
    search_lower = search_term.lower()
    search_parts = search_lower.split()

    matches = []
    for name in names:
        name_lower = name.lower()
        # Match if all search parts appear in the name
        if all(part in name_lower for part in search_parts):
            matches.append(name)

    return matches


def main():
    if len(sys.argv) < 2:
        print("Usage: python search_components.py <search_term>")
        print("Example: python search_components.py hero")
        print("Example: python search_components.py 'pricing table'")
        sys.exit(1)

    search_term = " ".join(sys.argv[1:])
    matches = search_components(search_term)

    if not matches:
        print(f"No components found matching '{search_term}'")
        sys.exit(0)

    print(f"Found {len(matches)} component(s) matching '{search_term}':")
    print("-" * 50)
    for name in sorted(matches):
        print(f"  {name}")


if __name__ == "__main__":
    main()
