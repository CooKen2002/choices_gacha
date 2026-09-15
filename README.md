# 🍜 Choices Gacha: Hương Vị Việt Nam

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20Windows-blue?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-In%20Development-orange?style=for-the-badge)

*Tựa game di động và máy tính kết hợp phong cách Gacha giải quyết câu hỏi muôn thuở: **"Hôm nay ăn gì?"** và **"Hôm nay chơi gì?"** mang đậm nét văn hóa ẩm thực Việt Nam.*

</div>

---

## ✨ Giới thiệu Dự án

**Choices Gacha** là một ứng dụng đa nền tảng (Cross-platform) được xây dựng bằng **Flutter**, tập trung vào trải nghiệm giải trí nhẹ nhàng kết hợp hệ thống gacha vật phẩm/món ăn ẩm thực truyền thống Việt Nam. 

Dự án được tối ưu hóa giao diện linh hoạt cho cả thiết bị di động (Portrait) và máy tính để bàn (Landscape 16:9), mang lại trải nghiệm mượt mà với hiệu ứng động tùy chỉnh theo thời gian thực.

---

## 🎮 Tính năng nổi bật

- **Hệ thống Gacha Ẩm thực & Trò chơi:**
  - 🍲 **"Hôm nay ăn gì"**: Khám phá và quay thưởng các món ăn đặc sản Việt Nam.
  - 🎮 **"Hôm nay chơi gì"**: Gợi ý các hoạt động giải trí thú vị.
- **Giao diện Responsive Thích ứng Đa nền tảng:**
  - Tự động thay đổi bố cục và tài nguyên hình ảnh (`assets`) tùy theo thiết bị (Android / Windows / Web).
- **Hiệu ứng Chuyển động Mượt mà (Smooth UI Animations):**
  - Nhân vật "Sticky" tương tác thông minh, chuyển động và thu nhỏ linh hoạt theo thao tác cuộn trang của người dùng.
- **Phong cách Thiết kế Hiện đại:**
  - Sử dụng hệ thống Stack, AnimatedContainer và màu sắc tươi sáng, giao diện thân thiện, dễ sử dụng.

---

## 🛠 Công nghệ Sử dụng

- **Framework:** [Flutter](https://flutter.dev/) (SDK mới nhất)
- **Language:** [Dart](https://dart.dev/)
- **State Management & UI Control:** Native Flutter widgets (`PageView`, `Stack`, `AnimatedContainer`, `LayoutBuilder`)
- **Platform Handling:** `dart:io` (`Platform`) & `flutter/foundation.dart` (`kIsWeb`)

---

## 📁 Cấu trúc Thư mục Dự án

```text
lib/
│
├── main.dart             # Điểm khởi chạy ứng dụng & Quản lý điều hướng chính
├── screens/              # Các màn hình tính năng (Home, Gacha Food, v.v.)
└── widgets/              # Các thành phần UI tái sử dụng (Menu buttons, nhân vật, v.v.)

assets/
├── images/               # Tài nguyên hình ảnh phân chia theo nền tảng
│   ├── common/           # Ảnh dùng chung
│   ├── desktop/          # Giao diện ngang 16:9 cho Windows
│   └── phone/            # Giao diện dọc cho Mobile