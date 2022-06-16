class MenuSales {
  final String menuID;
  final int quantity;
  MenuSales({required this.menuID, required this.quantity});
  factory MenuSales.fromJson(Map<String, dynamic> json) {
    return MenuSales(
      menuID: json['menuID'],
      quantity: json['quantity'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'menuID': menuID,
      'quantity': quantity,
    };
  }
}
