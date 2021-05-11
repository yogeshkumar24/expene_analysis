import 'package:expene_analysis/RecentsExpenses/Model/ExpenseDetails.dart';
import 'package:expene_analysis/RecentsExpenses/Model/expense_model.dart';
import 'package:flutter/material.dart';

class RecentsExpensesPage extends StatelessWidget {

ExpensesInfo _expensesDetails;

  RecentsExpensesPage(this._expensesDetails);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
        child: buildCard(),
      ),
    );
  }

  Card buildCard() {
    return Card(
        elevation: 2,
        child: Row(
          children: [
            SizedBox(
              width: 30,
            ),
            CircleAvatar(child: Image.asset("assets/images/expenseReport.png"),),
            SizedBox(
              width: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _expensesDetails.itemName,
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  // _expensesDetails.date,
                  "Today",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "\u20B9 ${_expensesDetails.amount}",
                  style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                // Text(
                //     _expensesDetails.isApproved == true ? "Approved": "Not Approved",
                //   style: TextStyle(
                //       color: Colors.black54,
                //       fontSize: 10,
                //       fontWeight: FontWeight.bold),
                // ),
              ],
            ),
            SizedBox(
              width: 30,
            )
          ],
        ),
      );
  }


}
