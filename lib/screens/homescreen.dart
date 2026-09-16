import 'package:flutter/material.dart';

import 'dart:ui';

import 'package:unknow_application/screens/test_screen.dart';
import 'package:unknow_application/screens/food_gacha_screen.dart';
import 'package:unknow_application/utils/asset_helper.dart'; // Dùng cho hàm lerpDouble

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PageController _pageController;
  double _pageValue = 0.0; // Lưu giá trị vị trí cuộn (0.0 -> 1.0 -> 2.0)

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // Lắng nghe liên tục hành động cuộn để cập nhật vị trí nhân vật
    _pageController.addListener(() {
      setState(() {
        _pageValue = _pageController.page ?? 0.0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Lấy kích thước màn hình để tính toán khoảng cách trượt
    final size = MediaQuery.of(context).size;

    // --- TÍNH TOÁN CHUYỂN ĐỘNG CHO NHÂN VẬT DỰA VÀO _pageValue ---
    // Khi ở trang 0 (_pageValue = 0.0): Nhân vật ở giữa màn hình, kích thước to.
    // Khi ở trang 1 hoặc 2 (_pageValue >= 1.0): Nhân vật trượt về góc dưới bên trái, thu nhỏ lại.

    // Tính toán Alignment (từ Alignment.center chuyển dần về Alignment.bottomLeft)
    // _pageValue chạy từ 0.0 đến 1.0 (khi cuộn từ trang 0 sang trang 1)
    double progress = _pageValue.clamp(0.0, 1.0);

    Alignment currentAlignment = Alignment.lerp(
      const Alignment(
        -1,
        0.2,
      ), // Vị trí ban đầu ở màn 1 sang sát bên trái ngay từ trang đầu
      const Alignment(-1, 0.7), // Vị trí đích ở góc dưới bên trái ở màn 2 & 3
      progress,
    )!;

    // Tính toán kích thước ảnh nhân vật thu nhỏ dần khi trượt về góc
    double currentImageWidth = lerpDouble(160, 100, progress)!;
    double currentImageHeight = lerpDouble(220, 140, progress)!;

    // Tính toán độ mờ của bong bóng chữ "Hmm... Chọn gì đây nhỉ?" (mất dần khi sang trang 2)
    double bubbleOpacity = (1.0 - (progress * 1.5)).clamp(0.0, 1.0);

    return Scaffold(
      body: Stack(
        children: [
          // ================= 1. PAGEVIEW (Nội dung thay đổi ở dưới) =================
          PageView(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            children: [
              // --- TRANG 1: Màn hình chào mừng ---
              Container(
                color: const Color(0xFFFFCBCB),
                child: Row(
                  // Đặt các nút bấm ở bên phải, chừa chỗ trống ở giữa/trái cho nhân vật
                  children: [
                    Expanded(flex: 1, child: SizedBox.shrink()),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildMenuButton(
                              text: 'Hôm nay ăn gì',
                              icon: Icons.restaurant_menu,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FoodGachaScreen(),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                            _buildMenuButton(
                              text: 'Hôm nay chơi gì',
                              icon: Icons.sports_esports,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TestScreen(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // --- TRANG 2: Màn hình Hôm nay ăn gì ---
              _buildFeaturePage(
                title: 'Hôm nay ăn gì?',
                demoColor: Colors.orange.shade200,
                demoScreenUrl: AssetHelper.background('hom_nay_an_gi_screen.png'),
                // onTap();
              ),

              // --- TRANG 3: Màn hình Hôm nay chơi gì ---
              _buildFeaturePage(
                title: 'Hôm nay chơi gì?',
                demoColor: Colors.purple.shade200,
                demoScreenUrl: AssetHelper.background('hom_nay_an_gi_screen.png'),
                // onTap();
              ),
            ],
          ),

          // ================= 2. NHÂN VẬT "STICKY" DI CHUYỂN THEO SCROLL =================
          // Lớp này nằm đè lên trên PageView và dịch chuyển mượt mà theo biến progress
          AnimatedContainer(
            duration: const Duration(
              milliseconds: 100,
            ), // Phản hồi cực nhanh theo frame cuộn
            alignment: currentAlignment,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              onTap: () {
                // Nếu đang ở màn 2 hoặc 3, bấm vào nhân vật sẽ thực hiện hành động
                if (_pageValue >= 0.5) {
                  print('Đã bấm vào nhân vật để mở tính năng!');
                }
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Ảnh nhân vật thay đổi kích thước mượt mà
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Bong bóng suy nghĩ ẩn hiện mượt mà tùy theo progress cuộn
                      Opacity(
                        opacity: bubbleOpacity,
                        child: bubbleOpacity > 0.05
                            ? Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 6,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: const Text(
                                  'Hmm... Chọn gì đây nhỉ?',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                      // Khi đã sang trang 2 hoặc 3, hiện thêm bong bóng nhỏ hoặc lời nhắc cạnh nhân vật ở góc trái
                      if (progress > 0.8) ...[
                        const SizedBox(width: 0),
                        FadeTransition(
                          opacity: AlwaysStoppedAnimation(progress),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 0),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Text(
                              'Gacha tại đây 👉',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ),
                        ),
                      ],
                      Image.asset(
                        'assets/images/thinking.png',
                        width: currentImageWidth,
                        height: currentImageHeight,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget giao diện chuẩn cho trang 2 và trang 3
  Widget _buildFeaturePage({
    required String title,
    required Color demoColor,
    required String demoScreenUrl,
  }) {
    return Container(
      color: const Color(0xFFFFCBCB),
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const SizedBox(height: 50),
          Text(
            title,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          // Khung demo tính năng chiếm phần lớn không gian phía trên/phải
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(
                left: 100,
              ), // Chừa chỗ trống ở góc trái bên dưới cho nhân vật đứng
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(demoScreenUrl),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 100,
          ), // Khoảng trống đáy để nhân vật góc trái không đè lên viền
        ],
      ),
    );
  }

  Widget _buildMenuButton({
    required String text,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.deepPurple),
      label: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.deepPurple,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        elevation: 4,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}
