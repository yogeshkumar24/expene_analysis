import 'package:expene_analysis/DatabaseHelper/DatabaseHelper.dart';
import 'package:expene_analysis/RecentsExpenses/Model/expense_model.dart';

class ExpenseMainRepo {
  ExpenseMainRepo._privateConstructor();

  static final ExpenseMainRepo _instance = ExpenseMainRepo._privateConstructor();

  factory ExpenseMainRepo() {
    return _instance;
  }

  DatabaseHelper dbHelper = DatabaseHelper();

  Future addExpense(ExpensesInfo expensesModel) async {
    await dbHelper.addExpense(expensesModel);
  }

  Future<List<ExpensesInfo>> getExpenseList() async {
    List<ExpensesInfo> list = await DatabaseHelper().getExpenseList();
    return list;
  }

  Future deleteItem(String id) async {
    await DatabaseHelper().deleteItem(id);
  }

  List<String> categoryList = [
    "Please choose a Category",
    "Rent",
    "Transportation",
    "Groceries",
    "Home and utilities",
    "Insurance",
    "Bills & emis",
    "Education",
    "Health and personal care",
    "Shopping and entertainment",
    "Food and dining",
    "Travel",
    "Memberships",
    "Others"
  ];
}
