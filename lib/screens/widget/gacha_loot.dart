import 'dart:math';

import 'package:flutter/material.dart';
import 'package:unknow_application/models/product.dart';
import 'package:unknow_application/utils/asset_helper.dart';

class GachaLootWidget extends StatefulWidget {
  final List<Product> items; // Danh sách các phần tử truyền vào tùy biến

  const GachaLootWidget({super.key, required this.items});

  @override
  State<GachaLootWidget> createState() => _GachaLootWidgetState();
}

class _GachaLootWidgetState extends State<GachaLootWidget> {
  bool startGacha = false;
  late final ScrollController _scrollController;

  // Chiều rộng của mỗi thẻ sản phẩm (Item card width)
  static const double itemWidth = 140.0;
  // Số lượng lần nhân bản danh sách để tạo cuộn dài
  static const int repeatCount = 50;
  Color _rarityColor(String rarity) {
    switch (rarity) {
      case 'Legendary':
        return Colors.orange;
      case 'Exotic':
        return Colors.redAccent;
      case 'Epic':
        return Colors.purple;
      case 'Rare':
        return Colors.blue;
      case 'Uncommon':
        return Colors.green;
      case 'Common':
      default:
        return Colors.grey;
    }
  }

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

  // Hàm thực hiện hiệu ứng quay hòm
  void _spinGacha() {
    if (startGacha || widget.items.isEmpty) return;

    setState(() {
      startGacha = true;
    });

    final random = Random();
    // 1. Chọn ngẫu nhiên một phần tử trúng thưởng ở vòng gần cuối
    int winningIndexInOriginal = random.nextInt(widget.items.length);

    // 2. Tính toán vị trí dừng chính xác để item trúng thưởng nằm đúng ở giữa màn hình
    // Đặt item trúng thưởng ở cụm khoảng giữa của danh sách nhân bản
    int targetCluster = repeatCount ~/ 2;
    int targetIndex =
        (targetCluster * widget.items.length) + winningIndexInOriginal;

    // Lấy kích thước màn hình để tính khoảng cách bù trừ căn giữa vạch vàng
    double screenWidth = MediaQuery.of(context).size.width;
    double targetOffset =
        (targetIndex * itemWidth) - (screenWidth / 2) + (itemWidth / 2);

    // Thêm một chút random lệch nhỏ sang trái/phải bên trong item tạo cảm giác tự nhiên
    targetOffset += (random.nextDouble() - 0.5) * (itemWidth * 0.4);

    // 3. Thực hiện cuộn mượt mà với hiệu ứng giảm tốc dần (easeOutCubic)
    _scrollController
        .animateTo(
          targetOffset,
          duration: const Duration(seconds: 4), // Thời gian quay (4 giây)
          curve: Curves.easeOutCubic, // Hiệu ứng hãm phanh chậm dần chuẩn CS:GO
        )
        .then((_) {
          // Khi quay xong
          setState(() {
            startGacha = false;
          });

          // Hiển thị kết quả món quà trúng thưởng
          Product winningProduct = widget.items[winningIndexInOriginal];
          _showWinningDialog(winningProduct);
        });
  }

  // Hộp thoại thông báo khi quay trúng item
  void _showWinningDialog(Product product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('🎉 Chúc mừng bạn nhận được!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AssetHelper.image(product.imageFileName),
              width: 100,
              height: 100,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 10),
            Text(
              product.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Độ hiếm: ${product.rarity}',
              style: TextStyle(
                color: _rarityColor(
                  product.rarity,
                ), // ✅ đồng bộ màu theo độ hiếm
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tuyệt vời'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Nhân bản danh sách item lên nhiều lần để băng chuyền đủ dài khi cuộn
    List<Product> extendedItems = [];
    for (int i = 0; i < repeatCount; i++) {
      extendedItems.addAll(widget.items);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Tiêu đề thay cho AppBar, để nền xuyên thấu
        Padding(padding: const EdgeInsets.symmetric(vertical: 20)),

        // BĂNG CHUYỀN QUAY HÒM
        SizedBox(
          width: double.infinity,
          child: Container(
            height: 220,
            child: Stack(
              alignment: Alignment.center,
              children: [
                ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: extendedItems.length,
                  itemBuilder: (context, index) {
                    final product = extendedItems[index];
                    return Container(
                      width: itemWidth,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2A2E39),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey.shade700,
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AssetHelper.image(product.imageFileName),
                            width: 80,
                            height: 80,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6.0,
                            ),
                            child: Text(
                              product.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            height: 4,
                            width: 60,
                            decoration: BoxDecoration(
                              color: _rarityColor(product.rarity),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                // Vạch vàng chỉ định vị trí trúng thưởng
                Positioned(
                  top: 0,
                  bottom: 0,
                  child: Container(width: 4, color: Colors.amberAccent),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 40),

        // NÚT QUAY
        ElevatedButton.icon(
          onPressed: startGacha ? null : _spinGacha,
          icon: const Icon(Icons.cases_rounded),
          label: Text(startGacha ? 'Đang quay...' : 'MỞ HÒM NGAY'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ],
    );
  }
}
