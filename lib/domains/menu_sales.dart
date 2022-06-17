class MenuSales {
  final String menuID;
  final int quantity;
  final String name;
  MenuSales({required this.menuID, required this.quantity, required this.name});
  factory MenuSales.fromJson(Map<String, dynamic> json) {
    return MenuSales(
      menuID: json['menuID'],
      quantity: json['quantity'],
      name: json['name'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'menuID': menuID,
      'quantity': quantity,
      'name': name,
    };
  }
}
