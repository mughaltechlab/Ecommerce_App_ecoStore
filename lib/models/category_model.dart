class CategoryModel {
  String? title;
  String? icon;

  CategoryModel({
    required this.title,
    this.icon,
  });
}

List<CategoryModel> categories = [
  CategoryModel(title: "FASHION", icon: "assets/icons/branding.png"),
  CategoryModel(title: "CLOTHING", icon: "assets/icons/clothing.png"),
  CategoryModel(title: "COSMETICS", icon: "assets/icons/cosmetic.png"),
  CategoryModel(title: "ELECTRONICS", icon: "assets/icons/electronics.png"),
  CategoryModel(title: "SKIN & CARE", icon: "assets/icons/skincare.png"),
  CategoryModel(title: "HOUSEHOLD ITEMS", icon: "assets/icons/lamp.png"),
  CategoryModel(title: "FURNITURE & DECOR", icon: "assets/icons/kitchen.png"),
  CategoryModel(title: "JEWELRY", icon: "assets/icons/jewelry.png"),
];
