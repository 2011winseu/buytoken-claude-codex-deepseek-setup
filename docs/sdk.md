# OpenAI / Anthropic API：把 Base URL 换成 BuyToken

用 curl、OpenAI SDK 或 Anthropic SDK 调 BuyToken。把官方 Base URL 换成 `https://api.buytoken.work`，Key 用控制台里的 `sk-`。Claude Code、Codex、Cursor、DeepSeek 客户端走的也是这三条接口。

密钥用 `x-api-key` 或 `Authorization: Bearer` 传都行：

| 路径 | 协议 | 典型客户端 |
|---|---|---|
| `/v1/messages` | Anthropic | Claude Code、Anthropic SDK、Cherry Studio |
| `/v1/responses` | OpenAI Responses | Codex |
| `/v1/chat/completions` | OpenAI Chat | OpenAI SDK、Cursor、Continue、大多数第三方工具 |

Base URL 一律 `https://api.buytoken.work`；OpenAI 系 SDK 要求带 `/v1`。

模型和 Key 分组要匹配：Claude 分组的 Key 调 `claude-*`，Codex 分组的 Key 调 `gpt-*`，其它厂商见 [模型列表](models.md)。

## curl

Anthropic 协议：

```bash
curl -sS https://api.buytoken.work/v1/messages \
  -H "x-api-key: sk-你的Key" \
  -H "anthropic-version: 2023-06-01" \
  -H "content-type: application/json" \
  -d '{"model":"claude-sonnet-5","max_tokens":16,"messages":[{"role":"user","content":"hi"}]}'
```

OpenAI Chat 协议：

```bash
curl -sS https://api.buytoken.work/v1/chat/completions \
  -H "Authorization: Bearer sk-你的Key" \
  -H "content-type: application/json" \
  -d '{"model":"gpt-5.6-sol","messages":[{"role":"user","content":"hi"}],"max_tokens":16}'
```

OpenAI Responses 协议：

```bash
curl -sS https://api.buytoken.work/v1/responses \
  -H "Authorization: Bearer sk-你的Key" \
  -H "content-type: application/json" \
  -d '{"model":"gpt-5.6-sol","input":"hi","max_output_tokens":16}'
```

三段都在 [examples/curl.sh](../examples/curl.sh)。

## Python

Anthropic SDK：

```python
import anthropic

client = anthropic.Anthropic(
    base_url="https://api.buytoken.work",
    api_key="sk-你的Key",
)
msg = client.messages.create(
    model="claude-sonnet-5",
    max_tokens=64,
    messages=[{"role": "user", "content": "hi"}],
)
print(msg.content[0].text)
```

OpenAI SDK：

```python
from openai import OpenAI

client = OpenAI(
    base_url="https://api.buytoken.work/v1",
    api_key="sk-你的Key",
)
resp = client.chat.completions.create(
    model="gpt-5.6-sol",
    messages=[{"role": "user", "content": "hi"}],
)
print(resp.choices[0].message.content)
```

## Node.js

```js
import OpenAI from "openai";

const client = new OpenAI({
  baseURL: "https://api.buytoken.work/v1",
  apiKey: process.env.BUYTOKEN_API_KEY,
});
const resp = await client.chat.completions.create({
  model: "gpt-5.6-sol",
  messages: [{ role: "user", content: "hi" }],
});
console.log(resp.choices[0].message.content);
```

```js
import Anthropic from "@anthropic-ai/sdk";

const client = new Anthropic({
  baseURL: "https://api.buytoken.work",
  apiKey: process.env.BUYTOKEN_API_KEY,
});
const msg = await client.messages.create({
  model: "claude-sonnet-5",
  max_tokens: 64,
  messages: [{ role: "user", content: "hi" }],
});
console.log(msg.content[0].text);
```

## 其它客户端

Cherry Studio、Continue、ChatBox、LobeChat 等，凡是能填「API 地址 + API Key」的，按上表选协议：Anthropic 类型填 `https://api.buytoken.work`，OpenAI 类型填 `https://api.buytoken.work/v1`。

## 请求体注意

- 流式：`"stream": true` 三条接口都支持
- 缓存：Claude 的 prompt caching 按官方字段透传，命中部分按缓存价计费
- 图片模型（`gpt-image-2`、`gemini-*-image`）按张计费，分组独立，详见 [模型列表](models.md)
