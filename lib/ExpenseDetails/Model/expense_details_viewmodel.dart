import 'package:expene_analysis/Shared/repostery.dart';
import 'package:scoped_model/scoped_model.dart';

class ExpenseDetailsViewModel extends Model{

  ExpenseMainRepo repo = ExpenseMainRepo();

  Future deleteItem(String id)async{
    await repo.deleteItem(id);
  }

}