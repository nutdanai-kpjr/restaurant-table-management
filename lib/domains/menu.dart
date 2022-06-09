// Menu class with following attributes:
//  - id
//  - name
//  - price (integer)
//

class Menu {
  final String id;
  final String name;
  final double price;

  Menu({required this.id, required this.name, required this.price});
  Menu.fromJson(parsedJson)
      : id = parsedJson['menuID'],
        name = parsedJson['name'],
        price = parsedJson['price'] * 1.0;
}
