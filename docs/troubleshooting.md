# 常见报错排查

按报错原文找到对应小节。每节都是：现象 → 原因 → 改哪里。

大部分问题最后都归到一句：**别处还留着旧配置**。删掉 `~/.claude`（Claude Code）或检查 `~/.codex/config.toml`（Codex），重开终端，按文档重配一遍。

## 401 Unauthorized

Key 没生效，通常是别处还留着旧配置。依次检查：

1. 在 `claude` 里输 `/status`，看 Base URL 是不是 `https://api.buytoken.work`
2. CC Switch 里是否还启用着别的供应商
3. `~/.claude/settings.json`（Windows：`%USERPROFILE%\.claude\settings.json`）里有没有旧地址或旧密钥
4. Key 是否在控制台被停用，或者复制时少了字符

## 403 Your client is not authorized

在 `claude` 里输 `/logout` 退出登录，然后重新进入。

## 提示余额不足，但控制台里额度还有

装过别的服务留下的残留配置，客户端实际打到了别处。删掉整个配置目录后重新配：

```bash
# Mac / Linux
rm -rf ~/.claude

# Windows PowerShell
Remove-Item "$env:USERPROFILE\.claude" -Recurse -Force
```

## 模型名没写错，请求却失败 / 分组不支持模型

多半是分组不对：Claude 分组的 Key 调不了 `gpt-*`，Codex 分组的 Key 调不了 `claude-*`。到控制台「我的 Key」看这把 Key 的分组，或到 [模型列表](models.md) 对照。

模型 ID 要原样填，带日期后缀的不能省：`claude-haiku-4-5` 会失败，必须写 `claude-haiku-4-5-20251001`。

## 模型服务暂时不可用 / model_service_unavailable

上游供货渠道临时故障，不是你的配置问题。等几分钟重试；持续超过半小时联系客服，附上模型名和分组。

## Unable to connect 或提示国家限制

是配置没生效，不是网络问题。本服务不需要代理。

- Windows：改完环境变量必须**重开 PowerShell**
- Mac / Linux：确认 `~/.zshrc` 或 `~/.bashrc` 已经 `source` 过，或者直接重开终端

## Codex 连不上 / 404

地址漏了 `/v1`。Codex 和所有 OpenAI 协议客户端必须写 `https://api.buytoken.work/v1`。

## 改了配置，客户端还走旧的

重启一次客户端。CC Switch 改完 Codex 配置后，Codex CLI 和桌面端都要重开。

## Windows：提示禁止运行脚本 / claude.ps1 无法加载

PowerShell 的执行策略挡住了。跑一次下面的命令，提示确认时输 `Y` 或 `A`：

```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```

## Windows：无法将 claude 识别为命令

npm 的全局安装路径不在 PATH 里。查出路径（通常是 `C:\Users\<用户名>\AppData\Roaming\npm`），加进系统环境变量 PATH，然后重开终端：

```powershell
npm config get prefix
```

## Windows：提示需要 git-bash

装 [Git for Windows](https://git-scm.com/downloads/win)，一路默认下一步，装完关闭并重开 PowerShell。

## VSCode / Cursor / Trae 插件要我登录

不需要登录。先试卸载重装插件；还不行就在插件的 `settings.json` 里显式写死地址和密钥：

```json
{
  "claudeCode.preferredLocation": "panel",
  "claudeCode.environmentVariables": [
    {"name": "ANTHROPIC_BASE_URL", "value": "https://api.buytoken.work"},
    {"name": "ANTHROPIC_AUTH_TOKEN", "value": "sk-你的Key"}
  ]
}
```

## 400 context_management: Extra inputs are not permitted

客户端发了上游不认的实验性字段。在 CC Switch 的 env 里加一行，保存后重开终端：

```json
"CLAUDE_CODE_DISABLE_EXPERIMENTAL_BETAS": "1"
```

环境变量方式的话：`export CLAUDE_CODE_DISABLE_EXPERIMENTAL_BETAS=1`。

## Cursor Verify 失败

按顺序排：

1. Base URL 是否是 `https://api.buytoken.work/v1`
2. 填的是不是 **Codex 分组** 的 Key（Cursor 这一路只走 OpenAI 协议）
3. 模型列表里有没有加上你要用的模型 ID，比如 `gpt-5.6-sol`

## Claude Code 越用越卡

同一个会话开久了上下文越堆越大。做完一个任务输 `/clear` 清一下。

## 还是不行

联系客服 QQ `3963059079`，或加交流群 `1109940344`。附上：在用的客户端、模型名、报错截图、`/status` 的输出。也可以在本仓库开 Issue。
