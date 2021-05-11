import 'dart:ui';

import 'package:expene_analysis/ExpenseDetails/Model/expense_details_viewmodel.dart';
import 'package:expene_analysis/RecentsExpenses/Model/expense_model.dart';
import 'package:expene_analysis/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scoped_model/scoped_model.dart';

class ExpenseDetails extends StatefulWidget {
  static final String routeName = "ExpenseDetailsPage";

  final ExpensesInfo expenseModel;

  ExpenseDetails({this.expenseModel});

  @override
  _ExpenseDetailsState createState() => _ExpenseDetailsState();
}

class _ExpenseDetailsState extends State<ExpenseDetails> {
  ExpenseDetailsViewModel expenseDetailsViewModel;

  @override
  void initState() {
    expenseDetailsViewModel = ExpenseDetailsViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ExpenseDetailsViewModel>(
      model: expenseDetailsViewModel,
      child: ScopedModelDescendant<ExpenseDetailsViewModel>(
        builder: (context, child, viewModel) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Details"),
              actions: [
                Row(
                  children: [
                    Icon(Icons.edit),
                    SizedBox(width: 20),
                    InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    "Delete",
                                  ),
                                  titleTextStyle: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                  content: Text(
                                      "Are you sure, do you want to delete ?"),
                                  actions: [
                                    FlatButton(
                                      child: Text(
                                        "Cancel",
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    FlatButton(
                                      child: Text("Delete"),
                                      onPressed: () async {
                                        await viewModel
                                            .deleteItem(widget.expenseModel.id);
                                        Navigator.of(context).popAndPushNamed(
                                            HomePage.routeName);
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                        child: Icon(Icons.delete)),
                    SizedBox(width: 10),
                  ],
                ),
                SizedBox(width: 10),
              ],
            ),
            body: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  color: Theme.of(context).primaryColor,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 1.4,
                      child: Card(
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "\u20B9 ${widget.expenseModel.amount}.0",
                                    style: TextStyle(
                                        fontSize: 32,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              buildRow(
                                  "Item Name", widget.expenseModel.itemName),
                              SizedBox(
                                height: 32,
                              ),
                              buildRow(
                                  "Category", widget.expenseModel.category),
                              SizedBox(
                                height: 32,
                              ),
                              buildRow("Date", widget.expenseModel.date),
                              SizedBox(
                                height: 32,
                              ),
                              widget.expenseModel.notes.isNotEmpty
                                  ? buildRow("Notes", widget.expenseModel.notes,
                                      isNotes: true)
                                  : buildRow("Notes", "No Notes Found"),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: RaisedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Back",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildRow(String key, String value, {bool isNotes = false}) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 10),
      child: Container(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              key,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 20,
            ),
            Wrap(
              children: [
                Text(
                  value,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                  maxLines: isNotes == true ? 3 : 1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
