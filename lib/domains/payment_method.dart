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
  static const List<String> methodCodeOptions = [
    'CASH',
    'RABBIT_CARD',
    'CREDIT_CARD',
  ];
  bool get isCash => method == "Cash";
  bool get isCreditCard => method == "Credit Card";
  bool get isRabbitCard => method == "Rabbit Card";
  List<String> get methodOptionsList => methodOptions;
  List<String> get methodCodeOptionsList => methodCodeOptions;
  String get toMethodCode {
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

  set fromMethodCode(String methodCode) {
    switch (methodCode) {
      case "CASH":
        method = "Cash";
        break;
      case "RABBIT_CARD":
        method = "Rabbit Card";
        break;
      case "CREDIT_CARD":
        method = "Credit Card";
        break;
      default:
        method = "Cash";
        break;
    }
  }
}
