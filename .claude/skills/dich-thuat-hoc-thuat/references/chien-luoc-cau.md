# Sentence strategies for translation

Academic English favors nominalization, the passive, nested relative clauses and dummy subjects. Academic Vietnamese favors verbs, the active voice or formally subjectless sentences, shorter sentences, and given-before-new information order. Good translation means restructuring to suit the target language.

## A. English → Vietnamese

### 1. Passive
| Source | Literal (avoid) | Natural |
|---|---|---|
| The data were collected from 12 schools. | Dữ liệu được thu thập bởi 12 trường. (wrong meaning) | Dữ liệu được thu thập tại 12 trường. / Học viên thu thập dữ liệu tại 12 trường. |
| It is assumed that the noise is Gaussian. | Nó được giả định rằng nhiễu là Gauss. | Giả định nhiễu có phân phối Gauss. |
| The model was trained for 10 epochs. | Mô hình đã được huấn luyện bởi 10 epoch. | Mô hình được huấn luyện 10 epoch. |
| These results are discussed in Section 5. | Các kết quả này được thảo luận ở Mục 5. | Mục 5 thảo luận các kết quả này. |

Use "được" for beneficial or neutral events and "bị" for adverse ones ("bị loại", "bị nhiễu"). Do not use "bởi" when the agent is not a person or thing performing the action.

### 2. Nominalization → verb
| Source | Literal | Natural |
|---|---|---|
| The implementation of the proposed method requires… | Sự triển khai của phương pháp được đề xuất đòi hỏi… | Triển khai phương pháp đề xuất cần… |
| An increase in temperature leads to a reduction of yield. | Sự gia tăng của nhiệt độ dẫn đến sự giảm của năng suất. | Nhiệt độ tăng làm năng suất giảm. |
| We performed an analysis of… | Chúng tôi thực hiện một sự phân tích về… | Chúng tôi phân tích… |

### 3. Dummy subjects, special constructions
| Source | Natural |
|---|---|
| It is important to note that… | Cần lưu ý rằng… (often can be dropped entirely) |
| It can be seen that… | Có thể thấy… / (drop it, state directly what is seen) |
| There are three reasons for… | Có ba lý do khiến… |
| There is little evidence that… | Chưa có nhiều bằng chứng cho thấy… |
| This allows the system to… | Nhờ vậy, hệ thống có thể… / Cách này cho phép hệ thống… |
| …, which makes it difficult to… | …; điều đó khiến việc … khó hơn. / …, nên khó … |
| Not only A but also B | Không chỉ A mà còn B / A, đồng thời B |
| The more…, the more… | Càng… càng… |
| A is to B what C is to D | (rephrase according to the meaning) |

### 4. Long relative clauses, multi-layer sentences
Source: *The framework, which was originally developed for retail data and has since been adapted to several domains in which labeled data are scarce, achieves results that are comparable to those of supervised methods.*
- Literal: "Khung, mà ban đầu được phát triển cho dữ liệu bán lẻ và kể từ đó đã được điều chỉnh cho một số lĩnh vực mà ở đó dữ liệu có nhãn là khan hiếm, đạt được những kết quả mà có thể so sánh với những kết quả của các phương pháp có giám sát."
- Split into sentences: "Khung này ban đầu được phát triển cho dữ liệu bán lẻ, sau đó được điều chỉnh cho một số lĩnh vực ít dữ liệu có nhãn. Kết quả của nó gần với các phương pháp có giám sát."
Method: find the main clause → turn subordinate clauses into separate sentences or short attributive phrases → drop redundant "mà", "những", "của".

### 5. Information order
In Vietnamese, adverbials of time/place/condition usually come first; new, important information goes at the end of the sentence.
- *The accuracy improved by 4 points when reranking was enabled.* → "Khi bật xếp hạng lại, độ chính xác tăng 4 điểm."
- *Section 3 describes the dataset, and Section 4 the method.* → "Mục 3 mô tả bộ dữ liệu; Mục 4 trình bày phương pháp." (do not elide the verb as English does)

### 6. Pronouns and reference
- *it, they, this, these* → restate the noun ("mô hình", "các tham số") or use "này/đó" after the noun. Avoid "nó", "chúng" in academic prose when they could be ambiguous.
- *the former / the latter* → restate the name.
- *respectively* → write the pairing explicitly: "A và B lần lượt đạt 0,81 và 0,77" (keep "lần lượt").

### 7. Plurals, articles, quantifiers
- Drop "một" for the article a/an when counting is not needed: "a novel approach" → "cách tiếp cận mới" (and consider dropping "mới").
- "the" → do not translate, or use "này/đó" when a demonstrative is needed.
- "several, a number of" → "một số"; "various" → "nhiều", "khác nhau"; "a variety of" → "nhiều loại".
- "data, information, research": do not mechanically add "các" ("các dữ liệu").

### 8. Tense and aspect
Vietnamese does not inflect for tense; add "đã", "đang", "sẽ" only when time must be distinguished. "We have shown that…" → "Kết quả cho thấy…" or "Mục 4 đã cho thấy…" (when referring to an earlier section). Do not sprinkle "đã" over every past-tense sentence.

### 9. Connectives
| English | Vietnamese |
|---|---|
| however | tuy nhiên |
| moreover, furthermore | ngoài ra, bên cạnh đó (do not open every sentence this way) |
| therefore, thus, hence | do đó, vì vậy |
| whereas, while (contrast) | trong khi, còn |
| whereby | theo đó, qua đó |
| in contrast | ngược lại |
| in other words | nói cách khác |
| namely, i.e. | tức là, cụ thể là |
| e.g. | ví dụ, chẳng hạn |
| respectively | lần lượt |
| in terms of | về (mặt) |
| with respect to | đối với, về |
| as a result | kết quả là, do đó |
| on the other hand | mặt khác (only when "on the one hand" is present or there is a real contrast) |
| to this end | để làm điều này, nhằm mục tiêu đó |

## B. Vietnamese → English

### 1. Subjectless sentences, adverbial subjects
- "Qua khảo sát cho thấy 70% học viên…" → *The survey showed that 70% of students…*
- "Trong chương này trình bày…" → *This chapter presents…*
- "Cần xây dựng cơ chế…" → *A mechanism is needed to…* / *It is necessary to establish…* (prefer sentences with a real subject).

### 2. Verb chains, sentences strung together with commas
Vietnamese often chains many clauses with commas; English needs conjunctions or sentence splits (avoid comma splices).
- "Hệ thống nhận yêu cầu, kiểm tra quyền, truy xuất tài liệu, trả kết quả." → *The system receives a request, checks permissions, retrieves documents, and returns the result.*

### 3. Reverse nominalization
Academic English accepts moderate nominalization, but avoid chains of "the + N + of + the + N + of".
- "Việc đánh giá hiệu năng của hệ thống" → *Evaluating system performance* / *The performance evaluation*.

### 4. Words easily mistranslated
| Vietnamese | Wrong | Right |
|---|---|---|
| nghiên cứu (countable noun) | researches | studies, research (uncountable) |
| thực hiện thí nghiệm | make experiments | conduct/perform experiments |
| thảo luận về | discuss about | discuss |
| theo | according with | according to |
| mặt khác | in the other hand | on the other hand |
| đáp ứng | answer the requirement | meet the requirements |
| nâng cao chất lượng | raise the quality | improve the quality |
| đối tượng nghiên cứu | research object | subject of study / study population (depending on field) |
| tính cấp thiết | urgency | rationale / motivation |
| giải pháp (kỹ thuật) | solution (acceptable) | approach, method when it means a method |
| thực trạng | reality | current situation / current state |
| tăng cường | strengthen (everywhere) | improve, enhance, increase depending on meaning |
| hiện nay | nowadays | currently / at present (or drop it) |
| góp phần | contribute to (acceptable) | avoid repeating it many times |
| dữ liệu | datas | data |
| phần mềm | softwares | software |
| phản hồi | feedbacks | feedback |
| trang thiết bị | equipments | equipment |
| kiến thức | knowledges | knowledge |
| lời khuyên | advices | advice |

### 5. Articles, singular/plural, tense
- A singular countable noun always needs an article or determiner: *a model, the model, this model*.
- First mention: *a*; already identified: *the*; general plural concept: no article ("Language models are…").
- Tense: present for general truths and the content of the paper ("Table 3 shows…"); past for what was done and measured results ("We collected…", "The model achieved…"); present perfect for literature reviews ("Several studies have proposed…").
- Be consistent in British or American spelling (analyse/analyze, modelling/modeling, behaviour/behavior) according to the venue's requirement.

### 6. Natural English hedging
| Vietnamese meaning | English |
|---|---|
| có thể | may, can (ability), could |
| cho thấy | show, indicate |
| gợi ý | suggest |
| dường như | appear to, seem to |
| nhiều khả năng | likely |
| trong phạm vi dữ liệu này | on this dataset, within the scope of this study |
| chưa đủ để kết luận | is insufficient to conclude |

### 7. Things Vietnamese writers often over-write in English
"In recent years, with the rapid development of…" (cliché opening) · "very", "really", "a lot of" · "In this paper, we will…" (drop "will") · "etc." in academic prose · "and so on" · "As we all know" · "It is obvious that".
