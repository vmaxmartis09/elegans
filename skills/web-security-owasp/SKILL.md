---
name: web-security-owasp
description: "Web Perimeter & Frontend Security (OWASP Top 10 Client-Side Hardening). Protects against XSS, secret token exposure, CSRF, insecure storage, and unsafe iframe embedding. Integrates with fe-core env-guard."
---

# Bảo Mật Frontend & Chu vi Web OWASP (`web-security-owasp`)

Nhãn điều động: **`🏷️ [Elegans :: fe_code_auditor]`**  
Chắt lọc từ tiêu chuẩn OWASP 2025 Client-Side Security và cơ chế phòng thủ `env-guard` của Elegans.

---

## 1. 5 Lỗ Hổng Client-Side Nguy Hiểm Nhất

1. **Rò Rỉ Khóa Bí Mật Ra Client Bundle (Secret Leakage)**:
   - **Quy tắc tuyệt đối**: Mọi biến môi trường chứa `SECRET`, `PRIVATE`, `KEY`, `TOKEN`, `DATABASE_URL` **CẤM TUYỆT ĐỐI** đặt tiền tố `NEXT_PUBLIC_*`, `VITE_*` hay `NUXT_PUBLIC_*`.
   - Chạy kiểm tra tự động bằng Rust native: `./ai/bin/fe-core env-guard .` trước mỗi lần build/deploy.
2. **Cross-Site Scripting (XSS)**:
   - Tuyệt đối cấm dùng `dangerouslySetInnerHTML`, `v-html` hoặc `{@html}` với dữ liệu nhận từ người dùng hoặc API bên ngoài khi chưa qua bộ lọc `DOMPurify` (hoặc `sanitize-html`).
   - Cấm render URL dạng `href={userUrl}` nếu `userUrl` bắt đầu bằng `javascript:`. Luôn kiểm tra giao thức (`http://`, `https://`, `mailto:`).
3. **Lưu Trữ Token Bất Cẩn (Insecure Storage)**:
   - Refresh token và Access token phiên dài hạn không được lưu trong `localStorage` (dễ bị đánh cắp bởi mã độc XSS từ 3rd party script).
   - Ưu tiên cơ chế `HttpOnly, Secure, SameSite=Lax/Strict` Cookies thông qua Server/Route Handler.
4. **Clickjacking & Iframe Sandboxing**:
   - Mọi iframe nhúng bên thứ ba (YouTube, Spotify, Soundcloud, bản đồ) bắt buộc có thuộc tính `sandbox="allow-scripts allow-same-origin"` và `loading="lazy"`.
5. **Content Security Policy (CSP)**:
   - Cấu hình header CSP cấm `unsafe-eval` trong môi trường Production.
