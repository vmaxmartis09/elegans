---
name: fe-accessibility-wcag
description: "Accessibility (WCAG 2.2 Level AA) Engineering & Audit Playbook. Enforces semantic HTML, icon aria-label contracts, keyboard focus rings, touch targets >= 44x44px (>= 24x24px desktop), and screen-reader tree validation."
---

# Kiểm Thử & Chuẩn Hóa Tiếp Cận WCAG 2.2 AA (`fe-accessibility-wcag`)

Nhãn điều động: **`🏷️ [Elegans :: fe_qa_tester]`** / **`🏷️ [Elegans :: fe_ui_ux_critic]`**  
Chắt lọc từ tiêu chuẩn WCAG 2.2 AA và tri thức hệ thống từ ECC, tinh chỉnh tuyệt đối theo quy tắc UI của Elegans: **Ưu tiên Icon thay chữ, nhưng 100% Nút Icon bắt buộc có `aria-label`**.

---

## 1. Nguyên Tắc Cốt Lõi P-O-U-R (WCAG 2.2 AA)

1. **Perceivable (Có thể cảm nhận được)**:
   - **Tỉ lệ tương phản màu (Contrast Ratio)**: Text thường tối thiểu **4.5:1**; Text lớn (>= 18pt / 14pt bold) hoặc UI Component viền/icon tối thiểu **3.0:1**.
   - **Non-text Content**: Mọi ảnh phải có `alt` (nếu là ảnh trang trí dùng `alt=""` hoặc `aria-hidden="true"`).
   - **Icon-Only Buttons (Quy tắc Elegans P4)**: Bất kỳ button/link nào chỉ chứa icon **BẮT BUỘC** có `aria-label="Tên hành động"` rõ ràng, ngắn gọn và thuộc tính `title` khi cần gợi ý hover.

2. **Operable (Có thể thao tác được)**:
   - **Kích thước vùng chạm (Target Size - SC 2.5.8)**:
     - Desktop: Tối thiểu `24×24px`.
     - Mobile (theo `MOBILE_DESIGN_CONTRACT.md`): Vùng chạm tương tác tối thiểu **`44×44px`** (dù kích thước hiển thị visual của icon là `h-6~h-8` tròn, vùng bấm padding xung quanh phải đạt chuẩn `44px`).
   - **Keyboard Navigation & Focus Appearance (SC 2.4.11)**: Mọi interactive element đều có thể focus bằng phím `Tab`. Tuyệt đối **cấm** `outline: none` mà không có class focus thay thế (`focus-visible:ring-2 focus-visible:ring-offset-2`).
   - **Single Pointer Alternative**: Mọi thao tác kéo thả (drag/swipe gesture) phải có cách bấm/nút thay thế tương đương.

3. **Understandable (Có thể hiểu được)**:
   - Không tự động kích hoạt hành động gây bất ngờ khi focus (`onFocus` không trigger navigate/submit).
   - Thông báo lỗi form phải gán kèm `aria-describedby` trỏ tới ID của thông báo lỗi.

4. **Robust (Độ tin cậy & tương thích màn hình đọc)**:
   - Dùng đúng thẻ HTML ngữ nghĩa (`<button>`, `<a>`, `<dialog>`, `<nav>`, `<main>`) thay vì lạm dụng `<div onClick>`.
   - Trạng thái mở rộng/thu gọn của Accordion / Dropdown / Drawer phải bind `aria-expanded={isOpen}` và `aria-controls="panel-id"`.

---

## 2. Checklist Kiểm Định Trước Khi Duyệt UI

| Tiêu Chí | Kiểm Tra | Pass / Fail |
| :--- | :--- | :--- |
| **Icon Button** | Có `aria-label` miêu tả hành động không? | Bắt buộc |
| **Touch Target** | Vùng bấm mobile đạt tối thiểu 44x44px chưa? | Bắt buộc |
| **Focus Ring** | Phím Tab duyệt qua có hiện viền focus rõ ràng không? | Bắt buộc |
| **Contrast** | Màu chữ / nền đạt tối thiểu 4.5:1 không? | Bắt buộc |
| **Screen Reader** | Drawer / Modal mở ra có trap focus & ESC để đóng không? | Bắt buộc |
| **Live Region** | Toast / thông báo nổi có `role="status"` hoặc `aria-live="polite"` không? | Bắt buộc |
