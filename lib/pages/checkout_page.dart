import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_table_management/components/headers/list_header.dart';
import 'package:restaurant_table_management/pages/main_page.dart';

import '../components/buttons/primary_button.dart';
import '../components/buttons/wide_button.dart';
import '../components/headers/Secondary_header.dart';
import '../components/order_detail.dart';
import '../components/primary_circular_progress_indicator.dart';
import '../components/primary_list_item.dart';
import '../components/primary_scaffold.dart';
import '../constants.dart';
import '../domains/member.dart';
import '../domains/order.dart';
import '../domains/orderSummary.dart';
import '../services/member_service.dart';
import '../services/service.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key, required this.tableID}) : super(key: key);
  final String tableID;

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  late Future<OrderSummary> _getCheckoutList;
  late final tableID = widget.tableID;
  String dropdownvalue = 'Cash';
  late OrderSummary orderSummary;
  Member? member;
  @override
  void initState() {
    super.initState();
    _getCheckoutList = getCheckoutOrders(tableID, context: context);
  }

  _refetch() {
    setState(() {
      _getCheckoutList = getCheckoutOrders(tableID, context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
        bottomNavigationBar: Row(
          children: [
            Expanded(
              child: WideButton(
                title: 'Membership',
                backgroundColor: kThemeFontColor,
                fontColor: kPrimaryFontColor,
                textStyle: kAppTitleTextStyle.copyWith(
                  fontSize: kHeaderFontSize,
                ),
                // textStyle:
                onPressed: () async {
                  await _showMembershipDialog(context);
                  _refetch();
                },
              ),
            ),
            Expanded(
              child: WideButton(
                title: 'Confirm',
                onPressed: () {
                  confirmCheckout(widget.tableID, context: context)
                      .then((value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainPage()));
                  });
                },
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.075),
          child: Column(children: [
            SecondaryHeader(
              title: "Checkout",
              tableId: 'Table: ${widget.tableID}',
              time: DateTime.now().toString().substring(0, 16),
            ),
            _buildCheckoutList()
          ]),
        ));
  }

  _buildCheckoutList() {
    return FutureBuilder(
        future: _getCheckoutList,
        builder: (context, AsyncSnapshot<OrderSummary> snapshot) {
          if (snapshot.hasData) {
            orderSummary = snapshot.data ?? OrderSummary.empty();
            List<Order> checkoutOrderList = snapshot.data?.orderList ?? [];
            double totalPrice = snapshot.data?.totalPrice ?? 0;
            double discount = snapshot.data?.discount ?? 0;
            double finalPrice = snapshot.data?.finalPrice ?? 0;

            return Column(children: [
              _buildOrderList(
                list: checkoutOrderList,
                title: 'Order Summary',
              ),
              _buildPaymentSelection(),
              _buildTotalSummary(context,
                  totalPrice: totalPrice,
                  discount: discount,
                  finalPrice: finalPrice)
            ]);
          } else {
            return const Center(child: PrimaryCircularProgressIndicator());
          }
        });
  }

  _buildOrderList({
    required List<Order> list,
    required String title,
  }) {
    return Container(
      margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.015),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        ListHeader(title: title),
        ListView.builder(
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, index) {
            var order = list[index];
            return PrimaryListItem(
                height: 0.06,
                isExapandable: true,
                titleFlex: 7,
                title: order.id,
                subTitle: '',
                rightSizeChildren: [
                  Text(
                    '฿ ${order.price.toString()}',
                    style: kHeaderTextStyle,
                  )
                ],
                indicatorColor: kCompletedColor,
                expandedChild: OrderDetails(
                  order: order,
                ));
          },
        )
      ]),
    );
  }

  _buildPaymentSelection() {
    // List of items in our dropdown menu
    var items = [
      'Cash',
      'Rabbit Pay',
      'ATM',
    ];
    return Container(
      margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.015),
      child: Column(
        children: [
          const ListHeader(title: 'Payment Method'),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
                border: Border.all(color: kBorderColor, width: 2.0),
                borderRadius: BorderRadius.circular(15)),
            width: MediaQuery.of(context).size.width * 0.8,
            child: DropdownButton(
              underline: Container(),
              isExpanded: true,
              // Initial Value
              value: dropdownvalue,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(
                    items,
                    style: kPrimaryTextStyle,
                  ),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
            ),
          ),
          if (dropdownvalue == 'ATM')
            Text('ATM Handler')
          else if (dropdownvalue == 'Rabbit Pay')
            Text('Rabbit Pay Handler')
        ],
      ),
    );
  }

  _buildTotalSummary(BuildContext context,
      {required double totalPrice,
      required double discount,
      required double finalPrice}) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.015,
          horizontal: MediaQuery.of(context).size.width * 0.025),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Sub-Total',
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                style: kPrimaryTextStyle,
              ),
              Text(
                '฿ ${totalPrice.toStringAsFixed(1)}',
                style: kPrimaryTextStyle,
              ),
            ],
          ),
          member != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Discount - ${member?.tier ?? ''}',
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: kPrimaryTextStyle.copyWith(color: kThemeColor),
                    ),
                    Text(
                      '-฿ ${discount.toStringAsFixed(1)}',
                      style: kPrimaryTextStyle.copyWith(color: kThemeColor),
                    ),
                  ],
                )
              : Container(),
          const Divider(
            color: kPrimaryFontColor,
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                style: kHeaderTextStyle.copyWith(fontSize: kAppTitle2FontSize),
              ),
              Text(
                '฿ ${finalPrice.toStringAsFixed(1)}',
                style: kHeaderTextStyle.copyWith(fontSize: kAppTitle2FontSize),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _showMembershipDialog(context) {
    bool isRegister = false;

    String phoneNumber = "";
    TextEditingController firstNameCtrl = TextEditingController();
    TextEditingController lastNameCtrl = TextEditingController();
    TextEditingController emailCtrl = TextEditingController();
    TextEditingController phoneCtrl = TextEditingController();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (context, StateSetter setStateDialog) {
            _onPhoneNumberChanged(value) async {
              if (value.length == 10) {
                var mem = await checkMembership(value, context: context);
                //  if already a member
                setStateDialog(() {
                  if (mem != null) {
                    member = mem;
                    isRegister = false;
                  } else {
                    isRegister = true;
                  }
                  phoneNumber = value;
                });
                //  if not a member -> Set register = true;

              } else if (value.length < 10 && member != null) {
                setStateDialog(() {
                  member = null;
                  isRegister = false;
                });
              }
            }

            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)), //this right here
              child: _buildDialogScrollable(children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  child: Text('Apply Membership',
                      style: kHeaderTextStyle.copyWith(
                          color: kPrimaryFontColor,
                          fontSize: kAppTitle2FontSize)),
                ),
                const Text('Enter customer phone number',
                    style: kPrimaryTextStyle),
                _buildDialogPhoneNumberTextField(
                    onChanged: _onPhoneNumberChanged, textCtrl: phoneCtrl),
                member == null
                    ? PrimaryButton(
                        text: isRegister
                            ? 'Cancel Registeration'
                            : 'Register new',
                        onPressed: () {
                          setStateDialog(() {
                            isRegister = !isRegister;
                          });
                        },
                      )
                    : Column(
                        children: [
                          Text('${member?.tier}: ${member?.fullName}',
                              style: kPrimaryTextStyle),
                          PrimaryButton(
                            text: 'Reset',
                            onPressed: () {
                              setStateDialog(() {
                                phoneCtrl.clear();
                                member = null;
                              });
                            },
                          )
                        ],
                      ),
                const SizedBox(height: 20),
                isRegister
                    ? Column(
                        children: [
                          const Divider(
                            // height: MediaQuery.of(context).size.height * 0.075,
                            color: kPrimaryFontColor,
                            thickness: 1,
                          ),
                          _buildDialogMemberInfoTextField(
                              title: 'Firstname', textCtrl: firstNameCtrl),
                          _buildDialogMemberInfoTextField(
                              title: 'Lastname', textCtrl: lastNameCtrl),
                          _buildDialogMemberInfoTextField(
                              title: 'Email', textCtrl: emailCtrl),
                        ],
                      )
                    : Container(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PrimaryButton(
                      color: kCancelledColor.withOpacity(0.5),
                      text: 'Cancel',
                      onPressed: () {
                        Navigator.maybePop(context);
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    PrimaryButton(
                      color: kCompletedColor.withOpacity(0.5),
                      text: isRegister ? 'Register' : 'Confirm',
                      onPressed: () async {
                        if (isRegister) {
                          await addMember(
                              Member(
                                  phoneNumber: phoneNumber,
                                  firstName: firstNameCtrl.text,
                                  lastName: lastNameCtrl.text,
                                  email: emailCtrl.text),
                              context: context);
                          var mem = await checkMembership(phoneNumber,
                              context: context);
                          //  if already a member
                          setStateDialog(() {
                            if (mem != null) {
                              member = mem;
                              isRegister = false;
                            } else {
                              isRegister = true;
                            }
                          });

                          //cra
                        } else {
                          Navigator.maybePop(context);

                          setState(() {
                            _getCheckoutList = getCheckOutOrdersWithMembership(
                                tableID,
                                phoneNumber: phoneNumber,
                                orderSummary: orderSummary,
                                context: context);
                          });
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.025)
              ]),
            );
          });
        });
  }

  SingleChildScrollView _buildDialogScrollable({required children}) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }

  Padding _buildDialogMemberInfoTextField({required title, textCtrl}) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: textCtrl,
          style: kPrimaryTextStyle,
          keyboardType: TextInputType.text,
          decoration: kTextFieldDecorationWithHintText(title),
        ));
  }

  Padding _buildDialogPhoneNumberTextField({onChanged, textCtrl}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        onChanged: onChanged,
        style: kPrimaryTextStyle,
        controller: textCtrl,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          LengthLimitingTextInputFormatter(10)
        ],
        decoration: kTextFieldDecorationWithHintText('0912345678'),
      ),
    );
  }
}
