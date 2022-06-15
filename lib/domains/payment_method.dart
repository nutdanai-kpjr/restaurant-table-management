class PaymentMethod {
  PaymentMethod() : method = "Cash";
  PaymentMethod.empty() : method = "Cash";
  PaymentMethod.fromJson(Map<String, dynamic> parsedJson)
      : method = parsedJson['method'];
  Map<String, dynamic> toJson() => {'method': method};
  String method;
  static const List<String> methodOptions = [
    'Cash',
    'Rabbit Card',
    'Credit Card',
  ];
  bool get isCash => method == "Cash";
  bool get isCreditCard => method == "Credit Card";
  bool get isRabbitCard => method == "Rabbit Card";
  List<String> get methodOptionsList => methodOptions;

  String get methodCode {
    switch (method) {
      case "Cash":
        return "CASH";
      case "Rabbit Card":
        return "RABBIT_CARD";
      case "Credit Card":
        return "CREDIT_CARD";
      default:
        return "CASH";
    }
  }
}
