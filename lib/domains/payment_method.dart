class PaymentMethod {
  PaymentMethod() : method = "Cash";
  PaymentMethod.fromJson(Map<String, dynamic> parsedJson)
      : method = parsedJson['method'];
  Map<String, dynamic> toJson() => {'method': method};
  String method;
  static const List<String> methodOptions = [
    'Cash',
    'Rabbit Pay',
    'ATM',
  ];
  bool get isCash => method == "Cash";
  bool get isATM => method == "ATM";
  bool get isRabbitCard => method == "Rabbit Pay";
  List<String> get methodOptionsList => methodOptions;
}
