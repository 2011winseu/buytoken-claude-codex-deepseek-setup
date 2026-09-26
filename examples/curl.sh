#!/usr/bin/env bash
# 三条接口各发一次最小请求。用法：
#   BUYTOKEN_API_KEY=sk-你的Key ./curl.sh
set -euo pipefail

: "${BUYTOKEN_API_KEY:?先设置 BUYTOKEN_API_KEY}"
BASE=https://api.buytoken.work

echo "== /v1/messages (Anthropic, 需要 Claude 分组的 Key) =="
curl -sS "$BASE/v1/messages" \
  -H "x-api-key: $BUYTOKEN_API_KEY" \
  -H "anthropic-version: 2023-06-01" \
  -H "content-type: application/json" \
  -d '{"model":"claude-sonnet-5","max_tokens":16,"messages":[{"role":"user","content":"hi"}]}'
echo; echo

echo "== /v1/chat/completions (OpenAI Chat, 需要 Codex 分组的 Key) =="
curl -sS "$BASE/v1/chat/completions" \
  -H "Authorization: Bearer $BUYTOKEN_API_KEY" \
  -H "content-type: application/json" \
  -d '{"model":"gpt-5.6-sol","messages":[{"role":"user","content":"hi"}],"max_tokens":16}'
echo; echo

echo "== /v1/responses (OpenAI Responses, 需要 Codex 分组的 Key) =="
curl -sS "$BASE/v1/responses" \
  -H "Authorization: Bearer $BUYTOKEN_API_KEY" \
  -H "content-type: application/json" \
  -d '{"model":"gpt-5.6-sol","input":"hi","max_output_tokens":16}'
echo
