import 'package:flutter/material.dart';
import 'package:restaurant_table_management/components/buttons/primary_button.dart';
import 'package:restaurant_table_management/components/buttons/wide_button.dart';
import 'package:restaurant_table_management/components/headers/list_header.dart';
import 'package:restaurant_table_management/components/overview_item.dart';
import 'package:restaurant_table_management/components/secondary_list_item.dart';
import 'package:restaurant_table_management/constants.dart';
import 'package:restaurant_table_management/domains/menu_sales.dart';
import 'package:restaurant_table_management/services/internal_restaurant_service.dart';
import 'package:restaurant_table_management/services/restaurant_service.dart';

import '../components/primary_circular_progress_indicator.dart';

class DashBoardTab extends StatefulWidget {
  const DashBoardTab({Key? key}) : super(key: key);

  @override
  State<DashBoardTab> createState() => _DashBoardTabState();
}

class _DashBoardTabState extends State<DashBoardTab> {
  List<bool> overviewMode = [true, false, false, false];
  List<String> overviewHeaders = [
    'Today',
    'This Week',
    'This Month',
    'All Time'
  ];
  int overviewIndex = 0;

  late Future<List<MenuSales>> _getTopMenus;

  @override
  void initState() {
    super.initState();
    _getTopMenus = getMenuHistory(context: context);
  }

  _refetch() {
    setState(() {
      _getTopMenus = getMenuHistory(context: context);
    });
  }

  _buildSectionWrapper({required title, required child}) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: kHeight(context) * 0.015,
          horizontal: kWidth(context) * 0.05),
      child: Column(children: [
        ListHeader(title: title),
        child,
      ]),
    );
  }

  _buildOverviewModeSelection() {
    return Container(
      margin: EdgeInsets.only(top: kHeight(context) * 0.03),
      child: ToggleButtons(
        renderBorder: false,
        fillColor: Colors.transparent,
        selectedColor: kPrimaryFontColor,
        splashColor: Colors.transparent,
        onPressed: (int index) {
          setState(() {
            for (int buttonIndex = 0;
                buttonIndex < overviewMode.length;
                buttonIndex++) {
              if (buttonIndex == index) {
                overviewMode[buttonIndex] = true;
                overviewIndex = buttonIndex;
              } else {
                overviewMode[buttonIndex] = false;
              }
            }
          });
        },
        isSelected: overviewMode,
        children: <Widget>[
          for (int index = 0; index < overviewMode.length; index++)
            Container(
              margin: EdgeInsets.only(right: kWidth(context) * 0.015),
              child: PrimaryButton(
                text: overviewHeaders[index],
                color: overviewMode[index]
                    ? kThemeColor.withOpacity(0.5)
                    : kBorderColor,
              ),
            ),
        ],
      ),
    );
  }

  _buildOverviewSection() {
    return _buildSectionWrapper(
        title: 'Overview',
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OverviewItem(title: '฿1,258 ', label: 'Revenue'),
            OverviewItem(title: '10 ', label: 'Dishes'),
            OverviewItem(title: '4', label: 'Checkout'),
          ],
        ));
  }

  _buildPopularMenuSection() {
    return _buildSectionWrapper(
      title: 'Most Popular Menu',
      child: FutureBuilder(
          future: _getTopMenus,
          builder: (contextm, AsyncSnapshot<List<MenuSales>> snapshot) {
            if (snapshot.hasData) {
              var topMenus = snapshot.data ?? [];
              return Column(children: [
                SizedBox(height: kHeight(context) * 0.015),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: topMenus.length,
                    itemBuilder: (context, index) {
                      var menuSales = topMenus[index];
                      return SecondaryListItem(
                          title: '${menuSales.menuID}',
                          rightSideChildren: [
                            Text('${menuSales.quantity} Dishes',
                                style: kPrimaryTextStyle)
                          ]);
                    })
              ]);
            } else {
              return const Center(child: PrimaryCircularProgressIndicator());
            }
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(flex: 2, child: _buildOverviewModeSelection()),
        Expanded(flex: 6, child: _buildOverviewSection()),
        Expanded(flex: 11, child: _buildPopularMenuSection()),
        Expanded(
          flex: 2,
          child: WideButton(
            width: double.infinity,
            title: 'Download ${overviewHeaders[overviewIndex]} Report as CSV',
            onPressed: () async {
              await downloadReport('${overviewHeaders[overviewIndex]}');
              // await getMenuHistory(context: context);
              // await getTableList(context: context);
            },
          ),
        ),
      ],
    );
  }
}
