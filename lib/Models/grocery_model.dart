class Items {
  final String name;
  final String imageUrl;
  final String descritpion;
  final String price;
  final String productId;
  int quantity; // ✅ NEW: quantity field

  Items({
    required this.name,
    required this.imageUrl,
    required this.descritpion,
    required this.price,
    required this.productId,
    this.quantity = 1, // ✅ default to 1 if not provided
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "imageUrl": imageUrl,
      "descritpion": descritpion,
      "price": price,
      "productId": productId,
      "quantity": quantity, // ✅ include quantity when saving
    };
  }

  factory Items.fromMap(Map<String, dynamic> map) {
    return Items(
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      descritpion: map['descritpion'] ?? '',
      price: map['price'] ?? '',
      productId: map['productId'] ?? '',
      quantity: map['quantity'] ?? 1, // ✅ fetch quantity (default to 1)
    );
  }
}
