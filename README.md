# agent-skills

> AstralArtisan 的个人 **Agent Skills** 合集与市场。一份 `SKILL.md`，Claude Code / Codex / 跨工具通用。

这是一个自带 **Claude Code 插件市场**（marketplace）的仓库：每个 skill 是一个独立插件，可单独安装；同一份技能文件夹也能直接放进 Codex / 其它读 `~/.agents/skills/` 的工具。仓库会随我后续做更多 skill 持续增长。

## 可用 skills

| Skill | 说明 | 文档 |
| --- | --- | --- |
| `agent-orchestration` | 让主 agent 像项目 leader 一样**编排子代理**：开工前对齐范围与验收口径，之后自主派发隔离子代理、用文档交接、独立验收门把关、节奏化提交，直到可交付，中途不打断用户。领域无关。 | [SKILL.md](plugins/agent-orchestration/skills/agent-orchestration/SKILL.md) |

## 安装

### ① Claude Code（插件市场，推荐，一行装）

```text
/plugin marketplace add AstralArtisan/agent-skills
/plugin install agent-orchestration@agent-skills
```

之后我 push 更新，你用 `/plugin marketplace update agent-skills` 即可拿到。

也可手动安装（不走市场）：把技能文件夹复制到 `~/.claude/skills/`——

```bash
git clone https://github.com/AstralArtisan/agent-skills
cd agent-skills
./install.sh agent-orchestration claude      # Windows: .\install.ps1 agent-orchestration claude
```

### ② Codex / 跨工具（Gemini CLI 等）

Codex 原生 Agent Skills 与 Claude Code **同构**（同样 `SKILL.md` + `references/` + `assets/`），所以同一文件夹直接可用，只是放在跨工具约定目录 `~/.agents/skills/`：

```bash
git clone https://github.com/AstralArtisan/agent-skills
cd agent-skills
./install.sh agent-orchestration codex       # 复制到 ~/.agents/skills/agent-orchestration
#   Windows: .\install.ps1 agent-orchestration codex
```

然后**重启 Codex 会话**以重新扫描技能。用 `/agent-orchestration` 显式调用，或让它按描述隐式触发。

> 说明：`~/.agents/skills/` 是跨工具约定目录（Codex / Gemini CLI / Kiro 等都读）；部分 Codex 版本也读 `~/.codex/skills/`。以官方文档为准：<https://developers.openai.com/codex/skills>。Codex 旧的 `~/.codex/prompts/` 自定义 prompt 已弃用，改用 skills。

### ③ Claude.ai / 便携（下载 .skill）

从 [Releases](https://github.com/AstralArtisan/agent-skills/releases) 下载对应 `*.skill`（即技能文件夹的 zip 包）。在 Claude.ai 的技能设置里上传，或解压到上面任一技能目录。

## agent-orchestration 用什么场合触发

**会触发**（多阶段、需独立验收、单上下文扛不住，且你想只在开工前把关）：

- “你当 leader，开工前跟我对一遍范围和验收口径，之后用子代理分阶段做完、自己验收迭代到可交付，别中途反复打断我。”
- “把这个 CLI 从 argparse 重构到 click，测试全过、补齐缺测、更新 README。先确认方案，然后你自主拆解派发、审核迭代，完成再汇报。”

**不该触发**（单步小任务，直接做）：

- “帮我修一下这个函数里的空指针 bug。”
- “解释一下 LR(0) 分析是怎么回事。”

更多方法论见 [SKILL.md](plugins/agent-orchestration/skills/agent-orchestration/SKILL.md) 与其 `references/`。

## 仓库结构

```text
agent-skills/
├── .claude-plugin/
│   └── marketplace.json                 # 市场清单（列出每个插件）
├── plugins/
│   └── agent-orchestration/             # 一个插件 = 一个 skill
│       ├── .claude-plugin/plugin.json
│       └── skills/agent-orchestration/  # 规范技能文件夹（Claude Code & Codex 通用）
│           ├── SKILL.md
│           ├── references/
│           └── assets/
├── install.sh / install.ps1             # 复制技能到 ~/.claude/skills 或 ~/.agents/skills
├── CHANGELOG.md
└── LICENSE
```

## 新增一个 skill（给我自己留的）

1. 新建 `plugins/<新名>/skills/<新名>/SKILL.md`（+ 可选 `references/`、`assets/`）。
2. 新建 `plugins/<新名>/.claude-plugin/plugin.json`（`skills: ["./skills/<新名>"]`，版本从 `0.1.0` 起）。
3. 在 `.claude-plugin/marketplace.json` 的 `plugins` 加一条（`source: "./plugins/<新名>"`）。
4. 记 `CHANGELOG.md`，提交并推送。
5. 打包发布：`<skill>.skill` 挂到 `gh release create <新名>-v0.1.0`。

## 更新与版本

改技能内容 → bump 对应 `plugin.json`（与 marketplace 条目）的 `version` → 记 `CHANGELOG.md` → 提交推送 → `gh release create <skill>-vX.Y.Z dist/<skill>.skill`。

- Claude Code 插件用户：`/plugin marketplace update agent-skills`。
- Codex / 手动用户：重跑 `./install.sh <skill> <claude|codex>` 覆盖即可。

## 参考

- Codex Agent Skills：<https://developers.openai.com/codex/skills>
- Codex AGENTS.md：<https://developers.openai.com/codex/guides/agents-md>
- 技能安装目录与加载顺序：<https://openclaw-skills.org/blog/skills-installation-and-loading-order>

## 鸣谢

`agent-orchestration` 的方法论提炼自 [@Hspikes](https://github.com/Hspikes) 的一份原始中枢调度 prompt（编译器实验的子代理编排），特此致谢。

## License

[MIT](LICENSE) © 2026 AstralArtisan
