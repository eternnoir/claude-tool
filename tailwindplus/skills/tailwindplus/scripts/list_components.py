#!/usr/bin/env python3
"""List all TailwindPlus component names."""

from common import build_component_index, get_all_component_names, load_data


def main():
    data = load_data()
    index = build_component_index(data["tailwindplus"])
    names = get_all_component_names(index)

    print(f"TailwindPlus Components ({len(names)} total):")
    print("-" * 50)

    # Group by category
    categories: dict[str, list[str]] = {}
    for name in names:
        parts = name.split(".")
        category = parts[0]
        if category not in categories:
            categories[category] = []
        categories[category].append(name)

    for category in sorted(categories.keys()):
        print(f"\n## {category} ({len(categories[category])} components)")
        for name in sorted(categories[category]):
            # Remove category prefix for cleaner display
            short_name = ".".join(name.split(".")[1:])
            print(f"  - {short_name}")


if __name__ == "__main__":
    main()
