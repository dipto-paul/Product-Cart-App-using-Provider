class Product {
  final int id;
  final String name;
  final double price;
  final IconType icon;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.icon,
  });
}

enum IconType {
  headphone,
  watch,
  keyboard,
  mouse,
  speaker,
  powerBank,
}