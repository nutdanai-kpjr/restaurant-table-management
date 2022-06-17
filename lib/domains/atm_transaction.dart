const String shopAccountNumber = "7193390730";

class ATMTransaction {
  final String atmId;
  final String atmPin;
  final String toAccountNumber;
  final double amount;

  ATMTransaction(
      {required this.atmId,
      required this.atmPin,
      this.toAccountNumber = shopAccountNumber,
      required this.amount});

  Map<String, dynamic> toJson() => {
        'atmId': atmId,
        'pin': atmPin,
        'amount': amount,
        'toAccountNumber': shopAccountNumber,
      };
}
