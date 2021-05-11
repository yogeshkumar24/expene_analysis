import 'package:expene_analysis/ExpenseDetails/Page/expense_details_page.dart';
import 'package:expene_analysis/RecentsExpenses/Model/expense_model.dart';
import 'package:expene_analysis/RecentsExpenses/Page/recents_expenses_page.dart';
import 'package:expene_analysis/RecentsExpenses/ScopedModel/expense_viewmodel.dart';
import 'package:expene_analysis/Shared/repostery.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatefulWidget {
  static final String routeName = "HomePage";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int totalSpending = 0;

  TextEditingController itemNameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String selecetdCategory = "Please choose a Category";
  final formKey = GlobalKey<FormState>();
  ExpenseViewModel viewModel;

  @override
  void initState() {
    viewModel = ExpenseViewModel();
    // totalSpendValue();
    viewModel.loadExpenseInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: ScopedModel<ExpenseViewModel>(
        model: viewModel,
        child: ScopedModelDescendant<ExpenseViewModel>(
          builder: (context, child, model) {
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: Size(140, 56),
                child: AppBar(
                  bottom: TabBar(
                    indicatorColor: Colors.purple,
                    unselectedLabelColor: Colors.white60,
                    labelColor: Colors.white,
                    labelPadding: EdgeInsets.all(12),
                    tabs: [
                      Text("DAILY"),
                      Text("WEEKLY"),
                      Text("MONTHLY"),
                    ],
                  ),
                ),
              ),
              body: Form(
                key: formKey,
                child: TabBarView(
                  children: [
                    tabBarView(context),
                    tabBarView(context),
                    tabBarView(context),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget tabBarView(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Text(
                "Total Spending",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "\u20B9 ${totalSpending}",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      print("tapped");
                      bottomSheet(context);
                    },
                    child: CircleAvatar(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.green,
                    ),
                  )
                ],
              )
            ],
          ),
          height: MediaQuery.of(context).size.height / 3.3,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.purple,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.vertical(
                bottom: Radius.elliptical(
                    MediaQuery.of(context).size.width, 150.0)),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.notes),
            Text(
              "Recents Spendings",
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Icon(Icons.where_to_vote_outlined),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Expanded(
          child: viewModel.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SmartRefresher(
                  onRefresh: viewModel.loadExpenseInfo,
                  controller: RefreshController(),
                  child: Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: viewModel.expenseInfoList == null ||
                            viewModel.expenseInfoList.length == 0
                        ? Center(
                            child: Text(
                            "No Expenses Added yet!",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold),
                          ))
                        : expenseListView(),
                  ),
                ),
        ),
      ],
    );
  }

  ListView expenseListView() {
    return ListView.builder(
      itemCount: viewModel.expenseInfoList.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ExpenseDetails(
                        expenseModel: viewModel.expenseInfoList[index],
                      )),
            );
          },
          child: RecentsExpensesPage(viewModel.expenseInfoList[index]),
        );
      },
    );
  }

  void bottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                    top: Radius.elliptical(
                        MediaQuery.of(context).size.width, 150.0)),
              ),
              padding: EdgeInsets.only(top: 1, bottom: 30, right: 30, left: 30),
              height: MediaQuery.of(context).size.height / 1.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      buttons("Save", () async {
                        await addExpense();

                        Navigator.of(context).pop();
                      }),
                    ],
                  ),
                  textFormField(itemNameController, "Enter Item Name",
                      Icon(Icons.category)),
                  textFormField(amountController, "Enter Amount",
                      Icon(Icons.monetization_on_outlined),
                      isAmount: true),
                  Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.category),
                          SizedBox(
                            width: 10,
                          ),
                          DropdownButton(
                              // isExpanded: true,
                              hint: Text('Please Choose a Category'),
                              // Not necessary for Option 1
                              value: selecetdCategory,
                              onChanged: (newValue) {
                                setState(() {
                                  selecetdCategory = newValue;
                                });
                              },
                              items: ExpenseMainRepo()
                                  .categoryList
                                  .map((category) {
                                return DropdownMenuItem(
                                  child: new Text(category),
                                  value: category,
                                );
                              }).toList()),
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.black26,
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.date_range),
                              hintText: DateFormat('yyyy-MM-dd')
                                  .format(selectedDate))),
                    ),
                  ),
                  textFormField(notesController, "Add Notes (Optional)",
                      Icon(Icons.note_sharp),
                      isNotes: true),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future addExpense() async {
    if (formKey.currentState.validate()) {
      String itemName = itemNameController.text;
      String amount = amountController.text;
      String notes = notesController.text;
      String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

      ExpensesInfo expensesInfo = ExpensesInfo(
        itemName: itemName,
        amount: int.parse(amount),
        category: selecetdCategory,
        date: formattedDate,
        notes: notes,
      );
      await viewModel.addExpense(expensesInfo);
    } else {
      print("enter a value =================");
    }
  }

  Widget textFormField(
      TextEditingController controller, String hintText, Icon icon,
      {bool isAmount = false, isNotes = false}) {
    return TextFormField(
        validator: (value) {
          if (value != null) {
            return null;
          } else {
            return "Please Enter Value";
          }
        },
        keyboardType:
            isAmount != true ? TextInputType.text : TextInputType.number,
        controller: controller,
        textInputAction:
            isNotes != true ? TextInputAction.next : TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: icon,
          hintText: hintText,
        ));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  RaisedButton buttons(name, press) {
    return RaisedButton(
        onPressed: press,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          child: Text(
            name,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)));
  }
}
