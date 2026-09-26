# 模型列表与分组

能调哪些模型取决于你这把 **Key 的分组**，不是账号。一个账号会同时拿到多个分组的 Key，共用同一个额度池。到控制台 [我的 Key](https://buytoken.work/console/keys) 看每把 Key 属于哪个分组。

模型 ID 要**原样填**，带日期后缀的不能省。价格以 [模型定价页](https://buytoken.work/pricing) 为准，本页不列价格。

## Claude 系列

分组 `cc`（Claude Code 分组）及 `cc-福利`。Anthropic 协议，Base URL 不带 `/v1`。

| 模型 ID | 说明 |
|---|---|
| `claude-fable-5-1` | 新一代旗舰，缓存读价更低 |
| `claude-opus-5` | 强推理，复杂任务 |
| `claude-sonnet-5` | 性价比首选，Claude Code 默认推荐 |
| `claude-opus-4-8` / `claude-opus-4-7` / `claude-opus-4-6` | 上一代 Opus |
| `claude-sonnet-4-6` | 日常均衡 |
| `claude-sonnet-4-5-20250929` | 上一代均衡款 |
| `claude-haiku-4-5-20251001` | 最快最便宜；必须带日期后缀 |

## GPT · Codex 系列

分组 `codex`、`codex-福利`、`codex-福利pro`、`codex-稳定`、`codex-高级`。OpenAI 协议，Base URL 带 `/v1`。同一模型在不同分组价格不同，分组之间可用模型也有差别，以定价页为准。

| 模型 ID | 说明 |
|---|---|
| `gpt-6-astra` | 新一代 GPT 旗舰 |
| `gpt-5.6-sol` | 最新旗舰 |
| `gpt-5.6-terra` | 新一代均衡 |
| `gpt-5.6-luna` | 超低价，跑量首选 |
| `gpt-5.5` | 上一代旗舰 |
| `gpt-5.4` / `gpt-5.4-mini` | 主力对话 / 轻量高性价比 |
| `codex-auto-review` | 代码评审专用 |

## 其它厂商

| 分组 | 模型 ID | 说明 |
|---|---|---|
| `kimi-core` | `kimi-k3` | 月之暗面旗舰 |
| `deepseek-promotion` | `deepseek-v4-pro`、`deepseek-v4-flash`、`deepseek-flash` | `deepseek-flash` 即 DeepSeek v4.1 Flash |
| `glm` | `glm-5.3`、`glm-5.3-flash`、`glm-5.2` | 智谱 |
| `grok-sale` | `grok-4.6`、`grok-4.5` | xAI |

这些分组走 OpenAI 协议（`/v1/chat/completions`）。

## 绘图模型（按张计费）

| 分组 | 模型 ID |
|---|---|
| `gpt-image` | `gpt-image-2` |
| `gemini-image` | `gemini-3-pro-image`、`gemini-3.1-flash-image`、`gemini-2.5-flash-image` 及对应 `-preview` |

## 常见错误

- 拿 Claude 分组的 Key 调 `gpt-*`，或反过来：返回分组不支持该模型。换对应分组的 Key。
- `claude-haiku-4-5`：缺日期后缀，写 `claude-haiku-4-5-20251001`。
- 定价页有、你的 Key 调不了：这把 Key 的分组没开这个模型。看定价页里该分组的模型列表。
