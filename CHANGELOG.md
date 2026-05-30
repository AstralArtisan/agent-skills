# Changelog

本仓库按「每个 skill 独立版本」记录；发布标签格式 `<skill>-vX.Y.Z`。

## agent-orchestration 0.1.0 — 2026-05-30

首发：中枢编排方法论 skill。

- 两段式工作法：开工前唯一与用户交互的立项闸（含成本闸）；开工后全自主执行循环，不中途打断用户。
- 七条不变量（每条解释「为什么」）：中枢只协调 / 上下文外推 / 单一派发者 / 文档驱动交接 / 独立验收门 / 节奏化提交 / 子代理 prompt 五件套。
- 物化「任务专属调度方案」并执行：写进项目级原生记忆文件（Claude Code `CLAUDE.md` / Codex `AGENTS.md`）+ `ORCHESTRATION.md` 台账 + `TASK-SPEC.md` 规格。
- 配套 `references/`（pipeline-design、handoff-protocol、subagent-prompting）与 `assets/`（MEMORY-ANCHOR、ORCHESTRATION、TASK-SPEC 模板 + handoff 编号模板）。
- 领域无关，Claude Code / Codex / 跨工具通用。
