const String shopAccountNumber = "2243574734";

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
        'atmID': atmId,
        'pin': atmPin,
        'toAccountNumber': shopAccountNumber,
        'amount': amount,
      };
}
