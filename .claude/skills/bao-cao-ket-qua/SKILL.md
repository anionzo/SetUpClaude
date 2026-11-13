---
name: bao-cao-ket-qua
description: Present experiments, figures and results (kết quả, thực nghiệm) in theses (luận văn, đề án), papers and technical reports. Use when designing the experiments section (evaluation questions, data, baselines, metrics), writing result tables/charts, reporting statistics (mean, deviation, confidence interval, tests, effect size), LLM-as-a-judge evaluation, error analysis, qualitative examples, the limitations and threats-to-validity section, or checking whether a conclusion goes beyond the data.
---

# Presenting experiments and results

Related skills: `van-phong-hoc-thuat` (style; its `references/llm-tu-soat.md` has the LLM read-back protocol), `trich-dan-tai-lieu` (citations), `tim-va-kiem-nguon` (verifying sources), `trinh-bay-van-ban-hoc-thuat` (document formatting).

General principle: **every number traces back to the original result file; every conclusion stays within what the data allow.** Style follows `van-phong-hoc-thuat`.

## 1. Design the experiments section (write before running)
1. **Evaluation questions** (RQ1, RQ2…): each matches one objective or contribution; state explicitly any question that cannot be measured as out of scope.
2. **Data:** source, how collected/generated, size, distribution by group, train/dev/test split, whether there is leakage between the set used to generate questions and the retrieval set.
3. **Baselines:** the simplest reasonable method + the best existing method; same budget (data, parameters, model calls).
4. **Metrics:** define clearly (formula or rating scale) and say why chosen; fix the primary metric before seeing results.
5. **Pass threshold** (if any): fix beforehand, record the date it was fixed.
6. **Configuration:** model version, parameters, hardware, number of runs, seed; run identifier.

## 2. Report numbers
- State **n** for every proportion: "412/450 ca (91,6%)", not just "99%".
- Pair the mean with a measure of spread: mean ± standard deviation, or median and percentiles (P50, P95) for latency (skewed distribution).
- Multiple runs: report the mean and the between-run deviation, or the 95% confidence interval.
- Comparing two systems: difference + an appropriate test (paired t-test, Wilcoxon, McNemar for paired correct/incorrect, bootstrap) + effect size; give the exact p-value (p = 0,03), not just "p < 0,05". Without a test, do not use "có ý nghĩa"/"đáng kể".
- Round consistently (same number of decimals within one table); do not report more digits than the measurement precision supports.
- Scales: state them explicitly ("thang 1–5"), and state where chart axes start (add a note if not from 0).
- Vietnamese number conventions: 4,95; 1.250; a space before units.

## 3. Result tables
- One main table answers the main RQ; rows = methods/configurations, columns = metrics; units in column headers; arrows ↑/↓ show whether higher or lower is better.
- Bold the best value **only when** the difference is significant or there is a clear note.
- Table captions must be self-contained: which data, what n, which configuration.
- Ablation: remove one component at a time and report the change.

## 4. Charts
- Choose the right type: comparing values → bar; trend over a continuous variable → line; distribution → histogram/boxplot; correlation → scatter.
- Axis labels with units; the legend must not cover data; colors must be distinguishable in black and white (add markers/line styles); the same color for the same method in every figure.
- Mark log axes explicitly; put numbers on bars only when there are few bars.
- Plot from the data file (script), never by hand; give the source file name in the caption or appendix.

## 5. LLM evaluation (LLM-as-a-judge)
- State the judge model, version, temperature, the judging prompt (put it in an appendix), the scale and the criteria.
- State known biases: judging with the same family/model as the generator (self-preference), length bias, position bias; and mitigations (judge from a different family, swap order, blind judging).
- Compare with human raters on a subsample and report agreement (Cohen's κ, Krippendorff's α, or Spearman correlation). If not yet done, state it as a limitation.
- Questions auto-generated from the very documents being retrieved: scores may be optimistic; say so.

## 6. Error analysis and qualitative examples
- Sample errors systematically (all failed cases if few; stratified random if many), classify the causes, and count by type.
- Qualitative examples: pick both good and bad cases, record case IDs so they can be traced; shorten long outputs but do not alter their content.

## 7. Limitations and threats to validity
A single section, grouped by:
- **Internal validity:** implementation bugs, data leakage, biased raters.
- **Construct validity:** whether the metric measures what it is meant to measure.
- **External validity:** generalization to other data/users/domains.
- **Conclusion reliability:** sample size, number of runs, tests.
For each item: what the risk is, what was done to reduce it, what remains.

## 8. Conclusions that do not exceed the data
Check each conclusion sentence:
- Which table/figure is this sentence based on? If none → delete it or turn it into a hypothesis.
- Scope: which data, which configuration? Put it in the sentence.
- Use verbs of the right strength (`van-phong-hoc-thuat/references/giong-van.md` section 3).
- Any objective not measured → write "chưa đo"; do not infer it from another metric.

## 9. Reproducibility
Store with the thesis/paper: run identifier, configuration files, raw result files, plotting scripts, library versions; an appendix or code repository with a path/link.
