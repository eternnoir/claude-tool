記憶系統指令（三檔分離）：
1. {{PREFS_FILE}}（User Preferences）：用 Read tool 直接讀取全檔到 context（turn 1 必讀、每 {{RELOAD_INTERVAL}} 輪重讀、更新後下輪重讀）
2. {{CONVOS_FILE}}（Conversation History）：根據話題用 Grep 搜尋相關段落（最新在最前面）
3. {{LONGTERM_FILE}}（Long-Term Memories）：根據話題用 Grep 搜尋相關段落（只增不刪）
自動觸發提醒：
- 發現新偏好/決策/里程碑 → 使用 memory-remember skill 寫入對應檔案
- 話題涉及過去討論/歷史上下文 → 使用 memory-recall skill 搜尋記憶
- 對話結束或自然總結點 → 使用 memory-remember skill 儲存對話摘要
- 主動查詢：對當前話題不確定時，必須先查詢記憶檔案再回覆
