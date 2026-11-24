# TypeScript & React Modern Hardening Rules (Elegans Standards)

> Áp dụng bắt buộc cho toàn bộ file `.ts` và `.tsx` trong hệ thống Elegans.

---

## 1. Types & Interfaces

- **Cấm dùng `any`**: Sử dụng `unknown` cho dữ liệu đầu vào chưa rõ ràng từ bên ngoài (API, User Input), sau đó dùng type guard hoặc Zod schema để narrow kiểu một cách an toàn.
- **Explicit Return Types**: Khai báo rõ kiểu trả về cho các hàm công khai, server actions, và custom hooks.
- **Props Definition**: Component props bắt buộc định nghĩa bằng `interface <Name>Props` có tên tường minh. Callback props phải định nghĩa chữ ký hàm rõ ràng (ví dụ: `onSelect: (id: string) => void`), cấm dùng `Function`.

---

## 2. React State & Side Effects

- **Cấm dùng `useEffect` cho Derived State**: Bất kỳ giá trị nào có thể tính toán được từ Props hoặc State hiện có phải tính toán trực tiếp hoặc bọc qua `useMemo` nếu chi phí tính toán cao. Cấm tạo state mới và `useEffect` chỉ để `setState` theo state khác.
- **Bắt buộc Cleanup Effect**: Mọi timer (`setTimeout`, `setInterval`), event listener (`addEventListener`), hoặc observer (`ResizeObserver`) trong `useEffect` phải trả về hàm dọn dẹp (cleanup function).
- **Zustand State Selector**: Khi đọc dữ liệu từ store, bắt buộc dùng selector hẹp hoặc `useShallow` để ngăn chặn re-render diện rộng.

---

## 3. Immutability & Safe Mutation

- Luôn cập nhật state dưới dạng immutable (sử dụng spread operator hoặc mảng copy `[...arr, newItem]`).
- Tránh thay đổi trực tiếp thuộc tính của object (`item.active = true` -> `{ ...item, active: true }`).

---

## 4. Input Validation

- Dữ liệu nhận từ form submit, URL params, hoặc API request bên ngoài bắt buộc validate qua schema (ưu tiên Zod) để đảm bảo an toàn kiểu dữ liệu và chống injection.
