#!/usr/bin/env python3
"""Display TailwindPlus data file information."""

from common import find_latest_data_file, load_data


def main():
    data_file = find_latest_data_file()
    data = load_data()

    print("TailwindPlus Data Information")
    print("=" * 50)
    print(f"Data file: {data_file}")
    print(f"Version: {data['version']}")
    print(f"Downloaded at: {data['downloaded_at']}")
    print(f"Component count: {data['component_count']}")
    print(f"Download duration: {data['download_duration']}")
    print(f"Downloader version: {data['downloader_version']}")


if __name__ == "__main__":
    main()
