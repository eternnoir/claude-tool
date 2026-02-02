<!-- ENGRAM:START -->
<!-- Engram 記憶系統 v{VERSION} | 預設: {PRESET} | 請勿手動編輯標記之間的內容 — 重新執行 memory-init 即可更新 -->

## Engram 記憶系統

重要：你必須在每次對話中遵循以下記憶指令。這是持久記憶系統。

### 記憶檔案（三檔分離）

| 檔案 | 用途 | 存取策略 |
|------|------|---------|
| `{PREFS_FILE}` | 使用者/專案偏好 | **必須完整讀取**：第 1 輪必讀、每 {RELOAD_INTERVAL} 輪重讀、更新後下輪重讀 |
| `{CONVOS_FILE}` | 對話歷史 | 根據話題關鍵字用 Grep 搜尋相關段落（最新在最前面） |
| `{LONGTERM_FILE}` | 長期記憶 | 根據話題關鍵字用 Grep 搜尋相關段落（只增不刪，絕對不能刪除） |

### 強制行為規則

你必須無例外地遵守以下所有規則：

1. **第 1 輪**：必須使用 Read tool 完整讀取 `{PREFS_FILE}`，在做任何其他事情之前
2. **每 {RELOAD_INTERVAL} 輪**：重新完整讀取 `{PREFS_FILE}`（hook 會顯示 `[ENGRAM RELOAD]` 作為提醒）
3. **更新偏好後**：在下一輪立即重新讀取 `{PREFS_FILE}`
4. **發現新偏好/決策/里程碑**：立即使用 `memory-remember` skill 寫入對應檔案
5. **話題涉及過去討論或歷史上下文**：必須先使用 `memory-recall` skill 搜尋記憶再回覆
6. **對話結束或到達自然總結點**：使用 `memory-remember` skill 儲存對話摘要
7. **對當前話題不確定**：如果對話有可能涉及過去的上下文，必須先使用 `memory-recall` skill 搜尋記憶再回覆

### Hook 信號

需要重讀偏好時，Engram hook 會注入 `[ENGRAM RELOAD]`。當你看到這個信號時，必須完整讀取 `{PREFS_FILE}` 後才能做任何其他事。如果沒有 hook 信號，則根據上述規則依上下文判斷。
<!-- ENGRAM:END -->
