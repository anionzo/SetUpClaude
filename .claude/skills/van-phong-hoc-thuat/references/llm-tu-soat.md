# LLM self-review protocol (read back, then fix)

Use this when an LLM (you, a subagent, or another model) writes, polishes, translates or reviews academic text. A single pass misses most problems: repetition across chapters, voice drift, term drift and overclaims are only visible after the model has read the whole document. Work in passes; do not edit during the inventory pass.

## Pass 0 — Scope and freeze list
- State the task: write / polish / translate / review-only. Review-only means no file edits, report only.
- Record what must NOT change: numbers, run IDs, citations `[n]`/`\cite{}`, `\label`/`\ref`, figures, table cell contents, equations, code, section structure, headings (spelling/capitalization only).
- Snapshot for later diff: count of `\cite`, `\ref`, `\label`, digits per file (see Pass 4).

## Pass 1 — Read everything, edit nothing (inventory)
Read the full document (all chapters, abstract, front matter) before touching anything. Produce an inventory:
1. **Voice:** which self-references occur ("học viên", "tôi", "chúng tôi", "tác giả", "người viết", "đề án/luận văn") and where. Pick the one rule to apply.
2. **Terms:** every technical term and all its variants (e.g. "embedding / nhúng / vector nhúng"). Choose one form per concept → glossary.
3. **Repeated ideas:** claims, limitations, definitions, numbers that appear in more than one place. For each, choose the single home; everywhere else becomes a cross-reference or is deleted.
4. **Claims:** every evaluative or causal claim; mark the evidence behind it (table/figure/citation/none). "none" → soften or remove.
5. **Flattery and filler:** words from the no-flattery list (`giong-van.md` §2), opening clichés, khẩu ngữ.
6. **Translationese:** passive "được… bởi", "việc/sự" stacks, "của" chains, "nó", sentence-initial "Bằng cách", English word order (`dich-lech.md` §3).
7. **Capitalization and format:** Title Case headings/captions, random capitals, decimal/thousand separators, units (`dinh-dang.md`).
8. **Factual gaps:** places that need data you do not have → mark `% TODO:`; never invent.

Write the inventory to a scratch note (or the report) before Pass 2.

## Pass 2 — Edit, one file/chapter at a time
- Apply the voice rule, glossary, and "single home" decisions from Pass 1.
- Work paragraph by paragraph: topic sentence first; remove closing sentences that restate the opening; merge sentences with the same idea; split sentences over ~40 words.
- Replace unsupported adjectives with the number or a neutral description; downgrade verbs to match evidence (`giong-van.md` §3).
- Keep length within a few percent of the original (polish ≠ expand).
- Edit files directly with a file-editing tool, not shell heredocs (backslash escapes corrupt LaTeX).

## Pass 3 — Read back as the reader
Re-read each edited file from the top without looking at the original:
- Does each paragraph say one thing, and is it said only once in the document?
- Would a domain expert say each term this way?
- Does any sentence still sound translated? Rewrite by meaning.
- Does any sentence claim more than the cited table/figure shows?
- Read the chapter opening and the chapter conclusion together: the conclusion must not list the same items again.
Fix what you find, then read the changed paragraphs once more.

## Pass 4 — Mechanical verification
```bash
# citations, refs, labels unchanged (compare with Pass 0 snapshot)
grep -o '\\cite[a-z]*{[^}]*}' file.tex | sort | md5sum
grep -o '\\\(ref\|label\|eqref\){[^}]*}' file.tex | sort | md5sum
# numbers unchanged
grep -oE '[0-9]+([.,][0-9]+)*' file.tex | sort | md5sum
# control characters from bad writes
grep -nP '[\x00-\x08\x0B\x0C\x0E-\x1F]' *.tex
# leftover banned words / voice
grep -nE 'vượt trội|đáng kể|mạnh mẽ|toàn diện|tối ưu|chúng tôi|chúng ta' chapters/*.tex
```
Then build (LaTeX) and check: 0 errors, no new undefined references or citations, page count plausible.
If a checksum changed, diff that file and confirm each change was intended.

## Pass 5 — Report
```
Files changed: …
Voice rule applied: …
Glossary decisions: term → chosen form (variants replaced)
Repetitions removed: idea → kept at §x, removed/cross-referenced at §y, §z
Claims softened: §x "…" → "…" (reason)
TODO left for the author: …
Checks: citations/refs/numbers unchanged (yes/no + exceptions), build ok, pages N
```

## Delegating to several agents
- Split by disjoint files; give each agent the SAME rule sheet: the ten core rules (SKILL.md), the voice rule, the glossary, and the "single home" list from Pass 1. The inventory (Pass 1) is done once, centrally, before splitting.
- Agents write files and a report; one coordinator reviews and commits.
- Independent review: a different model reads the result review-only and reports in the `kiem-tra.md` template; the coordinator filters suggestions (drop ones that change content or are technically wrong) before applying.

## Prompt skeleton for a polishing agent
```
Task: polish the academic Vietnamese of <files>. Do not change content.
Read first: <path>/van-phong-hoc-thuat/SKILL.md and references/giong-van.md, dich-lech.md, dinh-dang.md.
Rules fixed for this document:
- Voice: <rule>. Glossary: <term → form>. Single home for limitations: §<x>; elsewhere cross-reference.
Freeze: numbers, citations, \label/\ref, figures, tables, equations, code, headings (except capitalization).
Process: read all assigned files before editing (inventory), edit, read back, run the Pass 4 checks, build.
Output: edited files + report in the Pass 5 format at <report path>. Do not commit.
```

## Prompt skeleton for a translation-review agent
```
Review-only. Compare <translated file> with <source file> sentence by sentence.
Report each problem as: location | source | translation | category (accuracy, terminology, naturalness, style, convention) | fix.
Check especially: negation and comparison direction, hedges (may/suggest), numbers and units, names, terms against <glossary>, added or missing content.
Then read the translation alone and list sentences that sound translated.
```
