---
name: fe-showroom-cloner
description: "Zero-Loss Website Reverse-Engineering (REA + AI Website Cloner) & Interactive 3D Product Showroom Playbook: Automotive Liquid Morph + GSAP SplitText, 184vw–200vw Rotating Product Wheel (@property + SVG textPath), 90° Boutique Garment Rail (Per-Slot Perspective + Anti-Overflow Flex), and React Bits CardSwap 3D Spring Preview."
---

# Playbook Đảo Ngược Website (`ZERO-LOSS-REVERSE`) & Dựng Showroom Sản Phẩm 3D Tương Tác

Đúc kết thực chiến từ quy trình nghiên cứu đa kênh video (TikTok/Reels/@webloved/@settigation/@online.by.annie), kết hợp phương pháp **`morluto/rea`** (Reverse Engineer Anything) và **`JCodesMore/ai-website-cloner-template`**.

---

## 1. Quy Trình Trinh Sát Video & Đảo Ngược Live URL (`fe_design_scout`)

### 1.1. Cô Lập Không Gian Trình Duyệt Ego Lite (Tuyệt Đối Không Chạm Space Người Dùng)
- Luôn tạo `TaskSpace` riêng có tên rõ ràng và bọc trong `try ... finally` để tự dọn sạch khi xong:
  ```js
  const task = await taskSpace("scout_target_site");
  try {
    const page = task.page("p1");
    await page.goto(targetUrl, { waitUntil: "domcontentloaded", timeout: 35000 });
    // Trích xuất computed styles, fonts, media URLs, trạng thái tương tác
  } finally {
    await task.finish({ keep: [] });
  }
  ```
- **Cấm tuyệt đối** can thiệp, đóng tab hoặc chiếm quyền trên không gian cá nhân của Ngài Vmax (`"Dad"`, `"Main Vmax"`).

### 1.2. Bóc Tách Từ Video Demo (TikTok / Reels / MP4) Khi Không Có Link Gốc
1. Trích xuất tối thiểu **3–4 keyframes chiến lược** mỗi video:
   - `f1`: Bố cục nghỉ ban đầu (Typography, ánh sáng nền, vị trí thanh điều hướng/rail).
   - `f2`: Khoảnh khắc hover/drag giữa chừng (đo góc nghiêng 3D, hướng xoay, biến đổi màu nền).
   - `f3`: Trạng thái active/mở chi tiết (nút CTA phụ như `Take a closer look` / `SEE AVAILABILITY`, modal chọn size/frame scrubber).
2. Phân biệt rõ biến đổi do **Scroll**, **Wheel/Drag**, **Hover** hay **Autoplay** — không bao giờ thay thế chuyển động kéo/xoay vật lý bằng tab tĩnh.

### 1.3. Thu Thập & Làm Sạch Tài Nguyên Gốc (Asset Hygiene)
- Tải đúng font `.woff2`, video `.mp4` (cả bản desktop và bản dọc mobile nếu có), ảnh `.webp`/SVG thật từ CDN gốc.
- **Chuẩn hóa tên file CDN (Prismic/Sanity/Cloudinary)**: Khi gỡ tiền tố hash (ví dụ `ahvhfQeQX7-eWdI__pesto-rosso.webp`), kiểm tra dấu gạch dưới kép `__` để không sót `_` ở đầu tên file gây lỗi `404` ngầm; luôn kiểm chứng bằng `img.complete && img.naturalWidth > 0`.
- **Vendor JS đã minify** (như `gsap-*.min.js` đặt trong `public/sites/<slug>/lib/`): Thêm `/* eslint-disable */\n` ở dòng đầu để không vi phạm ESLint của dự án chính và gỡ sạch script tracking bên thứ ba (Cloudflare Beacon, GA).

---

## 2. Bốn Kiến Trúc Showroom Sản Phẩm 3D Thực Chiến (`fe_senior_dev`)

### Mẫu 1 — Showroom Siêu Xe & Hàng Xa Xỉ (Automotive Morph + GSAP SplitText)
- **Cấu trúc**: Hero video kim loại lỏng / chuyển hình AI (`hero.mp4` ngang cho desktop, `hero-phone.mp4` cho mobile `< 768px` kèm `poster` `.webp` chống chớp đen) + tiêu đề lớn GSAP `SplitText` + bảng thông số tối giản đường kẻ mảnh `1px` + danh mục đội xe đổi ảnh góc nghiêng/chính diện khi hover.

### Mẫu 2 — Bánh Xe Xoay Khổng Lồ `184vw–200vw` (Mỹ Phẩm · Thực Phẩm · Đồ Uống)
- **Bài toán**: Hiển thị đồng thời **3 sản phẩm trên màn hình** (hũ giữa thẳng đứng `0°`, hũ trái nghiêng `-18°`, hũ phải nghiêng `+18°`) ngồi trên vòm màu trung tâm.
- **Công thức Hình học Chuẩn**:
  - Đặt tâm bánh xe bên dưới đáy màn hình: `.wheel { width: 184vw; height: 184vw; left: 50%; top: calc(44vh + 92vw); margin: -92vw 0 0 -92vw; }`.
  - Chia đúng **20 khe cách nhau `18deg`** (`20 × 18° = 360°`, lặp chẵn 2 chu kỳ cho 10 sản phẩm để xoay vô tận không có vết nối; khoảng cách ngang `92vw × sin(18°) ≈ 28.4vw` giữ trọn 2 hũ kế cận trong khung `16:9` lẫn mobile).
- **Chuyển màu nền mượt 60fps**: Khai báo CSS Houdini `@property --bg { syntax: "<color>"; ... }` và `@property --arch { syntax: "<color>"; ... }` kết hợp vòng chữ cong `<svg><textPath>` xoay ngược chiều nhẹ (`deg * 0.65`).

### Mẫu 3 — Giá Treo Quần Áo 3D Xoay `90°` (Boutique Váy Dạ Hội & Tủ Đồ Streetwear)
- **Hai Lỗi Hình Học Kinh Điển Cần Tránh**:
  1. *Tràn khung / móc treo lơ lửng ngoài thanh sắt*: **CẤM** dùng `flex: 0 0 68px` cố định cho các món đồ. Bắt buộc giới hạn `.rail-items` nằm lọt lòng giữa hai chân giá đỡ/pát gắn tường (`width: calc(100% - 68px)` hoặc `74%` bên trong thanh treo `92%`) và dùng **tỷ lệ co giãn `flex: 1 1 0; min-width: 0`** cho món đang nghỉ ↔ **`flex: 2.8~3.2 1 0`** cho món đang mở!
  2. *Món đồ ở rìa phải bị mỏng dính như sợi chỉ 1px*: **CẤM** đặt `perspective` trên thẻ cha `.rail-items` (vì góc nhìn lệch ngang ở rìa cộng thêm `~18°` vào `rotateY(72deg)` thành `90°` biến mất!). Bắt buộc đặt **`perspective: 950px` riêng trên từng `.dress-slot` / `.garment-slot`**, hoặc kết hợp cặp SVG/ảnh kép `Side-Profile` ↔ `Front-View` kèm thanh trượt soi góc xoay 30 khung hình (`0°–90°`).

### Mẫu 4 — Chồng Thẻ 3D `CardSwap` Preview Gắn Vào Trang Dịch Vụ / Kỹ Năng
- **Tách Engine & View theo chuẩn Co-location**:
  - `engine.ts`: Bộ tích phân lò xo (`integrate`), tự co giãn theo khung chứa (`ResizeObserver`), tự ngủ hoàn toàn khi khuất tầm nhìn (`IntersectionObserver` + `visibilitychange` + dừng `rAF` khi `busy === false`), kéo-thả có quán tính (`pointercapture` + fling velocity), và hàm `goToCard(index)`.
  - `CardSwap.tsx` (`<= 200` dòng) + `components/SwapCard.tsx` (`<= 80` dòng): Chỉ render JSX sạch, ảnh `.webp` nén nhẹ (`~15–45KB`, `960px`) có `loading="lazy" decoding="async"`.
- **Đồng bộ Tương tác 2 Chiều**:
  - Rê chuột vào tên dự án ở cột trái gọi `cardSwapRef.current?.goToCard(idx)` để lật thẻ tương ứng lên mặt trước.
  - Bấm vào thẻ mặt trước hoặc hàng tên dự án mở ngay cổng `<WebShowcaseModal>` toàn màn hình (`header` nổi `bg-transparent`, nút chuyển nhanh các mẫu, nút mở tab mới & đóng đạt `>= 44x44px` trên mobile).
- **Hợp đồng Mobile (`MOBILE_DESIGN_CONTRACT.md`)**:
  - Gắn `data-gesture-zone="horizontal-only"` + `data-no-morph` trên vùng `CardSwap` để thao tác kéo thẻ không làm trôi trang dọc.
  - Đưa `CardSwap` lên đầu nội dung mở trên mobile (`max-md:order-first`) và chừa đáy `max-md:pb-28` để không bao giờ bị thanh dock nổi che khuất.

---

## 3. Đóng Gói Đa Showroom Trong Next.js & Kiểm Tra Trước Deploy (`fe_devops_deployer`)
1. Lưu từng bản clone độc lập tại `public/sites/<slug>/index.html` và ảnh đại diện tại `public/sites/previews/<slug>.webp`.
2. Cấu hình **`redirects()`** (không dùng `rewrites()`) trong `next.config.ts` từ `/sites/:slug` sang `/sites/:slug/index.html` để mọi đường dẫn tương đối (`./img/`, `./fonts/`, `./lib/`) luôn phân giải đúng thư mục gốc của bản clone.
3. **Tránh xung đột `.next`**: Dừng daemon `npm run dev` trước khi chạy `npm run build`, sau khi build sạch mới bật lại `npm run dev`.
4. **Kiểm tra quyền Git Author trước khi Deploy Cloud (`TEAM_ACCESS_REQUIRED`)**: Đối chiếu `git config user.email` với tài khoản/team trên Vercel (`vercel whoami`) trước khi commit; nếu lệch quyền team thì báo trung thực cho Ngài Vmax xử lý quyền hoặc xác nhận email commit, tuyệt đối không tự ý giả mạo định danh Git.
