# DeepSeek API 换 Base URL 接入 BuyToken

DeepSeek 官方是 OpenAI 兼容接口。把 Base URL 改成 `https://api.buytoken.work/v1`，API Key 换成 BuyToken 控制台里 **DeepSeek 分组**的 `sk-`，原来的 OpenAI SDK、ChatBox、Cherry Studio、LobeChat 都不用改调用方式。

还没有 Key 的话，到 [buytoken.work](https://buytoken.work) 注册，标准注册送 1 元体验金，验证后立即到账。

## 填这两个字段

| 字段 | 值 |
|---|---|
| Base URL | `https://api.buytoken.work/v1` |
| API Key | DeepSeek 分组的 `sk-`，在 [我的 Key](https://buytoken.work/console/keys) |
| 模型 ID | `deepseek-v4-pro`、`deepseek-v4-flash`、`deepseek-flash` |

`deepseek-flash` 就是 DeepSeek v4.1 Flash。模型 ID 要原样填。Claude 分组和 Codex 分组的 Key 调不了这些模型。

## curl

```bash
curl -sS https://api.buytoken.work/v1/chat/completions \
  -H "Authorization: Bearer sk-你的Key" \
  -H "content-type: application/json" \
  -d '{"model":"deepseek-v4-flash","messages":[{"role":"user","content":"hi"}],"max_tokens":16}'
```

## Python

```python
from openai import OpenAI

client = OpenAI(
    base_url="https://api.buytoken.work/v1",
    api_key="sk-你的Key",
)
resp = client.chat.completions.create(
    model="deepseek-v4-flash",
    messages=[{"role": "user", "content": "hi"}],
)
print(resp.choices[0].message.content)
```

## 环境变量

```bash
export OPENAI_BASE_URL=https://api.buytoken.work/v1
export OPENAI_API_KEY=sk-你的Key
```

更多接口见 [SDK 调用](sdk.md)，模型对照见 [模型列表](models.md)，报错见 [常见报错](troubleshooting.md)。
