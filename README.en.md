# Monthly Bill Analyzer Agent

[简体中文](README.md) | [繁體中文](README.zh-TW.md) | [English](README.en.md) | [日本語](README.ja.md)

A local-first monthly bill analyzer agent. Drop WeChat, Alipay, bank, U card, Hong Kong card, PDF, or screenshot statements into the web app. It parses transactions, removes duplicates, converts multi-currency flows into CNY-based summaries, and generates monthly spending reports plus next-month planning advice.

By default, everything runs locally. Bill content is sent to an external service only when you explicitly enable AI analysis and configure an OpenAI-compatible API provider.

## Support

If this local bill agent helps you, you can support the project with a scan. Thanks for supporting continued polish and development.

<p>
  <a href="frontend/public/sponsor/alipay.jpg"><img src="frontend/public/sponsor/alipay.jpg" alt="Alipay payment QR code" width="180" /></a>
  <a href="frontend/public/sponsor/wechat-pay.jpg"><img src="frontend/public/sponsor/wechat-pay.jpg" alt="WeChat Pay payment QR code" width="180" /></a>
  <a href="frontend/public/sponsor/usdt-polygon.jpg"><img src="frontend/public/sponsor/usdt-polygon.jpg" alt="USDT Polygon payment QR code" width="180" /></a>
</p>

## Features

- Multi-file upload: `.csv`, `.xlsx`, `.xls`, text PDF, `.png/.jpg/.jpeg/.webp`
- Statement source detection: WeChat, Alipay, bank, U card, Hong Kong card, multi-currency card, fallback parser
- AI-first extraction: when enabled, CSV/XLSX/PDF/screenshots are sent to AI extraction first; CSV/XLSX/PDF can fall back to local parsing
- Scanned PDFs: when text extraction fails, the first 4 pages can be converted to images for a vision model
- Deduplication: duplicate files and suspected duplicate transactions are skipped
- Multi-currency analysis: HKD, USD, USDT, and other supported currencies are converted into CNY summaries while original-currency totals are preserved
- Reports: income, expense, net cash flow, daily trend, categories, top merchants, large expenses, suspected duplicate charges
- AI advice: spending habits, risk alerts, budget advice, and next-month planning
- Export: Markdown and HTML reports
- UI languages: Simplified Chinese, Traditional Chinese, English, Japanese

## Quick Start With Docker

Install Docker Desktop first.

```bash
git clone https://github.com/cjk88866/monthly-bill-analyzer.git
cd monthly-bill-analyzer
docker compose up --build
```

Open:

```text
http://127.0.0.1:5173
```

Stop:

```bash
docker compose down
```

Local uploads and reports are stored in:

```text
data/uploads
data/reports
```

## AI API Setup

In the **AI Agent** panel, fill in:

- `Base URL`: for example `https://api.openai.com/v1`, or another OpenAI-compatible provider
- `Analysis model`: used for statement extraction and planning advice, for example `gpt-4o-mini` or `deepseek-chat`
- `Vision model`: used for screenshots and scanned PDF image pages, for example `gpt-4o` or a provider-specific VL model
- `API Key`: your provider key

API keys are entered in the browser UI and are not committed to the repository.

## Development

Backend:

```bash
cd backend
python3 -m venv .venv
.venv/bin/python -m pip install -e '.[dev]'
.venv/bin/uvicorn app.main:app --reload --port 8000
```

Frontend:

```bash
cd frontend
npm install
npm run dev -- --host 127.0.0.1
```

## Test

```bash
cd backend
.venv/bin/python -m pytest -q
cd ../frontend
npm run build
cd ..
docker compose config
```

## Privacy And Limits

- The app does not connect to WeChat, Alipay, or bank accounts.
- Local mode does not send bill content to external services.
- AI mode sends relevant bill content to your configured model provider.
- Exchange rates are built-in reference rates, not real-time settlement rates.
- Scanned PDF recognition is limited to the first 4 pages by default.
- AI/OCR/category results can be wrong. Use reports for personal budgeting reference only.

See [Deployment](docs/DEPLOYMENT.md) and [Privacy](docs/PRIVACY.md).

## License

MIT
