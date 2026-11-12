#!/usr/bin/env bash
# uball/kanji の配布データ(frontend/public/data)をこのリポジトリへ写す。冪等。
#   bash scripts/sync-from-kanji.sh [../kanji]
# 写したあと、kanji 側の index.json の sha256 と突き合わせる。食い違えば止まる。
set -euo pipefail
SRC="${1:-../kanji}/frontend/public/data"
cd "$(dirname "$0")/.."
[ -f "$SRC/index.json" ] || { echo "見つからない: $SRC/index.json" >&2; exit 1; }
mkdir -p data kits
for f in similar-kanji.tsv phonetic-series.tsv kunyomi-groups.tsv homophone-groups.tsv antonyms.tsv unlisted-variants.tsv datapackage.json; do
  cp "$SRC/$f" "data/$f"
done
for f in anki-joyo-kanji.tsv ime-difficult-readings.txt ime-old-forms.txt; do
  cp "$SRC/$f" "kits/$f"
done
python3 - "$SRC/index.json" <<'PY'
import hashlib, json, sys
index = json.load(open(sys.argv[1]))
bad = []
for f in index["files"]:
    got = hashlib.sha256(open("data/" + f["file"], "rb").read()).hexdigest()
    if got != f["sha256"]:
        bad.append(f["file"])
if not index["files"]:
    sys.exit("index.json にファイルが1件も無い")
if bad:
    sys.exit("sha256 が合わない: " + ", ".join(bad))
print(f"{len(index['files'])} 件の sha256 が一致")
PY
git status --short
