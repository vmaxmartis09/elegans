# ✨ Elegans: 6-Agent Master Frontend Architecture (100% Rust Core)

> **Universal Frontend Multi-Agent Swarm for Claude Code, Antigravity (AGY), OpenCode, Codex, Cursor & Windsurf**  
> *100% Native Rust Engine · Zero Python · Zero Token Bus · Cross-Platform (macOS / Windows / Linux) · Ego Lite Priority*

---

## ⚡ Cài Đặt 1 Dòng Lệnh Duy Nhất (Single-Line Installer)

### Trên macOS / Linux
```bash
curl -fsSL https://raw.githubusercontent.com/vmaxmartis09/elegans/main/install.sh | bash
```

### Trên Windows (PowerShell)
```powershell
irm https://raw.githubusercontent.com/vmaxmartis09/elegans/main/install.ps1 | iex
```

### Hoặc Cài Vào Một Dự Án Cụ Thể
```bash
git clone https://github.com/vmaxmartis09/elegans.git /tmp/elegans && /tmp/elegans/install.sh /duong-dan-toi-project
```

---

## 🔄 Cập Nhật Elegans Lên Bản Mới Nhất (Update / Pull)

Khi ở bất kỳ dự án nào đang dùng Elegans, Ngài có thể cập nhật ngay bằng **1 trong 3 cách sau**:

### Cách 1: Dùng lệnh trực tiếp từ lõi Rust (Nhanh nhất)
```bash
./ai/bin/fe-core update
```

### Cách 2: Chạy 1 dòng lệnh qua cURL (macOS / Linux)
```bash
curl -fsSL https://raw.githubusercontent.com/vmaxmartis09/elegans/main/update.sh | bash
```

### Cách 3: Chạy 1 dòng lệnh qua PowerShell (Windows)
```powershell
irm https://raw.githubusercontent.com/vmaxmartis09/elegans/main/update.ps1 | iex
```

Lệnh update sẽ tự động kéo toàn bộ bản cập nhật mới nhất của:
- Binary Rust `fe-core`
- Toàn bộ 6 Subagents
- Toàn bộ 13 Core Skills (kèm bộ ba kiểm định chuyên sâu từ ECC: WCAG 2.2 AA, Zero-Memory-Leak Performance, OWASP Web Security)
- Bộ quy tắc TypeScript/React Hardening Rules
- Tự động chạy `fe-core sync` để đảm bảo 0-drift!

---

## 🛡️ Tinh Hoa Kiểm Định & Bảo Vệ (Chắt Lọc & Nâng Cấp Từ ECC)

Hệ thống Elegans đã được tích hợp chọn lọc các kỹ thuật bảo vệ hàng đầu từ hệ sinh thái ECC (`affaan-m/ECC`), chuẩn hóa 100% theo triết lý Rust Native & Zero-Bloat của Elegans:
1. **PreToolUse & PostToolUse Guardrails**:
   - Tự động kích hoạt `./ai/bin/fe-core env-guard` trước khi thực thi `run_command` hoặc `write_file` / `edit_file` (chặn rò rỉ secret token, kiểm tra `.env` parity).
   - Tự động kích hoạt `./ai/bin/fe-core check-edit` sau khi sửa file (chặn component > 250 dòng, hook > 150 dòng, vi phạm anti-slop).
2. **Bộ 3 Skills Kiểm Toán Chuyên Sâu**:
   - `fe-accessibility-wcag`: Đo chuẩn WCAG 2.2 AA, bắt buộc `aria-label` cho nút icon (Quy tắc UI số 4), touch target mobile >= 44x44px.
   - `fe-performance-audit`: Diệt sạch Memory Leak (uncleaned ResizeObserver/GSAP ScrollTrigger/pending fetch), diệt lỗi Hydration Mismatch và kiểm soát Core Web Vitals (LCP < 2.5s, CLS = 0.00, INP < 200ms).
   - `web-security-owasp`: Chu vi an toàn OWASP 2025 Client-Side, chống XSS, kiểm soát Iframe Sandboxing & CSP.
3. **Quy Tắc TypeScript & React Hardening (`rules/typescript-hardening.md`)**:
   - Cấm `any` (thay bằng `unknown` + type narrowing/Zod).
   - Cấm dùng `useEffect` cho Derived State.
   - Bắt buộc trả về hàm cleanup cho mọi effect bất đồng bộ và gesture listener (chống dính UI).

---

## 🏷️ Đội Ngũ 6 Subagents Của Elegans

| Agent | Vai Trò | Cấp Độ Ponytail | Nhãn Điều Động |
| :--- | :--- | :--- | :--- |
| **`fe_design_scout`** | Trinh sát Video TikTok/Reels, duyệt web & bóc tách công nghệ (Reverse Engineering) | `ZERO-LOSS-REVERSE` | `🏷️ [Elegans :: fe_design_scout]` |
| **`fe_ui_ux_critic`** | Giám đốc Nghệ thuật, UX Master & Thẩm phán Diệt AI-Slop (`taste-skill` + ViciEO Craft) | `ART-DISCIPLINED` → `ZERO-SLOP-JUDGE` | `🏷️ [Elegans :: fe_ui_ux_critic]` |
| **`fe_senior_dev`** | Kỹ sư Trưởng Code đa Framework, 8 loại hình Web & Co-located Architecture | `SURGICAL-SENIOR` | `🏷️ [Elegans :: fe_senior_dev]` |
| **`fe_code_auditor`** | Đao phủ Kiểm định Chất lượng Code, AST Blast-Radius, Re-render & Security | `ULTRA-RUTHLESS` | `🏷️ [Elegans :: fe_code_auditor]` |
| **`fe_qa_tester`** | Kỹ sư QA Web E2E, Responsive 5 Viewports & 140+ Mobile/Tablet Emu | `FULL-COVERAGE / ZERO-BLOAT` | `🏷️ [Elegans :: fe_qa_tester]` |
| **`fe_devops_deployer`** | Đóng gói Multi-Cloud, Bảo vệ `.env`/Secret & Tự động Deploy (Vercel, Cloudflare) | `ZERO-CONFIG-SAFE` | `🏷️ [Elegans :: fe_devops_deployer]` |

---

## 🌐 Tương Thích Tuyệt Đối Đa Nền Tảng & Đa AI Harness

1. **Đa Hệ Điều Hành (Cross-Platform)**:
   - **macOS**: Hỗ trợ cả Apple Silicon (M1/M2/M3/M4 - ARM64) và Intel x86_64.
   - **Windows**: Hỗ trợ Windows 10/11 x64 với binary native `fe-core.exe`.
   - **Linux**: Hỗ trợ Ubuntu/Debian/Arch x86_64.
2. **Đa AI Agent Harness (Tương Thích Mọi Tool Hiện Nay)**:
   - **Claude Code**: Tự động cấu hình `.claude/agents/` và `.claude/settings.json` Pre/Post-tool hooks.
   - **Antigravity (AGY)**: Tự động cấu hình `.agents/plugins/`, `.agents/hooks.json` và `.agents/skills.json`.
   - **OpenCode**: Tự động tạo `opencode.json` tương thích hook sự kiện.
   - **Codex / OpenAI**: Cấu hình chuẩn `AGENTS.md` Manifesto tối cao.
   - **Cursor & Windsurf**: Tự động tạo `.cursorrules` và `.windsurfrules`.
3. **Cầu Nối Trình Duyệt Ego Lite (Bảo Vệ Không Gian `Dad`)**:
   - Tự động nhận diện Ego Lite (`ego-browser`) trên cả macOS (`/Applications/Ego Lite.app/...`) và Windows (`%LOCALAPPDATA%\ego\...`).
   - Ưu tiên số 1 Ego Lite, bảo vệ tuyệt đối không chạm vào space `Dad` của người dùng. Fallback tự động sang AGY Built-in Browser.

---

## 🏛️ Chuẩn Kiến Trúc Co-located Component (Elegans Architecture)

Chấm dứt hoàn toàn tình trạng viết code bừa bãi, nhồi nhét file 500 dòng không thể bảo trì:

```text
components/<feature-name>/ (hoặc features/<feature-name>/)
├── index.ts                <- Barrel export duy nhất ra ngoài (Clean Boundary)
├── <FeatureName>.tsx       <- Orchestrator Component: <= 200 dòng, CHỈ RENDER JSX & bind hooks
├── components/             <- Sub-components nội bộ (Private)
│   ├── <Feature>Header.tsx
│   └── <Feature>Item.tsx
├── hooks/                  <- Custom Hooks: State & Logic tách biệt (<= 150 dòng)
│   └── use<Feature>State.ts
├── types.ts                <- Contracts, Props & Zod Schemas
└── utils/                  <- Pure helper functions không chứa JSX
```

- **Giới hạn cứng**: Component file `<= 250 dòng`, Hook `<= 150 dòng`. Vượt ngưỡng bị lõi Rust `fe-core check-edit` chặn tức thì (`exit 2`).
- **Kỷ luật**: Không prop drilling quá 2 cấp, không nhồi inline logic phức tạp vào JSX.

---

## 🦀 Lõi Nội Bộ 100% Rust (`fe-core`)
```bash
./ai/bin/fe-core route --prompt "..."    # Định tuyến 4 chiều prompt tức thì (< 3ms, 0 token)
./ai/bin/fe-core slice <file> <range>   # Cắt lát phẫu thuật 20–40 dòng
./ai/bin/fe-core check-edit --file ...  # Chốt chặn S3 Real-time khi ghi file
./ai/bin/fe-core sloplint <dir>         # Soi diệt AI-Slop (màu tím/hồng, KPI ảo)
./ai/bin/fe-core seo-check <dir>        # Kiểm định Technical SEO, JSON-LD, Dynamic OG, llms.txt
./ai/bin/fe-core qa-filter <log>        # Nén log browser console/network thành gói < 80 token
./ai/bin/fe-core env-guard <dir>        # Chống lộ Secret Key ra client bundle & kiểm tra .env parity
./ai/bin/fe-core sync                   # Đồng bộ 2 chiều các thư mục cấu hình giữa Claude/AGY/OpenCode
```

---

## 📜 Bản Quyền & Giấy Phép
Được xây dựng và bảo chứng bởi **Ngài Vmax** (ViciEO). Giấy phép MIT.
