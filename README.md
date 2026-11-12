# kanji-db-data

Open datasets built for [kanji-db.com](https://kanji-db.com), a free Japanese kanji dictionary
(13,108 kanji, 175,000 words, stroke-order animation, handwriting search).

Every file here is **derived by cross-referencing open data** — KANJIDIC2, JMdict, KanjiVG,
IDS and Unihan — not copied from another dictionary. The same files are served at
<https://kanji-db.com/data>.

[日本語の説明は下にあります。](#日本語)

## Datasets (`data/`)

All files are UTF-8, tab-separated, with a header row.

| File | Rows | What it is | Columns |
|---|---|---|---|
| `similar-kanji.tsv` | 22,331 | Visually similar kanji pairs, derived from component structure (IDS) — e.g. 待 / 侍 | `kanji` `similar` `kind` |
| `phonetic-series.tsv` | 5,743 | Phonetic components and the kanji that take their on'yomi — e.g. 青 → 清・晴・精 | `component` `reading` `kanji` |
| `kunyomi-groups.tsv` | 291 | Native (kun) readings shared by several jōyō kanji — e.g. はかる = 計・量・図・測 | `reading` `forms` |
| `homophone-groups.tsv` | 1,275 | Common words that share a reading — e.g. こうせい = 構成・公正・厚生 | `reading` `word_count` `words` |
| `antonyms.tsv` | 555 | Antonym pairs declared in JMdict | `word` `reading` `antonym` `antonym_reading` |
| `unlisted-variants.tsv` | 831 | Characters missing from KANJIDIC2, mapped to a listed standard form — e.g. 髙 → 高 | `unlisted` `listed` `kind` |

`datapackage.json` describes the same files in [Frictionless Data](https://frictionlessdata.io/) format.

## Ready-to-use kits (`kits/`)

| File | What it is |
|---|---|
| `anki-joyo-kanji.tsv` | An Anki deck of all 2,136 jōyō kanji, with stroke-order diagrams embedded as inline SVG (works without a Japanese font), meanings, readings and example words. Import it directly — the header lines set the separator and HTML mode. |
| `ime-difficult-readings.txt` | IME user dictionary of 715 difficult readings (熟字訓・当て字), e.g. きょう → 今日 |
| `ime-old-forms.txt` | IME user dictionary of 546 old and variant character forms, e.g. くに → 國 |

## License

**CC BY-SA 4.0** — inherited from KANJIDIC2, JMdict and KanjiVG. Attribution for each upstream source
is in [`ATTRIBUTION.md`](ATTRIBUTION.md) and at <https://kanji-db.com/licenses>.

If you use this data, **a link back to <https://kanji-db.com> would be greatly appreciated.**
This is a request, not a license condition.

## Updates

The files are exported from the kanji-db.com database. When the site's data is rebuilt, the same export
is copied here, so this repository and <https://kanji-db.com/data> always hold identical files.

---

## 日本語

[漢字データベース(kanji-db.com)](https://kanji-db.com) が、漢字のオープンデータ
(KANJIDIC2・JMdict・KanjiVG・IDS・Unihan)を突き合わせて作ったデータセットです。
出典のデータをそのまま写したものではなく、組み合わせて新しく作ったものを置いています。
同じファイルを <https://kanji-db.com/data> でも配っています。

| ファイル | 中身 | 件数 |
|---|---|---|
| `data/similar-kanji.tsv` | 似ている漢字の組(字の組み立てから作成。例: 待/侍) | 22,331組 |
| `data/phonetic-series.tsv` | 音符と、その音で読む漢字(例: 青 → 清・晴・精) | 5,743行 |
| `data/kunyomi-groups.tsv` | 同じ訓読みを持つ常用漢字(例: はかる = 計・量・図・測) | 291の読み |
| `data/homophone-groups.tsv` | 同じ読みの語(例: こうせい = 構成・公正・厚生) | 1,275の読み |
| `data/antonyms.tsv` | 対義語の組(JMdict に記載のもの) | 555組 |
| `data/unlisted-variants.tsv` | 辞書データに無い字から標準の字への対応(例: 髙 → 高) | 831組 |
| `kits/anki-joyo-kanji.tsv` | 常用漢字2,136字の Anki デッキ(筆順の図入り) | 2,136字 |
| `kits/ime-difficult-readings.txt` | 難読漢字の IME 辞書 | 715語 |
| `kits/ime-old-forms.txt` | 旧字体・異体字の IME 辞書 | 546字 |

ライセンスは **CC BY-SA 4.0** です(KANJIDIC2・JMdict・KanjiVG から引き継ぎます)。
出典ごとの帰属表示は [`ATTRIBUTION.md`](ATTRIBUTION.md) と <https://kanji-db.com/licenses> にあります。

お使いいただく際は、**<https://kanji-db.com> へのリンクを載せていただけるとうれしいです。**
これはお願いであって、ライセンス上の条件ではありません。
