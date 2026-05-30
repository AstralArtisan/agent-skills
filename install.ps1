# 把本仓库里的某个 skill 安装到 Claude Code 或 Codex / 跨工具的技能目录。
# 用法: .\install.ps1 <skill-name> [claude|codex]
#   claude        -> ~\.claude\skills\<skill>
#   codex|gemini  -> ~\.agents\skills\<skill>   (跨工具约定目录)
param(
  [Parameter(Mandatory = $true)][string]$Skill,
  [string]$Target = "claude"
)
$ErrorActionPreference = "Stop"

$RepoDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$Src = Join-Path $RepoDir "plugins/$Skill/skills/$Skill"

if (-not (Test-Path (Join-Path $Src "SKILL.md"))) {
  Write-Error "找不到 skill：$Src/SKILL.md"
  exit 1
}

switch ($Target) {
  "claude" { $DestDir = Join-Path $HOME ".claude/skills" }
  { $_ -in @("codex", "agents", "gemini") } { $DestDir = Join-Path $HOME ".agents/skills" }
  default { Write-Error "未知目标 '$Target'（请用 claude 或 codex）"; exit 1 }
}

$Dest = Join-Path $DestDir $Skill
New-Item -ItemType Directory -Force -Path $DestDir | Out-Null
if (Test-Path $Dest) { Remove-Item -Recurse -Force $Dest }
Copy-Item -Recurse $Src $Dest
Write-Host "已安装：$Skill -> $Dest"
Write-Host "提示：Codex 等需重启会话以重新扫描技能；Claude Code 重启或重载即可。"
