// Header
// 1 List of Menu Items
// Local List<Menu>
// Wide Button : Total Item: 5

// Stateful
// On MenuITem Button
import 'package:flutter/material.dart';
import 'package:restaurant_table_management/components/buttons/primary_button.dart';
import 'package:restaurant_table_management/components/buttons/wide_button.dart';
import 'package:restaurant_table_management/components/headers/secondary_header.dart';
import 'package:restaurant_table_management/components/primary_scaffold.dart';
import 'package:restaurant_table_management/components/secondary_list_item.dart';
import 'package:restaurant_table_management/domains/menu.dart';

import 'package:restaurant_table_management/pages/confirm_order_page.dart';
import 'package:restaurant_table_management/services/services.dart';

/// // On Add Item (Display Edit Quantity Mode in Menuitem))
// // On Edit Item (Display Edit Quantity Mode in Menuitem))
//  // On Confrim Item (Add or Remove Item with given amount to Local List )
// On Total Item  Button
//    Push to Confirm Order Page (With Local List)
//   - If user press pop (backbutton) .then (setStaet from Confrim Local List
//    to Create Order Local List)

class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({Key? key, required this.tableID}) : super(key: key);
  final String tableID;
  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  Map<String, int> selectedMenusQuantity = {};

  _routeToConfrimOrderPage() {
    Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConfirmOrderPage(
                    selectedMenusQuantity: selectedMenusQuantity)))
        .then((newSelectedMenusQuantity) {
      setState(() {
        selectedMenusQuantity = newSelectedMenusQuantity;
      });
    });
  }

  int countSelectedMenus() {
    int sum = 0;
    for (var key in selectedMenusQuantity.keys) {
      sum += selectedMenusQuantity[key] ?? 0;
    }
    return sum;
  }

  void _updateSelectedMenusQuantity(newValue) {
    setState(() {
      selectedMenusQuantity = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
        bottomNavigationBar: WideButton(
          title: 'Total Item: ${countSelectedMenus()}',
          onPressed: () {
            _routeToConfrimOrderPage();
          },
        ),
        body: Column(children: [
          SecondaryHeader(
            title: "New Order",
            tableId: 'T001',
            time: '3 Jun | 14.00',
          ),
          MenuList(
            selectedMenusQuantity: selectedMenusQuantity,
            onUpdateSelectedMenusQuantity: _updateSelectedMenusQuantity,
          )
        ]));
  }
}

class MenuList extends StatefulWidget {
  const MenuList(
      {Key? key,
      required this.selectedMenusQuantity,
      required this.onUpdateSelectedMenusQuantity,
      this.showSelectedOnly = false})
      : super(key: key);
  final Map<String, int> selectedMenusQuantity;
  final Function(Map<String, int>) onUpdateSelectedMenusQuantity;
  final bool showSelectedOnly;
  @override
  State<MenuList> createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  late Future<List<Menu>> _getMenus;
  late Map<String, int> selectedMenusQuantity;
  late Function(Map<String, int>) onUpdateSelectedMenusQuantity;
  late bool showSelectedOnly;
  @override
  void initState() {
    super.initState();
    _getMenus = getMenus();
    showSelectedOnly = widget.showSelectedOnly;
    selectedMenusQuantity = widget.selectedMenusQuantity;
    onUpdateSelectedMenusQuantity = widget.onUpdateSelectedMenusQuantity;
  }

  _buildMenuList() {
    return FutureBuilder(
        future: _getMenus,
        builder: (context, AsyncSnapshot<List<Menu>> snapshot) {
          if (snapshot.hasData) {
            var menuList = snapshot.data ?? [];

            return Column(children: [
              Text("Menu"),
              ListView.builder(
                shrinkWrap: true,
                itemCount: menuList.length,
                itemBuilder: (context, index) {
                  var menu = menuList[index];
                  if (showSelectedOnly) {
                    if (selectedMenusQuantity[menu.id] != null) {
                      return SecondaryListItem(
                        title: menu.name,
                        buttons: [
                          MenuButton(
                            quantity: selectedMenusQuantity[menu.id] ?? 0,
                            onQuantityChanged: (int quantity) {
                              setState(() {
                                selectedMenusQuantity[menu.id] = quantity;
                              });
                              onUpdateSelectedMenusQuantity(
                                  selectedMenusQuantity);
                            },
                          )
                        ],
                      );
                    } else
                      return Container();
                  } else {
                    return SecondaryListItem(
                      title: menu.name,
                      buttons: [
                        MenuButton(
                          onQuantityChanged: (int quantity) {
                            setState(() {
                              selectedMenusQuantity[menu.id] = quantity;
                            });
                            onUpdateSelectedMenusQuantity(
                                selectedMenusQuantity);
                          },
                        )
                      ],
                    );
                  }
                },
              )
            ]);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return _buildMenuList();
  }
}
