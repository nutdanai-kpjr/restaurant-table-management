import 'package:flutter/material.dart';
import 'package:restaurant_table_management/components/buttons/primary_button.dart';
import 'package:restaurant_table_management/components/table_Item.dart';
import 'package:restaurant_table_management/domains/table.dart' as domain;
import 'package:restaurant_table_management/pages/checkout_page.dart';
import 'package:restaurant_table_management/pages/create_order_page.dart';
import 'package:restaurant_table_management/services/service.dart';

class TableListTab extends StatelessWidget {
  const TableListTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: TableList()),
      ],
    );
  }
}

class TableList extends StatefulWidget {
  const TableList({Key? key}) : super(key: key);

  @override
  State<TableList> createState() => _TableListState();
}

class _TableListState extends State<TableList> {
  late Future<List<domain.Table>> _getTableList;

  @override
  void initState() {
    super.initState();
    _getTableList = getTableList();
  }

  _refetch() {
    setState(() {
      _getTableList = getTableList();
    });
  }

  _buildTableList() {
    return FutureBuilder(
        future: _getTableList,
        builder: (context, AsyncSnapshot<List<domain.Table>> snapshot) {
          if (snapshot.hasData) {
            var tableList = snapshot.data ?? [];
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                crossAxisCount: 2,
              ),
              itemCount: tableList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var table = tableList[index];

                if (table.status == 'AVAILABLE') {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AvaliableTableItem(
                        tableID: table.id, refresh: _refetch),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InuseTableItem(tableID: table.id, refresh: _refetch),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return _buildTableList();
  }
}
