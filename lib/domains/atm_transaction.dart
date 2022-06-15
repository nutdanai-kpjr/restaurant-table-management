const String shopAccountNumber = "aa";

class ATMTransaction {
  final String atmId;
  final String atmPass;
  final String receiverAccountNumber;
  final double amount;

  ATMTransaction(
      {required this.atmId,
      required this.atmPass,
      this.receiverAccountNumber = shopAccountNumber,
      required this.amount});

  Map<String, dynamic> toJson() => {
        'atmId': atmId,
        'rabbitPass': atmPass,
        'amount': amount,
        'shopAccountNumber': shopAccountNumber,
      };
}
