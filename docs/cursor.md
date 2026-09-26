# Cursor 自定义 OpenAI Base URL 接入 BuyToken

在 Cursor 里打开 Override OpenAI Base URL，填 `https://api.buytoken.work/v1`，就能用 BuyToken 的 GPT 模型。要在 Cursor 里用 Claude，另装 Claude Code 插件，改 `ANTHROPIC_BASE_URL`。两条路可以同时开。

还没有 Key 的话，到 [buytoken.work](https://buytoken.work) 注册，标准注册送 1 元体验金。

两条路可以同时用。

## 一、Cursor 模型设置里改 Base URL

1. 打开 Cursor Settings（`Cmd/Ctrl + Shift + J`）→ **Models**
2. 找到 **OpenAI API Key**，填你的 `sk-` 密钥（Codex 分组）
3. 打开 **Override OpenAI Base URL**，填 `https://api.buytoken.work/v1`
4. 点 **Verify**。Cursor 会发一次测试请求，通过后才保存
5. 在模型列表里用 **Add model** 加你要用的模型 ID，比如 `gpt-5.6-sol`，然后勾选启用

注意：

- 这一路只支持 OpenAI 协议，填的必须是 **Codex 分组** 的 Key
- 打开自定义 Base URL 后，Cursor 的 Tab 补全、部分内置模型等依赖官方后端的功能会不可用，这是 Cursor 自身的限制
- Verify 失败先看 [常见报错排查](troubleshooting.md)：常见原因是 Key 分组不对、地址漏了 `/v1`、模型 ID 没加进列表

## 二、在 Cursor 里用 Claude Code 插件

1. 扩展市场搜索 **Claude Code for VSCode** 安装
2. 按 [claude-code.md](claude-code.md) 配好终端版 Claude Code（CC Switch 或环境变量都行），插件读同一份 `~/.claude` 配置
3. 侧边栏打开 Claude Code 面板即可，**不需要登录**

插件要你登录，或者不读环境变量，就在 Cursor 的 `settings.json` 里写死：

```json
{
  "claudeCode.preferredLocation": "panel",
  "claudeCode.environmentVariables": [
    {"name": "ANTHROPIC_BASE_URL", "value": "https://api.buytoken.work"},
    {"name": "ANTHROPIC_AUTH_TOKEN", "value": "sk-你的Key"}
  ]
}
```

完整样例见 [examples/vscode-settings.json](../examples/vscode-settings.json)。改完卸载重装一次插件通常就好。

## Trae / VSCode

和 Cursor 里的 Claude Code 插件一样操作，同一份配置。
