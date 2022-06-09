// Rounded Corner ListItem 
//// Have two part widget of (Title) and widget of (Action)
///  Have boolean to display input indiator on the left side.
///  If isDisplayIndicator then assert to have indicator color.
/// 

/// ListItem Subtype
/// Without Indicator
// 1. CheckoutItem  (MenuName*Quantity | Price) 
// 2. OrderDetailItem 
//      Default (MenuName | Quantity | EditButton)
//      On Edit (MenuName | -Quantity + | ConfrimButton)
// 3. MenuItem
//      Default (MenuName | AddButton)
//      On Edit (MenuName | -Quantity + | ConfrimButton)
/// With Indicator
/// 4. OrderStatusItem
///     Pending (Table Number | CompleteButton , CancelButton, ExpandableButton)
///      -Tap to see order and quantity its
///     Completed (Table Number)
///     Cancelled (Table Number)
///     History (Order Number))
