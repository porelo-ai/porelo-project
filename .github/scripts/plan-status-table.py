#!/usr/bin/env python3
"""Prints the table of issues by status from the repositories checked out under a folder."""
import glob
import os
import re
import sys
from collections import Counter

COLUMNS = ["Idea", "Accepted", "Analyzed", "Estimated", "Backlog", "Implementing", "Review"]
STATUS = re.compile(r"^\*\*Status:\*\*\s*([A-Za-z]+)", re.M)


def counts_of(repository):
    """Counts the issue files of one checkout by their status."""
    counts = Counter()
    for path in glob.glob(os.path.join(repository, "issues", "**", "*.md"), recursive=True):
        if os.path.basename(path) == "README.md":
            continue
        with open(path, encoding="utf-8") as file:
            found = STATUS.search(file.read())
        counts[found.group(1) if found else "none"] += 1
    return counts


def main(root):
    """Prints one row per repository, the most issues first, then by name."""
    rows = []
    for repository in glob.glob(os.path.join(root, "porelo*", "")):
        name = os.path.basename(repository.rstrip(os.sep))
        counts = counts_of(repository)
        total = sum(counts[column] for column in COLUMNS)
        cells = " | ".join(str(counts[column]) for column in COLUMNS)
        rows.append((-total, name, f"| {name} | {total} | {cells} |"))
    print("| Repository | Total | " + " | ".join(COLUMNS) + " |")
    print("|---|" + "---:|" * (len(COLUMNS) + 1))
    for row in sorted(rows):
        print(row[2])


if __name__ == "__main__":
    main(sys.argv[1])
