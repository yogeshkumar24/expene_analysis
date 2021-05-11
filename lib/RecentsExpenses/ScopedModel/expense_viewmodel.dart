import 'package:expene_analysis/RecentsExpenses/Model/expense_model.dart';
import 'package:expene_analysis/Shared/repostery.dart';
import 'package:scoped_model/scoped_model.dart';

class ExpenseViewModel extends Model {
  ExpenseMainRepo repo = ExpenseMainRepo();
  List<ExpensesInfo> expenseInfoList = [];
  bool isLoading = false;

  ExpenseViewModel() {
    init();
  }

  Future init() async {
    await loadExpenseInfo();
  }

  Future addExpense(ExpensesInfo expensesModel) async {
    await repo.addExpense(expensesModel);
    expenseInfoList.add(expensesModel);
    notifyListeners();
  }

  loadExpenseInfo() async {
    isLoading = true;
    notifyListeners();
    expenseInfoList = await repo.getExpenseList();
    isLoading = false;
    notifyListeners();
  }
}
