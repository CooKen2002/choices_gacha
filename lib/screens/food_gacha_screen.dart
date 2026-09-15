import 'package:flutter/material.dart';
import 'package:unknow_application/models/product.dart';
import 'package:unknow_application/screens/widget/gacha_loot.dart';
import 'package:unknow_application/utils/asset_helper.dart';  

class FoodGachaScreen extends StatefulWidget {
  const FoodGachaScreen({super.key});

  @override
  State<FoodGachaScreen> createState() => _FoodGachaScreenState();
}

class _FoodGachaScreenState extends State<FoodGachaScreen> {
  // đã xóa: String imagePath = '';   ← không còn cần field này nữa

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
        forceMaterialTransparency: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetHelper.background('hom_nay_an_gi_bg.png')),   // ✅ dùng helper, có bản riêng theo platform
            fit: BoxFit.cover,
          ),
        ),
        child: GachaLootWidget(items: sampleProducts),
      ),
    );
  }
}