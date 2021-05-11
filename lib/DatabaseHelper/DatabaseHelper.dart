import 'package:expene_analysis/RecentsExpenses/Model/expense_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DatabaseHelper{
  DatabaseReference dataRef = FirebaseDatabase.instance.reference();
  final  String DATABASENAME = "Expense";

  Future addExpense(ExpensesInfo expensesModel)async{
    DatabaseReference reference = dataRef.child(DATABASENAME).push();
    expensesModel.id = reference.key;
    await reference.set(expensesModel.toJson());
    print("information saved");

  }

  Future<List<ExpensesInfo>> getExpenseList()async{
    List<ExpensesInfo> expenseList =[];
    var reference = dataRef.child(DATABASENAME);
    DataSnapshot snapshot = await reference.once();

    Map<dynamic,dynamic> map = snapshot.value;

      if(map == null || map.length == 0){
        return [];
      }else{
        map.forEach((key, value) {
          ExpensesInfo model = ExpensesInfo.fromJson(value.cast<String, dynamic>());
          model.id = key;
          expenseList.add(model);

        });
    };
    return expenseList;
  }

  Future deleteItem(String id)async {
    DatabaseReference reference = dataRef.child(DATABASENAME);
    await reference.child(id).remove();
    print("item deleted");
  }
}