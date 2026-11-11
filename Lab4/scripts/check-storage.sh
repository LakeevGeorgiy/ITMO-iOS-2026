#!/bin/bash
set -euo pipefail

task_root="$(cd "$(dirname "$0")/.." && pwd)"
task_build_dir="$(mktemp -d "${TMPDIR:-/tmp}/films-storage-check.XXXXXX")"
trap 'rm -rf "$task_build_dir"' EXIT

xcrun swiftc -target "$(uname -m)-apple-macos14.0" \
    "$task_root/Films/Film.swift" \
    "$task_root/Films/FilmDetailsViewModel.swift" \
    "$task_root/Films/RatingViewModel.swift" \
    "$task_root/Tests/StorageCheck.swift" \
    -o "$task_build_dir/storage-check"
"$task_build_dir/storage-check"
