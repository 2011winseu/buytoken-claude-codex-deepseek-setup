# Claude Code 接入 BuyToken

适用于 Claude Code 终端版，以及 VSCode / Cursor / Trae 里的 Claude Code 插件。两条路任选：CC Switch 图形化配置，或者直接配环境变量。

## 开始之前

- API 地址：`https://api.buytoken.work`（不要带 `/v1`；如果客户端不认，再试末尾加 `/v1`）
- API Key：控制台 [我的 Key](https://buytoken.work/console/keys) 里 `sk-` 开头的那串，要用 **Claude 分组**（`cc`）的 Key
- 客户端里不要填登录控制台的账号密码

## 方式一：CC Switch（推荐）

### 1. 装 Node.js 和 Claude Code

先装 Node.js 18 或更高版本（[nodejs.org](https://nodejs.org)），然后打开终端。Windows 用 PowerShell，Mac / Linux 用 Terminal：

```bash
npm install -g @anthropic-ai/claude-code
```

### 2. 装 CC Switch

到 [github.com/farion1231/cc-switch](https://github.com/farion1231/cc-switch/releases) 下载对应系统的安装包，一路下一步。装一次就够，后面配 Codex 也用它。

### 3. 添加供应商

打开 CC Switch → 添加供应商 → 选「自定义配置」，按下表填：

| 字段 | 填什么 |
|---|---|
| 名称 | 随便，比如 `buytoken` |
| 请求地址 | `https://api.buytoken.work` |
| API Key | 你的 `sk-` 密钥 |
| API 格式 | Anthropic |

模型映射：

| 槽位 | 模型 ID |
|---|---|
| Default | `claude-sonnet-5` |
| Opus | `claude-opus-5` |
| Haiku | `claude-haiku-4-5-20251001` |

保存并启用这条供应商。

### 4. 开始用

终端执行 `claude`，进到交互界面就成了。

VSCode、Cursor、Trae 用户装「Claude Code for VSCode」插件即可，不需要登录，也不用额外配置；插件会读同一份 `~/.claude` 配置。

## 方式二：环境变量

### Mac / Linux

编辑 `~/.zshrc`（bash 用户改 `~/.bashrc`），追加两行：

```bash
export ANTHROPIC_BASE_URL=https://api.buytoken.work
export ANTHROPIC_AUTH_TOKEN=sk-你的Key
```

保存后 `source ~/.zshrc`，或者直接重开终端，再运行 `claude`。

### Windows（PowerShell）

下面两行会写进用户环境变量，永久生效：

```powershell
[System.Environment]::SetEnvironmentVariable("ANTHROPIC_BASE_URL", "https://api.buytoken.work", "User")
[System.Environment]::SetEnvironmentVariable("ANTHROPIC_AUTH_TOKEN", "sk-你的Key", "User")
```

**设完必须关掉 PowerShell 重开**，否则不生效。

### 写进 settings.json

不想动环境变量，也可以直接写 `~/.claude/settings.json`（Windows 在 `%USERPROFILE%\.claude\settings.json`），参考 [examples/claude-settings.json](../examples/claude-settings.json)。

## 验证

在 `claude` 里随便打一句有回复就是通了。`/status` 能看到当前 Base URL，确认是 `https://api.buytoken.work`。

也可以用 curl：

```bash
curl -sS https://api.buytoken.work/v1/messages \
  -H "x-api-key: sk-你的Key" \
  -H "anthropic-version: 2023-06-01" \
  -H "content-type: application/json" \
  -d '{"model":"claude-sonnet-5","max_tokens":16,"messages":[{"role":"user","content":"hi"}]}'
```

返回 JSON 即成功。

## 常见问题

- `401 Unauthorized`：别处还留着旧配置。`/status` 看 Base URL；CC Switch 里是否还启用着别的供应商；`~/.claude/settings.json` 里有没有旧地址或旧密钥。
- `403 Your client is not authorized`：在 `claude` 里 `/logout`，再重新进入。
- 提示余额不足但控制台有额度：装过别的服务留下的残留配置。删掉整个 `~/.claude` 目录后重新配。
- 模型名没写错却失败：多半是拿了 Codex 分组的 Key 调 `claude-*`。到「我的 Key」看这把 Key 的分组。模型 ID 要原样写，`claude-haiku-4-5` 会失败，必须 `claude-haiku-4-5-20251001`。

更多见 [常见报错排查](troubleshooting.md)。

## 两个万能办法

大部分疑难杂症能靠「删掉 `~/.claude` 目录 → 重开终端 → 按本文重新配一遍」解决。

同一个会话开久了上下文越堆越大、越来越卡，做完一个任务输 `/clear` 清一下。
