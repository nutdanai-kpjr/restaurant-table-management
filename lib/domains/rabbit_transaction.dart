const String restaurantRabbitID = "SHOP222222";

class RabbitTransaction {
  final String rabbitID;
  final String rabitPass;
  final String rabbitShopIDReceive;
  final double amount;

  RabbitTransaction(
      {required this.rabbitID,
      required this.rabitPass,
      this.rabbitShopIDReceive = restaurantRabbitID,
      required this.amount});

  Map<String, dynamic> toJson() => {
        'rabbitID': rabbitID,
        'rabbitPass': rabitPass,
        'amount': amount,
        'rabbitShopIDReceive': rabbitShopIDReceive,
      };
}
