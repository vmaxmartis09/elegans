---
name: fe-performance-audit
description: "Advanced Frontend Performance, Memory Leak, Hydration Error & Bundle Size Elimination Playbook. Hardened for Next.js 14-15 App Router, React 19, and Vite. Enforces Core Web Vitals (LCP < 2.5s, CLS = 0.00, INP < 200ms)."
---

# Kiểm Toán Hiệu Năng & Diệt Rò Rỉ Bộ Nhớ (`fe-performance-audit`)

Nhãn điều động: **`🏷️ [Elegans :: fe_code_auditor]`** / **`🏷️ [Elegans :: fe_senior_dev]`**  
Chắt lọc từ kinh nghiệm tối ưu hóa thực chiến của ECC và kiến trúc zero-bloat của Elegans.

---

## 1. 4 Ổ Dịch Gây Memory Leak & Treo Tab Trình Duyệt

1. **Uncleaned Listeners & Observers**:
   - Mọi `window.addEventListener`, `document.addEventListener`, `ResizeObserver`, `IntersectionObserver`, `MutationObserver` tạo trong `useEffect` hoặc gesture handler **bắt buộc** phải return hàm cleanup tương ứng:
   ```typescript
   useEffect(() => {
     const observer = new ResizeObserver(entries => { /* ... */ });
     if (ref.current) observer.observe(ref.current);
     return () => observer.disconnect(); // BẮT BUỘC
   }, []);
   ```
2. **GSAP & Animation Timers Trôi Dạt**:
   - GSAP ScrollTrigger hoặc Timeline nếu không gọi `.kill()` / `ctx.revert()` khi unmount sẽ tiếp tục chạy ngầm trong RAM.
   - Khi hủy (cancel) gesture chuyển cảnh, **bắt buộc hồi phục 100% thuộc tính** (`opacity`, `transform`, `clearProps`), cấm để sót trạng thái dính chồng UI (Quy tắc Chống dính UI của Elegans).
3. **Pending Network Requests & Race Conditions**:
   - Mọi `fetch` trong `useEffect` phải gắn kèm `AbortController`:
   ```typescript
   useEffect(() => {
     const controller = new AbortController();
     fetchData({ signal: controller.signal }).catch(err => {
       if (err.name !== 'AbortError') handleErr(err);
     });
     return () => controller.abort();
   }, [deps]);
   ```
4. **Detached DOM Nodes & Event Bus Retainers**:
   - Gắn callback vào singleton audio engine, socket, hoặc bus toàn cục mà quên `unsubscribe` khi component unmount.

---

## 2. Diệt Lỗi Hydration Mismatch (Next.js / SSR)

- **Nguyên nhân**: Dùng `window`, `localStorage`, `navigator.userAgent`, `Date.now()`, `Math.random()` trực tiếp khi render SSR dẫn đến HTML từ Server khác với Client.
- **Giải pháp chuẩn hóa**:
  1. Dùng pattern `useSyncExternalStore` hoặc custom hook `useMounted` có kiểm soát.
  2. Bọc các component phụ thuộc client vào `dynamic(() => import(...), { ssr: false })`.
  3. Tuyệt đối không lồng thẻ không hợp lệ (ví dụ: `<p>` lồng trong `<p>`, `<div>` lồng trong `<p>`).

---

## 3. Tối Ưu Hóa Kích Thước Bundle & Core Web Vitals

1. **Tree-shaking & Dynamic Imports**:
   - Các thư viện nặng (Canvas 3D Three.js, Lucide icons dạng barrel import, audio wave analyzer, biểu đồ Recharts) bắt buộc import trực tiếp theo submodule hoặc dùng `React.lazy` / Next.js `dynamic()`.
2. **Ngưỡng Core Web Vitals Bắt Buộc**:
   - **LCP (Largest Contentful Paint)**: `< 2.5s` (Ảnh hero phải có `priority`, format WebP/AVIF, định rõ `width/height`).
   - **CLS (Cumulative Layout Shift)**: `= 0.00` (Khung ảnh/video/bento phải có placeholder aspect ratio).
   - **INP (Interaction to Next Paint)**: `< 200ms` (Tránh blocking main thread bằng heavy task; dùng `startTransition` cho tác vụ cập nhật diện rộng).
