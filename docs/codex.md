# Codex CLI / Codex Desktop 接入 BuyToken

要调 `gpt-5.6-sol`、`gpt-6-astra` 这类 GPT 模型看这里。Codex 走 OpenAI 协议，**地址必须带 `/v1`**。

## 开始之前

- API 地址：`https://api.buytoken.work/v1`
- API Key：控制台 [我的 Key](https://buytoken.work/console/keys) 里 **Codex 分组**（`codex` 及其福利 / 稳定 / 高级分组）的 `sk-` 密钥
- Claude 分组的 Key 调不了 `gpt-*`，反过来也一样

## 1. 装 Codex CLI 或 Codex Desktop

两个客户端共用一份配置 `~/.codex/config.toml`，装哪个都行。CLI 需要 Node.js 18+：

```bash
npm install -g @openai/codex
```

图形界面到 [openai.com/codex](https://openai.com/codex) 下载官方桌面端。

## 2. 方式一：CC Switch

CC Switch 装法见 [claude-code.md](claude-code.md#2-装-cc-switch)。打开 CC Switch，切到 **Codex** 选项卡 → 添加供应商 → 「自定义配置」：

| 字段 | 填什么 |
|---|---|
| 名称 | 随便，比如 `buytoken-codex` |
| 请求地址 | `https://api.buytoken.work/v1`（必须带 `/v1`） |
| API Key | 你的 `sk-` 密钥 |
| API 格式 | OpenAI |

保存并启用后，CC Switch 会把地址和密钥写进 `~/.codex/config.toml`，CLI 和桌面端都直接读这份配置。

## 2. 方式二：手写 config.toml（不装 CC Switch）

`~/.codex/config.toml`（Windows 在 `%USERPROFILE%\.codex\config.toml`）：

```toml
model = "gpt-5.6-sol"
model_provider = "buytoken"

[model_providers.buytoken]
name = "BuyToken"
base_url = "https://api.buytoken.work/v1"
env_key = "BUYTOKEN_API_KEY"
wire_api = "responses"
```

然后把密钥放进环境变量：

```bash
# Mac / Linux，写进 ~/.zshrc 或 ~/.bashrc
export BUYTOKEN_API_KEY=sk-你的Key
```

```powershell
# Windows PowerShell，设完重开终端
[System.Environment]::SetEnvironmentVariable("BUYTOKEN_API_KEY", "sk-你的Key", "User")
```

完整样例见 [examples/codex-config.toml](../examples/codex-config.toml)。

## 2. 方式三：只配环境变量（临时试用）

```bash
export OPENAI_BASE_URL=https://api.buytoken.work/v1
export OPENAI_API_KEY=sk-你的Key
```

适合临时试一下；长期用建议写 `config.toml`。

## 3. 开始用

CLI 执行 `codex` 进入交互界面，用 `/model gpt-5.6-sol` 切换模型。桌面端新建会话时在模型选择里填模型 ID。

改完 CC Switch 或 `config.toml` 但客户端还走旧配置，重启一次客户端。

## 验证

```bash
curl -sS https://api.buytoken.work/v1/responses \
  -H "Authorization: Bearer sk-你的Key" \
  -H "content-type: application/json" \
  -d '{"model":"gpt-5.6-sol","input":"hi","max_output_tokens":16}'
```

返回 JSON 且没有 `error` 字段即成功。

## 常见问题

- 连不上或 404：地址漏了 `/v1`。
- `model_not_found` / 分组不支持该模型：这把 Key 不在 Codex 分组，或者模型 ID 拼错。到 [模型列表](models.md) 对照。
- 桌面端提示登录：用自定义供应商不需要 ChatGPT 账号登录，确认 `config.toml` 已被读取（重启桌面端）。

更多见 [常见报错排查](troubleshooting.md)。
