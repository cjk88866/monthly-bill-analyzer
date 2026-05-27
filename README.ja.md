# 月次明細分析 Agent

[简体中文](README.md) | [繁體中文](README.zh-TW.md) | [English](README.en.md) | [日本語](README.ja.md)

ローカルで動かせる個人向け月次明細分析 Agent です。WeChat、Alipay、銀行、U カード、香港カード、PDF、スクリーンショットの明細を Web 画面にドロップすると、取引を解析し、重複を除外し、複数通貨を人民元ベースで集計し、月次レポートと翌月の計画提案を生成します。

デフォルトではローカルで動作します。AI 分析を明示的に有効化し、OpenAI-compatible API を設定した場合のみ、明細テキスト、表データ、画像、集計結果が外部 API に送信されます。

## サポート

このローカル明細 Agent が役に立ったら、QR コードから支援できます。継続的な改善へのご支援ありがとうございます。

<p>
  <a href="frontend/public/sponsor/alipay.jpg"><img src="frontend/public/sponsor/alipay.jpg" alt="Alipay 支払い QR コード" width="180" /></a>
  <a href="frontend/public/sponsor/wechat-pay.jpg"><img src="frontend/public/sponsor/wechat-pay.jpg" alt="WeChat Pay 支払い QR コード" width="180" /></a>
  <a href="frontend/public/sponsor/usdt-polygon.jpg"><img src="frontend/public/sponsor/usdt-polygon.jpg" alt="USDT Polygon 支払い QR コード" width="180" /></a>
</p>

## 機能

- 複数ファイルのアップロード：`.csv`、`.xlsx`、`.xls`、テキスト PDF、`.png/.jpg/.jpeg/.webp`
- 明細ソース識別：WeChat、Alipay、銀行、U カード、香港カード、複数通貨カード、フォールバック解析
- AI 優先抽出：有効化すると CSV/XLSX/PDF/画像を先に AI で抽出し、CSV/XLSX/PDF は失敗時にローカル解析へフォールバック
- スキャン PDF：テキスト抽出に失敗した場合、先頭 4 ページを画像化して視覚モデルで認識
- 重複除外：重複ファイルと疑わしい重複取引をスキップ
- 複数通貨：HKD、USD、USDT などを内蔵参考レートで人民元に換算し、元通貨の集計も保持
- レポート：収入、支出、純収支、日別推移、カテゴリ、上位加盟店、高額支出、疑わしい重複請求
- AI 提案：消費傾向、リスク、予算、翌月計画
- エクスポート：Markdown と HTML
- UI 言語：簡体字中国語、繁体字中国語、英語、日本語

## Docker でクイックスタート

先に Docker Desktop をインストールしてください。

```bash
git clone https://github.com/cjk88866/monthly-bill-analyzer.git
cd monthly-bill-analyzer
docker compose up --build
```

開く：

```text
http://127.0.0.1:5173
```

停止：

```bash
docker compose down
```

ローカルのアップロードとレポート保存先：

```text
data/uploads
data/reports
```

## AI API 設定

**AI Agent** パネルで入力します：

- `Base URL`：例 `https://api.openai.com/v1`、または OpenAI-compatible なプロバイダー URL
- `分析モデル`：明細抽出と提案生成に使用。例 `gpt-4o-mini`、`deepseek-chat`
- `画像モデル`：スクリーンショットやスキャン PDF の画像ページ認識に使用。視覚入力対応が必要
- `API Key`：利用するモデルサービスのキー

API Key はブラウザー入力欄で使用され、リポジトリには保存されません。

## 開発起動

バックエンド：

```bash
cd backend
python3 -m venv .venv
.venv/bin/python -m pip install -e '.[dev]'
.venv/bin/uvicorn app.main:app --reload --port 8000
```

フロントエンド：

```bash
cd frontend
npm install
npm run dev -- --host 127.0.0.1
```

## テスト

```bash
cd backend
.venv/bin/python -m pytest -q
cd ../frontend
npm run build
cd ..
docker compose config
```

## プライバシーと制限

- WeChat、Alipay、銀行口座へ直接接続しません。
- ローカルモードでは明細内容を外部サービスへ送信しません。
- AI モードでは設定したモデルプロバイダーへ関連データを送信します。
- 為替レートは内蔵参考値で、リアルタイムの決済レートではありません。
- スキャン PDF はデフォルトで先頭 4 ページのみ認識します。
- レポートは個人の家計管理参考用であり、投資・税務・法律上の助言ではありません。

詳細は [Deployment](docs/DEPLOYMENT.md) と [Privacy](docs/PRIVACY.md) を参照してください。

## License

MIT
