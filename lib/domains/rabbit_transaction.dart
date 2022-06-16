const String restaurantRabbitID = "SHOP222222";

class RabbitTransaction {
  final String rabbitID;
  final String rabbitPass;
  final String rabbitShopIDReceive;
  final double amount;

  RabbitTransaction(
      {required this.rabbitID,
      required this.rabbitPass,
      this.rabbitShopIDReceive = restaurantRabbitID,
      required this.amount});

  Map<String, dynamic> toJson() => {
        'rabbitID': rabbitID,
        'rabbitPass': rabbitPass,
        'amount': amount,
        'rabbitShopIDReceive': rabbitShopIDReceive,
      };
}
