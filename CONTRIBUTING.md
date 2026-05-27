# Contributing

欢迎提交账单格式适配、解析规则、前端体验、Docker 部署和文档改进。

## 开发环境

后端：

```bash
cd backend
python3 -m venv .venv
.venv/bin/python -m pip install -e '.[dev]'
.venv/bin/python -m pytest -q
```

前端：

```bash
cd frontend
npm install
npm run build
```

Docker：

```bash
docker compose config
docker compose up --build
```

## 提交前检查

- 不提交真实账单、截图、报告或 API Key。
- 新增账单格式时，优先添加匿名样例或单元测试。
- 修改解析逻辑后运行后端测试。
- 修改前端后运行 `npm run build`。
- 涉及 Docker 的改动至少运行 `docker compose config`。

## Pull Request 建议

PR 描述里请写清：

- 改了什么
- 为什么要改
- 如何验证
- 是否影响隐私、外部 API 调用或本地数据保存
