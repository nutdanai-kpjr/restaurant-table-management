// Use Future Provider
// When open -> watch the orderList from API;
//  Group buy
//  -Pending, Completed, Cancelled, History
// If order == Pending
//  - When user tap on Conmplete button -> read and fire post request to API (update Order Request to Completed);
//  - When user tap on Cancle button -> read and fire post request to API (update Order Request to Cancelled);

//  New Order Button -> read and fire post request to API (create new Order Request);

// _updateOrderStatus(Order order,status) async {
//  final orderId = Order.id
//   final response = await http.post(
// 
// }

// completeOrder(Order order) async {}
// cancelOrder(Order order) async {}


// createOrder(Order order) async {
// new order come from local state.
// include table Id. 
// so fire the request(tableID,order)
// }
