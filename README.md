# 月账单分析 Agent

[简体中文](README.md) | [繁體中文](README.zh-TW.md) | [English](README.en.md) | [日本語](README.ja.md)

一个可本地部署的个人月账单分析 Agent。把微信、支付宝、银行、U 卡、港卡、PDF 或截图账单拖进网页，它会解析交易、去重、按人民币汇总多币种流水，并生成消费报告和下个月规划建议。

默认完全本地运行；只有你在网页里主动启用大模型智能分析时，程序才会把账单文本、表格分片、截图内容和汇总结果发送到你配置的 OpenAI-compatible API。

## 赞助支持

如果这个本地账单 Agent 对你有帮助，可以扫码打赏支持。谢谢支持，项目会继续打磨。

<p>
  <a href="frontend/public/sponsor/alipay.jpg"><img src="frontend/public/sponsor/alipay.jpg" alt="支付宝收款码" width="180" /></a>
  <a href="frontend/public/sponsor/wechat-pay.jpg"><img src="frontend/public/sponsor/wechat-pay.jpg" alt="微信支付收款码" width="180" /></a>
  <a href="frontend/public/sponsor/usdt-polygon.jpg"><img src="frontend/public/sponsor/usdt-polygon.jpg" alt="USDT Polygon 收款码" width="180" /></a>
</p>

## 功能

- 多文件上传：支持 `.csv`、`.xlsx`、`.xls`、文字型 `.pdf`、截图 `.png/.jpg/.jpeg/.webp`
- 来源识别：微信、支付宝、银行、U 卡、港卡、多币种卡、未知来源兜底解析
- AI 优先识别：启用大模型后，CSV/XLSX/PDF/截图会先交给 AI 抽取交易；失败时 CSV/XLSX/PDF 会本地兜底
- 扫描 PDF：文字提取失败时，可把前 4 页转为图片交给视觉模型识别
- 去重：重复文件自动跳过，重复交易不计入统计
- 多币种：HKD、USD、USDT 等按内置参考汇率折算为人民币进入总览，同时保留原币种汇总
- 报告：收入、支出、净收支、日均支出、分类占比、每日趋势、TOP 商户、大额支出、疑似重复扣款
- AI 建议：自动输出消费习惯、风险提醒、预算建议和下个月规划
- 导出：Markdown 和 HTML 报告

## 快速开始：Docker 本地部署

需要先安装 Docker Desktop。

```bash
git clone https://github.com/cjk88866/monthly-bill-analyzer.git
cd monthly-bill-analyzer
docker compose up --build
```

打开：

```text
http://127.0.0.1:5173
```

停止服务：

```bash
docker compose down
```

本地账单和报告会保存在：

```text
data/uploads
data/reports
```

## 手动开发启动

后端：

```bash
cd backend
python3 -m venv .venv
.venv/bin/python -m pip install -e '.[dev]'
.venv/bin/uvicorn app.main:app --reload --port 8000
```

如果 macOS/Python 证书导致 `pip` 安装失败，可以临时改用：

```bash
.venv/bin/python -m pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org -e '.[dev]'
```

前端：

```bash
cd frontend
npm install
npm run dev -- --host 127.0.0.1
```

浏览器打开 Vite 输出的地址，通常是：

```text
http://127.0.0.1:5173
```

## 接入大模型 API

网页左侧的 **AI Agent** 面板里填写：

- `Base URL`：例如 `https://api.openai.com/v1`，或 DeepSeek、通义、Kimi、硅基流动等 OpenAI-compatible 地址
- `分析模型`：用于账单抽取和消费建议，例如 `gpt-4o-mini`、`deepseek-chat`
- `截图模型`：用于截图账单和扫描 PDF 图片页识别，需要支持视觉输入，例如 `gpt-4o` 或供应商的 VL 模型
- `API Key`：你的模型服务密钥

勾选 **启用大模型智能分析** 后点击开始分析。API Key 当前只在浏览器输入框中使用，不写入仓库。

## 样例文件

`samples/` 里有可直接上传的测试账单：

- `wechat-sample.csv`
- `alipay-sample.csv`
- `bank-sample.xlsx`
- `pdf-sample.pdf`
- `hk-card-sample.csv`
- `ucard-sample.csv`

## 测试

后端测试：

```bash
cd backend
.venv/bin/python -m pytest -q
```

前端构建：

```bash
cd frontend
npm run build
```

Docker 配置检查：

```bash
docker compose config
```

## 项目结构

```text
backend/      FastAPI 后端、解析器、分析服务、报告生成
frontend/     React/Vite 前端，Docker 生产环境由 Nginx 托管
samples/      示例账单
data/         本地上传文件和生成报告，默认不提交真实数据
docs/         部署、隐私和发布文档
```

## 发布到 GitHub

如果你已经在 GitHub 创建了空仓库：

```bash
git remote add origin https://github.com/cjk88866/monthly-bill-analyzer.git
git branch -M main
git push -u origin main
```

发布前建议看 [GitHub 发布清单](docs/GITHUB_PUBLISHING.md)。

## 隐私与限制

- 程序不连接微信、支付宝或银行账号，只分析你上传的文件
- 默认本地解析，不会把账单发送到外部服务
- 启用 AI 后，相关账单内容会发送到你配置的模型服务
- 汇率是内置参考值，不是实时行情；重要账单请按实际结算汇率复核
- 扫描型 PDF 默认只识别前 4 页，长账单建议拆分后上传
- 分类和 OCR/视觉识别结果可能有误，报告用于个人记账参考，不构成投资、税务或法律建议

更多说明见 [隐私说明](docs/PRIVACY.md) 和 [部署文档](docs/DEPLOYMENT.md)。

## License

MIT
