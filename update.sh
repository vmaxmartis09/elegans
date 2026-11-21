#!/usr/bin/env bash
# ==============================================================================
# ELEGANS UPDATE SCRIPT (1-LINE UPDATE TO LATEST SWARM VERSION)
# ==============================================================================
TARGET_DIR="${1:-.}"
echo "🔄 Đang cập nhật Elegans tại thư mục: $TARGET_DIR..."
curl -fsSL https://raw.githubusercontent.com/vmaxmartis09/elegans/main/install.sh | bash -s -- "$TARGET_DIR"
