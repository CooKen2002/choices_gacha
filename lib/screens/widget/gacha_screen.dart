import 'dart:math';
import 'package:flutter/material.dart';

// 1. Định nghĩa mô hình dữ liệu chung cho một phần tử (Item)
class LootItem {
  final String id;
  final String name;
  final IconData icon;
  final Color color;

  LootItem({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });
}

class LootBoxScreen extends StatefulWidget {
  final String title;
  final List<LootItem> items; // Danh sách các phần tử truyền vào tùy biến

  const LootBoxScreen({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  State<LootBoxScreen> createState() => _LootBoxScreenState();
}

class _LootBoxScreenState extends State<LootBoxScreen> {
  late final ScrollController _scrollController;
  bool _isSpinning = false;
  LootItem? _wonItem;

  // Kích thước của mỗi ô item trên băng chuyền
  final double _itemWidth = 120.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Hàm thực hiện hiệu ứng quay
  void _spinTheBox() {
    if (_isSpinning) return;

    setState(() {
      _isSpinning = true;
      _wonItem = null;
    });

    final random = Random();
    // Tạo một danh sách items nhân bản lên nhiều lần để tạo cảm giác cuộn dài
    // Tổng số item trên băng chuyền = widget.items.length * 50 (chu kỳ lặp)
    int totalItems = widget.items.length * 50;
    
    // Chọn ngẫu nhiên một index trúng thưởng nằm ở nửa sau của danh sách
    int winningIndex = widget.items.length * 25 + random.nextInt(widget.items.length);

    // Tính toán khoảng cách cần cuộn sao cho item trúng thưởng nằm chính giữa màn hình
    double screenWidth = MediaQuery.of(context).size.width;
    double targetOffset = (winningIndex * _itemWidth) - (screenWidth / 2) + (_itemWidth / 2);

    // Thực hiện animate cuộn đến vị trí trúng thưởng
    _scrollController.animateTo(
      targetOffset,
      duration: const Duration(seconds: 4), // Thời gian quay (4 giây)
      curve: Curves.decelerate, // Hiệu ứng giảm tốc dần khi gần dừng
    ).then((_) {
      // Khi quay xong
      setState(() {
        _isSpinning = false;
        _wonItem = widget.items[winningIndex % widget.items.length];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Nhân bản danh sách item lên nhiều lần để băng chuyền đủ dài khi cuộn
    List<LootItem> extendedItems = [];
    for (int i = 0; i < 50; i++) {
      extendedItems.addAll(widget.items);
    }

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Thông báo kết quả khi quay xong
            if (_wonItem != null)
              Text(
                '🎉 Bạn đã trúng: ${_wonItem!.name}!',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
              )
            else
              const Text(
                'Hãy bấm nút bên dưới để quay!',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            
            const SizedBox(height: 40),

            // Khu vực hộp quay (Loot Box Container)
            SizedBox(
              height: 140,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Băng chuyền ngang chứa các item
                  ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(), // Khóa không cho người dùng tự vuốt tay
                    itemCount: extendedItems.length,
                    itemBuilder: (context, index) {
                      final item = extendedItems[index];
                      return Container(
                        width: _itemWidth,
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          color: item.color.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: item.color, width: 2),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(item.icon, size: 40, color: item.color),
                            const SizedBox(height: 8),
                            Text(
                              item.name,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  // Thanh chỉ vị trí (Kim chỉ nam) nằm chính giữa màn hình
                  Positioned(
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: 4,
                      color: Colors.red, // Đường kẻ màu đỏ chỉ vị trí trúng
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Nút bấm kích hoạt quay
            ElevatedButton(
              onPressed: _isSpinning ? null : _spinTheBox,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text(
                _isSpinning ? 'Đang quay...' : 'QUAY NGAY',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}