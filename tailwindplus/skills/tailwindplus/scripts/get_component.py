#!/usr/bin/env python3
"""Get TailwindPlus component code by full name."""

import argparse
import sys

from common import build_component_index, get_all_component_names, load_data


def find_suggestions(name: str, all_names: list[str], max_suggestions: int = 5) -> list[str]:
    """Find similar component names for suggestions."""
    name_parts = [part.lower() for part in name.lower().split(".")]
    suggestions = [
        comp_name
        for comp_name in all_names
        if any(part in comp_name.lower() for part in name_parts)
    ]
    return suggestions[:max_suggestions]


def validate_mode(full_name: str, mode: str) -> str | None:
    """Validate mode matches component type. Returns error message or None."""
    if full_name.startswith("Ecommerce"):
        if mode != "none":
            return f"eCommerce component '{full_name}' must use mode='none'. Got mode='{mode}'. eCommerce components only support mode='none'."
    else:
        if mode == "none":
            return f"Component '{full_name}' cannot use mode='none'. Got mode='{mode}'. Application UI and Marketing components support modes: 'light', 'dark', 'system'."
    return None


def main():
    parser = argparse.ArgumentParser(
        description="Get TailwindPlus component code",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  python get_component.py "Application UI.Forms.Input Groups.Simple" --framework html --version 4 --mode light
  python get_component.py "Ecommerce.Components.Product Overviews.With image gallery" --framework react --version 4 --mode none
        """,
    )
    parser.add_argument("full_name", help="Full dotted path of the component")
    parser.add_argument(
        "--framework",
        "-f",
        required=True,
        choices=["html", "react", "vue"],
        help="Target framework",
    )
    parser.add_argument(
        "--version",
        "-v",
        required=True,
        choices=["3", "4"],
        help="Tailwind CSS version",
    )
    parser.add_argument(
        "--mode",
        "-m",
        required=True,
        choices=["light", "dark", "system", "none"],
        help="Theme mode (use 'none' for eCommerce components)",
    )

    args = parser.parse_args()

    # Validate mode
    mode_error = validate_mode(args.full_name, args.mode)
    if mode_error:
        print(f"Error: {mode_error}", file=sys.stderr)
        sys.exit(1)

    # Load data and build index
    data = load_data()
    index = build_component_index(data["tailwindplus"])

    # Look up component
    lookup_key = (args.full_name, args.framework, args.version, args.mode)

    if lookup_key not in index:
        all_names = get_all_component_names(index)
        suggestions = find_suggestions(args.full_name, all_names)

        print(f"Error: Component '{args.full_name}' not found.", file=sys.stderr)
        if suggestions:
            print("\nDid you mean one of these?", file=sys.stderr)
            for s in suggestions:
                print(f"  - {s}", file=sys.stderr)
        sys.exit(1)

    snippet = index[lookup_key]

    # Output component info and code
    print(f"# Component: {args.full_name}")
    print(f"# Framework: {args.framework}")
    print(f"# Tailwind Version: {args.version}")
    print(f"# Mode: {args.mode}")
    print(f"# Language: {snippet['language']}")
    print(f"# Supports Dark Mode: {snippet['supportsDarkMode']}")
    print("-" * 60)
    print(snippet["code"])


if __name__ == "__main__":
    main()
