# Key Findings — Online Retail Analysis

Plain-language summary. (Data: real UK online retailer, Dec 2009 – Dec 2011.)

## 1. The returns figure everyone quotes is roughly double the truth

The obvious calculation says returns erode ~7% of revenue. Investigation showed
**over half of the recorded "returns" value was accounting adjustments** — manual
corrections, Amazon fees, bank charges, postage reversals — not merchandise
coming back. Genuine product returns are ~£717K, a **true return rate of ~3.6%**.

**Lesson:** the first number an analysis produces is a hypothesis, not an answer.
Interrogating it is the job.

## 2. Sales peak in November, not December

Revenue ramps from September, peaks in **November**, and steps down in December.
This fits a gift retailer selling largely to wholesalers, who buy *ahead* of the
Christmas consumer season. Over half the year's revenue lands in Sept–Dec.

**Business implication:** inventory, cash flow, and marketing should concentrate
in autumn, ahead of the sales peak.

## 3. Returns concentrate after Christmas

The genuine product-return rate sits at ~1.4–3.7% most of the year but spikes to
**9.7% in December and 7.7% in January** — the post-Christmas returns wave. The
November sales peak, by contrast, has one of the *lowest* return rates (~2%):
planned wholesale buying comes back rarely.

**Business implication:** returns-processing and refund staffing should peak in
Dec–Jan — a month *after* the sales-staffing peak.

## 4. Top revenue ≠ top volume

The Regency Cakestand earns the most revenue but isn't the best seller by units
(the White Hanging Heart Holder is). "Best product" depends on whether you mean
revenue or volume — and a good report distinguishes them.

## 5. Data-quality anomalies worth flagging

Two items (Paper Craft Little Birdie, Medium Ceramic Storage Jar) were sold and
returned in near-identical quantities — behaving like bulk booking corrections,
not normal retail. Flagged for investigation rather than reported as ordinary
sales.

## The through-line

At every level — aggregate returns, seasonal returns, product rankings — the raw
figures were distorted by non-merchandise entries (postage, manual adjustments,
fees). The value of this project is identifying that contamination and reporting
corrected, defensible numbers that reconcile across SQL, Python, and Power BI.
