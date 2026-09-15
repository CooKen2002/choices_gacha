import 'package:flutter/material.dart';
import 'package:unknow_application/models/product.dart';
import 'package:unknow_application/screens/widget/gacha_loot.dart';

class FoodGachaScreen extends StatefulWidget {
  const FoodGachaScreen({super.key});

  @override
  State<FoodGachaScreen> createState() => _FoodGachaScreenState();
}

class _FoodGachaScreenState extends State<FoodGachaScreen> {
  // 1. Chuẩn bị danh sách sản phẩm mẫu để truyền vào GachaLootWidget
  final List<Product> sampleProducts = [
    const Product(
      name: "Bún chả",
      imageUrl: "assets/images/bun_cha_300x300.png",
      price: 30000,
      rarity: "Common",
      description: "bún chả & thịt",
    ),
    const Product(
      name: "Sashimi",
      imageUrl: "assets/images/sashimi_300x300.png",
      price: 100000,
      rarity: "Exotic",
      description: "SASHIMIIIII",
    ),
    const Product(
      name: "Cơm tấm",
      imageUrl: "assets/images/com_tam_300x300.png",
      price: 60000,
      rarity: "Legendary",
      description: "Sà bì chưởng",
    ),
    const Product(
      name: "Phở gà",
      imageUrl: "assets/images/pho_ga_300x300.png",
      price: 40000,
      rarity: "Rare",
      description: "Chicken",
    ),
    const Product(
      name: "Hàu nướng mỡ hành",
      imageUrl: "assets/images/hau_nuong_mo_hanh_300x300.png",
      price: 50000,
      rarity: "Epic",
      description: "Mlem",
    ),
    const Product(
      name: "Rau muống xào",
      imageUrl: "assets/images/rau_muong_xao_300x300.png",
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
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/hom_nay_an_gi_169.png'),
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
