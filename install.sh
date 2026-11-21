#!/usr/bin/env bash
set -e

# ==============================================================================
# ELEGANS: 6-AGENT MASTER FRONTEND SWARM INSTALLER (MACOS / LINUX)
# 100% Rust Engine · Zero Python · Universal Agent Harness Compatibility
# ==============================================================================

TARGET_DIR="${1:-.}"
TARGET_DIR="$(cd "$TARGET_DIR" 2>/dev/null && pwd || echo "$TARGET_DIR")"
REPO_RAW="https://raw.githubusercontent.com/vmaxmartis09/elegans/main"

echo "✨ Đang cài đặt Elegans vào: $TARGET_DIR"

# 1. Tạo cây thư mục chuẩn
mkdir -p "$TARGET_DIR/ai/bin" \
         "$TARGET_DIR/ai/skills" \
         "$TARGET_DIR/.claude/agents" \
         "$TARGET_DIR/.claude/skills" \
         "$TARGET_DIR/.agents/plugins/fe-master-team/agents" \
         "$TARGET_DIR/.opencode"

# 2. Cài đặt binary Rust fe-core
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd || echo "")"
if [ -f "$SCRIPT_DIR/ai/bin/fe-core" ] && [ "$SCRIPT_DIR/ai/bin/fe-core" != "$TARGET_DIR/ai/bin/fe-core" ]; then
    cp "$SCRIPT_DIR/ai/bin/fe-core" "$TARGET_DIR/ai/bin/fe-core"
elif [ -f "/Volumes/Data/vicieo/ai/bin/fe-core" ] && [ "/Volumes/Data/vicieo/ai/bin/fe-core" != "$TARGET_DIR/ai/bin/fe-core" ]; then
    cp "/Volumes/Data/vicieo/ai/bin/fe-core" "$TARGET_DIR/ai/bin/fe-core"
elif command -v cargo >/dev/null 2>&1 && [ -f "$SCRIPT_DIR/Cargo.toml" ]; then
    echo "🦀 Đang biên dịch fe-core bằng Cargo..."
    (cd "$SCRIPT_DIR" && cargo build --release && cp target/release/fe-core "$TARGET_DIR/ai/bin/fe-core")
fi

chmod +x "$TARGET_DIR/ai/bin/fe-core" 2>/dev/null || true

# 3. Sao chép Agents & Skills
if [ -d "$SCRIPT_DIR/agents" ]; then
    cp -r "$SCRIPT_DIR/agents/"*.md "$TARGET_DIR/.claude/agents/"
    cp -r "$SCRIPT_DIR/agents/"*.md "$TARGET_DIR/.agents/plugins/fe-master-team/agents/"
fi

if [ -d "$SCRIPT_DIR/skills" ]; then
    cp -r "$SCRIPT_DIR/skills/"* "$TARGET_DIR/ai/skills/"
    cp -r "$SCRIPT_DIR/skills/"* "$TARGET_DIR/.claude/skills/"
fi

# 4. Sao chép Templates & Hooks
if [ -d "$SCRIPT_DIR/templates" ]; then
    cp "$SCRIPT_DIR/templates/.claude/settings.json" "$TARGET_DIR/.claude/settings.json" 2>/dev/null || true
    cp "$SCRIPT_DIR/templates/.agents/hooks.json" "$TARGET_DIR/.agents/hooks.json" 2>/dev/null || true
    cp "$SCRIPT_DIR/templates/.opencode/opencode.json" "$TARGET_DIR/opencode.json" 2>/dev/null || true
    cp "$SCRIPT_DIR/templates/.cursorrules" "$TARGET_DIR/.cursorrules" 2>/dev/null || true
    cp "$SCRIPT_DIR/templates/AGENTS.md" "$TARGET_DIR/AGENTS.md" 2>/dev/null || true
fi

# 5. Kiểm tra đồng bộ
if [ -x "$TARGET_DIR/ai/bin/fe-core" ]; then
    (cd "$TARGET_DIR" && ./ai/bin/fe-core sync >/dev/null 2>&1 || true)
fi

echo ""
echo "=========================================================================="
echo "🎉 CHÚC MỪNG NGÀI VMAX! HỆ THỐNG ELEGANS ĐÃ ĐƯỢC CÀI ĐẶT THÀNH CÔNG!"
echo "=========================================================================="
echo "🏷️  6 Subagents sẵn sàng: fe_design_scout, fe_ui_ux_critic, fe_senior_dev,"
echo "                         fe_code_auditor, fe_qa_tester, fe_devops_deployer"
echo "🌐 Trình duyệt Ego Lite: Tự động phát hiện & bảo vệ không gian 'Dad'"
echo "🤖 Tương thích 100%: Claude Code · Antigravity · OpenCode · Codex · Cursor"
echo "⚡ Lõi Rust fe-core: Sẵn sàng tại ./ai/bin/fe-core (< 3ms, 0-token LLM)"
echo "=========================================================================="
