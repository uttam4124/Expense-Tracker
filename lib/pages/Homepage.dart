// import 'dart:js';

import 'package:expense_tracker/components/expense_tile.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/models/expense_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/expense_summary.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final newExpenseNameController = TextEditingController();
  final newExpenseRupeeController = TextEditingController();
  @override
  void initState(){

    super.initState();
    //prepare data on startup
    Provider.of<ExpenseData>(context,listen:false).prepareData();
  }
  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add new Expense'),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          //expense name
          TextField(
            controller: newExpenseNameController,
            decoration: const InputDecoration(
              hintText: " kaha khrcha kiya"
            ),
          ),
          //expense amount
          TextField(
            controller:newExpenseRupeeController ,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: "enter amount "
            ),
          ),
        ]),
        actions: [
          MaterialButton(
            onPressed: save,
            child: Text('save'),
          ),
          MaterialButton(
            onPressed: cancel,
            child: Text('Cancel'),
          )
        ],
      ),
    );
  }
  void deleteExpense(ExpenseItem expense){
    Provider.of<ExpenseData>(context,listen:false).deleteExpense(expense);
  }

  void save() {
    ExpenseItem newExpense = ExpenseItem(
      amount: newExpenseRupeeController.text,
      name: newExpenseNameController.text,
      dateTime: DateTime.now(),
    );
    Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);
    Navigator.pop(context);
    clear();
  }

  void cancel() {}
  void clear() {
    newExpenseNameController.clear();
    newExpenseRupeeController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
          backgroundColor: Colors.grey,
          floatingActionButton: FloatingActionButton(
            onPressed: addNewExpense,
            child: Icon(Icons.add),
          ),
          body: ListView(children: [
            //weekly summary
ExpenseSummary(startOfWeek: value.startOfWeekDate()),
            //expense list
            ListView.builder(

              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.getAllExpenseList().length,
              itemBuilder: (context, index) => ExpenseTile(
                name: value.getAllExpenseList()[index].name,
                amount: value.getAllExpenseList()[index].amount,
                dateTime: value.getAllExpenseList()[index].dateTime,
                deleteTapped:(p0)=>deleteExpense(value.getAllExpenseList()[index])
              ),
            )
          ])),
    );
  }
}
