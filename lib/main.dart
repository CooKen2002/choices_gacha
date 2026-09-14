import 'package:flutter/material.dart';

// import 'package:unknow_application/test_screen.dart';

void main() {
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen()),
  );
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  // This widget is the root of your application.
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose(); // Nhớ giải phóng controller khi thoát màn hình
    super.dispose();
  }

  // MARK: BUILD
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        scrollDirection: Axis.vertical, // Đặt hướng cuộn là DỌC (lên/xuống)
        children: [
          SumaryPageItem(title: '', color: Colors.red.shade100),
          // Trang giới thiệu 1
          IntroPageItem(
            title: 'Chào mừng bạn đến với App',
            color: Colors.blue.shade100,
          ),
          // Trang giới thiệu 2
          IntroPageItem(
            title: 'Khám phá các tính năng tuyệt vời',
            color: Colors.orange.shade100,
          ),
          // Trang giới thiệu 3
          IntroPageItem(
            title: 'Bắt đầu sử dụng ngay thôi!',
            color: Colors.green.shade100,
            isLastPage: true,
          ),
        ],
      ),
    );
  }
}

class SumaryPageItem extends StatelessWidget {
  final String title;
  final Color color;
  final bool isLastPage;

  const SumaryPageItem({
    super.key,
    required this.title,
    required this.color,
    this.isLastPage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Tiêu đề trang ở trên cùng
            Text(
              title,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // Khu vực chính: Nhân vật và các nút bấm đặt cạnh nhau
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 1. Phần Nhân vật kèm bong bóng suy nghĩ
                Column(
                  children: [
                    // Bong bóng suy nghĩ (Thought Bubble)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Các chấm nhỏ của bong bóng suy nghĩ
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
                        const SizedBox(width: 4),
                        Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Ảnh nhân vật
                    Image.asset(
                      'assets/images/thinking.png',
                      width: 160,
                      height: 220,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),

                const SizedBox(width: 40), // Khoảng cách giữa nhân vật và các nút

                // 2. Phần các nút bấm (Menu lựa chọn)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMenuButton(
                      text: 'Hôm nay ăn gì',
                      icon: Icons.restaurant_menu,
                      onPressed: () {
                        print('Chuyển sang quay hòm Đồ ăn');
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildMenuButton(
                      text: 'Hôm nay chơi gì',
                      icon: Icons.sports_esports,
                      onPressed: () {
                        print('Chuyển sang quay hòm Trò chơi');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Hàm phụ trợ giúp tái sử dụng style cho các nút bấm đẹp hơn
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
        foregroundColor: Colors.deepPurple.shade100,
        elevation: 4,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}

class IntroPageItem extends StatelessWidget {
  final String title;
  final Color color;
  final bool isLastPage;

  const IntroPageItem({
    super.key,
    required this.title,
    required this.color,
    this.isLastPage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            if (isLastPage)
              ElevatedButton(
                onPressed: () {
                  // Xử lý chuyển sang màn hình chính của app ở đây
                  print('Chuyển trang chính');
                },
                child: const Text('Bắt đầu'),
              )
            else
              const Icon(
                Icons.keyboard_arrow_down,
                size: 40,
              ), // Gợi ý vuốt xuống
          ],
        ),
      ),
    );
  }
}
