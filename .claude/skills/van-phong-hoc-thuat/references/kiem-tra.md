# Self-check and review

## 1. Pre-submission checklist
**Voice**
- [ ] One form of self-reference in the main text; declaration/acknowledgements follow the template.
- [ ] No self-praise words without numbers; no "chứng minh" when it is only "cho thấy".
- [ ] No repeated ideas across sentences, paragraphs, sections, chapters; limitations sit in one place.
- [ ] Chapter conclusions are 2–4 sentences and do not copy the chapter body.

**Wording**
- [ ] No run of clipped sentences, no sentence over 40 words.
- [ ] No colloquialisms, no machine-translated prose (passive "bởi", stacked "việc", "sự", "nó", vague "điều này").
- [ ] Terms follow the fixed table; no forced translations; no mixed forms.

**Formatting**
- [ ] Vietnamese capitalization; headings and captions in sentence case.
- [ ] Numbers: decimal comma, thousands period (Vietnamese); units with a space.
- [ ] Abbreviations defined at first use; the abbreviation list contains only terms that are used.
- [ ] Every figure/table is referred to in the main text; text in figures is legible.

**Citations**
- [ ] Every source verified to exist; every reference-list entry is cited.
- [ ] Consistent title capitalization; no stray strings in the reference list.

**Technical (LaTeX)**
- [ ] Build without errors, no Overfull/Underfull, no undefined references/citations, no "Missing character".
- [ ] No control characters in the source.
- [ ] Inspect the PDF visually: a few pages of each chapter, table of contents, reference list.

## 2. Quick check commands

PowerShell (Windows):
```powershell
$f = 'chapters\*.tex'
# mixed self-reference
Select-String -Path $f -Pattern 'chúng tôi|\btôi\b|người viết|tác giả'
# self-praise words
Select-String -Path $f -Pattern 'vượt trội|đáng kể|mạnh mẽ|toàn diện|tối ưu|hiệu quả cao|rất tốt|đột phá|hiện đại nhất'
# machine-translated prose
Select-String -Path $f -Pattern 'được \S+ bởi|việc thực hiện|sự thực hiện|các thông tin|các dữ liệu|Điều này'
# ordinary words capitalized mid-sentence (filter by hand; most are proper nouns)
Select-String -Path $f -Pattern '(?<=[\p{Ll},;] )\p{Lu}\p{Ll}+' -CaseSensitive -AllMatches
# English-style decimals in Vietnamese text
Select-String -Path $f -Pattern '\b\d+\.\d{1,2}\b(?!\.)'
# control characters
Select-String -Path $f -Pattern '[\x00-\x08\x0B\x0C\x0E-\x1F]'
```

bash:
```bash
grep -nE 'chúng tôi|\btôi\b|người viết|tác giả' chapters/*.tex
grep -nE 'vượt trội|đáng kể|mạnh mẽ|toàn diện|tối ưu|hiệu quả cao|rất tốt|đột phá' chapters/*.tex
grep -nE 'được [^ ]+ bởi|việc thực hiện|các thông tin|các dữ liệu' chapters/*.tex
grep -nP '[\x00-\x08\x0B\x0C\x0E-\x1F]' chapters/*.tex
```

Count term variants (example):
```bash
for t in "embedding" "nhúng" "tenant" "đơn vị" "rerank" "xếp hạng lại"; do printf "%s: " "$t"; grep -o "$t" chapters/*.tex | wc -l; done
```

## 3. Review report template
The reviewer only reads, does not edit files, and writes one report:

```markdown
# Review văn phong: <document name>

## Nhận xét chung (5–8 lines)
Tone, and how well each criterion is met: one voice, no self-praise, no repetition, coherence, terminology, dịch lệch, capitalization, abstract.

## Phát hiện (sorted by severity)
| Mức | Vị trí (file:line) | Câu gốc (short) | Tiêu chí | Đề xuất |
|---|---|---|---|---|
| Cao | ch3.tex:120 | "…" | dịch lệch | "…" |

## Chỗ lặp giữa các chương
| Chỗ A | Chỗ B | Nên giữ ở |

## Bảng thuật ngữ đề xuất
| Tiếng Anh | Cách viết hiện tại (count, example) | Đề xuất thống nhất | Lý do |
```

The writer filters the feedback: drop comments that change content, are technically wrong, or contradict school rules; fix the terminology table; apply changes across the board; rebuild and re-read.
