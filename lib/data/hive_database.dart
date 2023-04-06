import 'package:hive_flutter/hive_flutter.dart';

import '../models/expense_items.dart';

class Hivedatabase {
//refernce our box
  final _myBox = Hive.box("expense_database");
// writing data
  void saveData(List<ExpenseItem> allExpense) {
    List<List<dynamic>> getAllExpensesFormatted = [];
    for (var expense in allExpense) {
      //convert each expense item item into a list of storable types(strings,datetime)
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime,
      ];
      getAllExpensesFormatted.add(expenseFormatted);
    }
    _myBox.put("ALL_EXPENSES", getAllExpensesFormatted);
  }

//reading data
  List<ExpenseItem> readData() {
    /*
Data is stored in Hive as a list of strings +dateTime
so lets convert our saved data into EXpenseitem obejects
savedData=[
 [ name,amount,dateTime],
 ..
]
[
  
[Expenseitem(name/amount>datetime),]
..

]
  */
    List savedExpenses = _myBox.get("ALL_EXPENSES") ?? [];
    List<ExpenseItem> allExpenses = [];
    for (int i = 0; i < savedExpenses.length; i++) {
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];

      ExpenseItem expense =
          ExpenseItem(name: name, amount: amount, dateTime: dateTime);

      allExpenses.add(expense);
    }
    return allExpenses;
  }
}
