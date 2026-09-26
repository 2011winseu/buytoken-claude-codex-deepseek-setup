# Claude Code / Codex / Cursor 接入 BuyToken 配置指南

改一行 Base URL，让你手上的 Claude Code、Codex、Cursor 直接调用 Claude 与 GPT 官方级模型。人民币按 token 用量结算，额度不过期，每一次调用都能在控制台查到。

**标准注册送 1 元体验金。** 到 [buytoken.work](https://buytoken.work) 用邮箱注册，验证后立即到账，不用先充值，全站模型都能拿这 1 元试。登录后在控制台创建 Key，再按下面的步骤填进客户端。

这个仓库只放文档：怎么配、配错了怎么查。

## 你需要的两样东西

| 填进客户端 | 值 |
|---|---|
| API 地址 | `https://api.buytoken.work`（OpenAI 协议的客户端要写 `https://api.buytoken.work/v1`） |
| API Key | 控制台「我的 Key」里 `sk-` 开头的一串 |

登录控制台用的**账号和密码**不要填进客户端；`https://buytoken.work` 是给人看的控制台，也不能当 API 地址填。

## 按客户端选一篇

| 客户端 | 文档 | 协议 | 地址写法 |
|---|---|---|---|
| Claude Code（终端 / VSCode 插件） | [docs/claude-code.md](docs/claude-code.md) | Anthropic | `https://api.buytoken.work` |
| Codex CLI / Codex Desktop | [docs/codex.md](docs/codex.md) | OpenAI | `https://api.buytoken.work/v1` |
| Cursor | [docs/cursor.md](docs/cursor.md) | OpenAI / Anthropic | 见文档 |
| curl、OpenAI SDK、Anthropic SDK | [docs/sdk.md](docs/sdk.md) | 三种都支持 | 见文档 |

配完不通，先看 [常见报错排查](docs/troubleshooting.md)。能调哪些模型、模型 ID 怎么写，见 [模型列表](docs/models.md)。

## 三步接入（Claude Code 为例）

1. 装 Node.js 18+，然后 `npm install -g @anthropic-ai/claude-code`
2. 把两个环境变量指到网关：

   ```bash
   export ANTHROPIC_BASE_URL=https://api.buytoken.work
   export ANTHROPIC_AUTH_TOKEN=sk-你的Key
   ```

3. 终端里执行 `claude`，能对话就通了。

不想碰命令行的话，用 [CC Switch](https://github.com/farion1231/cc-switch) 图形界面加一个供应商即可，步骤在 [docs/claude-code.md](docs/claude-code.md)。

## 关于 BuyToken

- 标准注册送 1 元体验金，邮箱验证后立即到账，可用于全站任意模型
- 一个账号同时拿到 Claude 分组和 Codex 分组的 Key，共用一个额度池
- 网关同时支持 `/v1/messages`、`/v1/responses`、`/v1/chat/completions`
- 缓存命中按各模型自己的比例计价；额度不过期、不清零
- 用量日志能展开每一笔钱是怎么算的
- 支持开发票（个人普票 / 企业普票 / 专票）

价格以 [模型定价页](https://buytoken.work/pricing) 为准，仓库里不放价格表。

## 遇到问题

- 客服 QQ：`3963059079`
- 交流群：`1109940344`
- 也可以在本仓库开 Issue，说明客户端、模型名和报错截图

## 许可

文档内容采用 [MIT License](LICENSE)。
