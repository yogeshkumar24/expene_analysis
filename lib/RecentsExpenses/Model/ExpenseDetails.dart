import 'package:flutter/material.dart';

class ExpensesDetails{
  Icon icon;
  String expensesName;
  String expensesShort;
  int price;
  bool isApproved;

  ExpensesDetails(this.icon, this.expensesName, this.expensesShort, this.price,
      this.isApproved);

}





List<ExpensesDetails> getExpensesList() {
  List<ExpensesDetails> list2 = List<ExpensesDetails>();
  List<ExpensesDetails> list1 = [];

  list1.add(ExpensesDetails(Icon(Icons.account_circle_outlined), "Design by", "Yogesh Sheroan", 500, true));
  list1.add(ExpensesDetails(Icon(Icons.widgets), "Card", "Card ", 500, true));
  list1.add(ExpensesDetails(Icon(Icons.add_alarm_outlined), "Alarm", "Remainder", 500, true));
  list1.add(ExpensesDetails(Icon(Icons.adb_rounded), "Mobile", "Android", 150000, true));
  list1.add(ExpensesDetails(Icon(Icons.account_tree_outlined), "Remote", "Tv Remote", 120, true));
  list1.add(ExpensesDetails(Icon(Icons.ad_units_outlined), "Glass", "Wine Glass", 450, true));
  list1.add(ExpensesDetails(Icon(Icons.accessible_sharp), "Cycle", "Cycle", 20000, true));
  list1.add(ExpensesDetails(Icon(Icons.account_balance), "Rent", "Room Rent", 10000, true));
  list2.addAll(list1);
  return list2;
}