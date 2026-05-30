# Install a skill from this repo into Claude Code or Codex / cross-tool skill dir.
# Usage: .\install.ps1 <skill-name> [claude|codex]
#   claude        -> ~\.claude\skills\<skill>
#   codex|gemini  -> ~\.agents\skills\<skill>   (cross-tool convention dir)
#
# Note: kept ASCII-only on purpose. Windows PowerShell 5.1 reads a BOM-less
# UTF-8 .ps1 as the system ANSI code page (e.g. GBK on Chinese Windows), which
# corrupts non-ASCII characters and breaks parsing. ASCII avoids that entirely.
param(
  [Parameter(Mandatory = $true)][string]$Skill,
  [string]$Target = "claude"
)
$ErrorActionPreference = "Stop"

$RepoDir = $PSScriptRoot
$Src = Join-Path $RepoDir "plugins/$Skill/skills/$Skill"

if (-not (Test-Path (Join-Path $Src "SKILL.md"))) {
  Write-Error "Skill not found: $Src/SKILL.md"
  exit 1
}

if ($Target -eq "claude") {
  $DestDir = Join-Path $HOME ".claude/skills"
}
elseif ($Target -in @("codex", "agents", "gemini")) {
  $DestDir = Join-Path $HOME ".agents/skills"
}
else {
  Write-Error "Unknown target '$Target' (use 'claude' or 'codex')"
  exit 1
}

$Dest = Join-Path $DestDir $Skill
New-Item -ItemType Directory -Force -Path $DestDir | Out-Null
if (Test-Path $Dest) { Remove-Item -Recurse -Force $Dest }
Copy-Item -Recurse $Src $Dest
Write-Host "Installed: $Skill -> $Dest"
Write-Host "Note: restart your Codex/agent session to rescan skills; for Claude Code, restart or reload."
