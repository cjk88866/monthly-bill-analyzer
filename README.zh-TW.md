# 月帳單分析 Agent

[简体中文](README.md) | [繁體中文](README.zh-TW.md) | [English](README.en.md) | [日本語](README.ja.md)

一個可本機部署的個人月帳單分析 Agent。把微信、支付寶、銀行、U 卡、港卡、PDF 或截圖帳單拖進網頁，它會解析交易、去重、按人民幣彙總多幣種流水，並生成每月消費報告和下個月規劃建議。

預設完全在本機執行；只有你在網頁中主動啟用 AI 智能分析時，程式才會把帳單文字、表格分片、截圖內容和彙總結果傳送到你配置的 OpenAI-compatible API。

## 贊助支持

如果這個本機帳單 Agent 對你有幫助，可以掃碼打賞支持。謝謝支持，專案會繼續打磨。

<p>
  <a href="sponsor-alipay.jpg"><img src="sponsor-alipay.jpg" alt="支付寶收款碼" width="180" /></a>
  <a href="sponsor-wechat-pay.jpg"><img src="sponsor-wechat-pay.jpg" alt="微信支付收款碼" width="180" /></a>
  <a href="sponsor-usdt-polygon.jpg"><img src="sponsor-usdt-polygon.jpg" alt="USDT Polygon 收款碼" width="180" /></a>
</p>

## 功能

- 多檔案上傳：支援 `.csv`、`.xlsx`、`.xls`、文字型 `.pdf`、截圖 `.png/.jpg/.jpeg/.webp`
- 來源識別：微信、支付寶、銀行、U 卡、港卡、多幣種卡、未知來源兜底解析
- AI 優先識別：啟用 AI 後，CSV/XLSX/PDF/截圖會先交給 AI 抽取交易；CSV/XLSX/PDF 失敗時會本機兜底
- 掃描 PDF：文字提取失敗時，可把前 4 頁轉成圖片交給視覺模型識別
- 去重：重複檔案自動跳過，疑似重複交易不計入統計
- 多幣種：HKD、USD、USDT 等按內置參考匯率折算為人民幣進入總覽，同時保留原幣種彙總
- 報告：收入、支出、淨收支、日均支出、分類占比、每日趨勢、TOP 商戶、大額支出、疑似重複扣款
- AI 建議：自動輸出消費習慣、風險提醒、預算建議和下個月規劃
- 匯出：Markdown 和 HTML 報告
- 介面語言：簡體中文、繁體中文、英文、日文

## 快速開始：Docker 本機部署

需要先安裝 Docker Desktop。

```bash
git clone https://github.com/cjk88866/monthly-bill-analyzer.git
cd monthly-bill-analyzer
docker compose up --build
```

打開：

```text
http://127.0.0.1:5173
```

停止服務：

```bash
docker compose down
```

本機帳單和報告會保存在：

```text
data/uploads
data/reports
```

## 接入大模型 API

在 **AI Agent** 面板填寫：

- `Base URL`：例如 `https://api.openai.com/v1`，或其他 OpenAI-compatible 供應商地址
- `分析模型`：用於帳單抽取和規劃建議，例如 `gpt-4o-mini`、`deepseek-chat`
- `截圖模型`：用於截圖帳單和掃描 PDF 圖片頁識別，需要支援視覺輸入
- `API Key`：你的模型服務密鑰

API Key 只在瀏覽器輸入框中使用，不寫入倉庫。

## 開發啟動

後端：

```bash
cd backend
python3 -m venv .venv
.venv/bin/python -m pip install -e '.[dev]'
.venv/bin/uvicorn app.main:app --reload --port 8000
```

前端：

```bash
cd frontend
npm install
npm run dev -- --host 127.0.0.1
```

## 測試

```bash
cd backend
.venv/bin/python -m pytest -q
cd ../frontend
npm run build
cd ..
docker compose config
```

## 隱私與限制

- 程式不連接微信、支付寶或銀行帳號，只分析你上傳的檔案。
- 預設本機解析，不會把帳單傳送到外部服務。
- 啟用 AI 後，相關帳單內容會傳送到你配置的模型服務。
- 匯率是內置參考值，不是即時行情。
- 掃描型 PDF 預設只識別前 4 頁。
- 報告僅供個人記帳參考，不構成投資、稅務或法律建議。

更多說明見 [部署文件](docs/DEPLOYMENT.md) 和 [隱私說明](docs/PRIVACY.md)。

## License

MIT
