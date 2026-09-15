import 'package:flutter/material.dart';
import 'package:unknow_application/models/product.dart';
import 'package:unknow_application/screens/widget/gacha_loot.dart';
import 'package:unknow_application/utils/asset_helper.dart';


class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  // 1. Chuẩn bị danh sách sản phẩm mẫu để truyền vào GachaLootWidget
  String imagePath = '';
  final List<Product> sampleProducts = [
    const Product(
      name: "Bún chả",
      imageFileName: "bun_cha_300x300.png",
      price: 30000,
      rarity: "Common",
      description: "bún chả & thịt",
    ),
    const Product(
      name: "Sashimi",
      imageFileName: "sashimi_300x300.png",
      price: 100000,
      rarity: "Exotic",
      description: "SASHIMIIIII",
    ),
    const Product(
      name: "Cơm tấm",
      imageFileName: "com_tam_300x300.png",
      price: 60000,
      rarity: "Legendary",
      description: "Sà bì chưởng",
    ),
    const Product(
      name: "Phở gà",
      imageFileName: "pho_ga_300x300.png",
      price: 40000,
      rarity: "Rare",
      description: "Chicken",
    ),
    const Product(
      name: "Hàu nướng mỡ hành",
      imageFileName: "hau_nuong_mo_hanh_300x300.png",
      price: 50000,
      rarity: "Epic",
      description: "Mlem",
    ),
    const Product(
      name: "Rau muống xào",
      imageFileName: "rau_muong_xao_300x300.png",
      price: 30000,
      rarity: "Uncommon",
      description: "Nhậu thôi",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Translucent appbar
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ), // Icon back về home
        backgroundColor: Colors.transparent,
        elevation: 0,
        forceMaterialTransparency: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetHelper.background('hom_nay_an_gi_bg.png')), 
            fit: BoxFit.cover, // Fills the entire screen
          ),
        ),
        // 2. Chèn GachaLootWidget vào đây (bọc trong SafeArea hoặc trực tiếp)
        child: GachaLootWidget(
          items: sampleProducts, // Truyền danh sách sản phẩm ở trên vào
        ),
      ),
    );
  }
}