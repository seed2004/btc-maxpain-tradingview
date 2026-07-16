# TradingView Publish Description (English)

> Copy the text below into the description field when publishing the script
> to the main (English) TradingView community.

---

**BTC / ETH / SOL / HYPE Max Pain (Deribit) — every key expiry's Max Pain level on a single chart**

> The same text works for publishing every coin's script (BTC / ETH / SOL / HYPE) —
> adjust the coin name in the title to match the script you are publishing.

## What this indicator does

Plots the **Max Pain** price of crypto options (BTC, ETH, SOL, HYPE) on Deribit, per expiration date, as dashed horizontal lines on your chart. Each line:

- Has its **own color** per expiry, with a label showing the expiry date / Max Pain price / total Open Interest
- Extends from the current bar to that expiry's **actual settlement time** (08:00 UTC) — so you can see exactly when each level "expires"
- Has its **width scaled by Open Interest** — expiries where the money is concentrated (monthlies/quarterlies) draw thicker than thin weeklies

## What is Max Pain?

Max Pain is the strike price at which the total value of all outstanding options — both calls and puts, weighted by Open Interest — expires **as worthless as possible**. It is the price where option buyers hurt the most and option sellers (typically market makers) benefit the most. The theory holds that as expiration approaches, delta-hedging flows tend to pull price toward this level, so traders watch it as a magnet zone / options-flow-based support and resistance to complement their analysis.

## Where the data comes from

Computed from the per-contract Open Interest of all options on the **Deribit public API** (free, no key required) using the standard method: for every strike, assume price settles there and sum the payout owed to all option holders — the strike with the lowest total payout is Max Pain. BTC/ETH are inverse options; SOL/HYPE are USDC-settled, with Open Interest normalized by contract size (1 contract = 10 coins) so totals are in actual coins.

Since Pine Script cannot access the internet on its own, this indicator takes its data through the **"Data"** input field in Settings, formatted as comma-separated `YYMMDD:maxpain:oi`. The string is generated automatically by an open-source Python script in the linked repository — one command fetches fresh data and copies the string to your clipboard, ready to paste (pick the coin with `--currency BTC` / `ETH` / `SOL` / `HYPE`).

## How to use

1. Add the indicator to the matching chart — BTC → BTCUSD, ETH → ETHUSD, SOL → SOLUSD, HYPE → HYPEUSD (recommended timeframe: **D and above** — on intraday timeframes TradingView clamps drawings to ~500 bars into the future, so distant expiries will be displayed closer than they really are)
2. To update the data: run the script from the repo (or compute your own) → paste the new string into the Data field → OK
3. Options: show/hide OI in labels, hide already-settled expiries

## Settings

- **Data** — the data string (`YYMMDD:maxpain:oi,...` — OI is denominated in coins, matching the script's coin)
- **Show total OI in label** — display total Open Interest in each label
- **Hide expired** — hide expiries that have already settled

⚠️ Max Pain is a theoretical framework. Price does not always gravitate toward it, especially when strong directional forces dominate the market — this is not financial advice.

Source code + automatic data generator: github.com/seed2004/btc-maxpain-tradingview
