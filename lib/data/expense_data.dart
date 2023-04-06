import 'dart:core';
import 'package:expense_tracker/data/hive_database.dart';
import 'package:flutter/material.dart';

import '../models/expense_items.dart';
import 'datetime/date_time_helper.dart';

class ExpenseData extends ChangeNotifier{
  //list of all expenses
  List<ExpenseItem>overallExpensesList=[];
  //get expense list
  List<ExpenseItem>   getAllExpenseList(){
    return overallExpensesList;
  }

  //prepare to display data 
  final db=Hivedatabase();
  void prepareData(){
    //if there exists data get it
    
    if(db.readData().isNotEmpty){
      overallExpensesList=db.readData();
    }
  }
  //add  new expense
  void addNewExpense(ExpenseItem newExpense){
    overallExpensesList.add(newExpense);
    notifyListeners();
    db.saveData(overallExpensesList);
  }
  // delete expense
  void deleteExpense(ExpenseItem expense){
    overallExpensesList.remove(expense);
    notifyListeners();
    db.saveData(overallExpensesList);
  }
  // get weekday(mon ,tue) from a datetime objet 
  String getDayName(DateTime dateTime){
    switch(dateTime.weekday){
case 1:return 'Mon';
case 2:return 'Tue';
case 3:return 'wed';
case 4:return 'thurs';
case 5:return 'friday';
case 6:return 'Sat';
case 7:return 'Sun';
default:
return '';
    }
  }
  // date for the start of the week(sunday)
DateTime startOfWeekDate(){
DateTime?startOfWeek;

DateTime today=DateTime.now();
for(int i=0;i<7;i++){
  if(getDayName(today.subtract(Duration(days:i)))=='Sun'){
startOfWeek=today.subtract(Duration(days: i));
  }
}
return startOfWeek!;
}
Map<String,double>calculateDailyExpenseSummary(){
Map<String,double>dailyExpenseSummary={

}; 
for(var expense in overallExpensesList){
  String date=convertDateTimeToString(expense.dateTime);
  double amount=double.parse(expense.amount);
  if(dailyExpenseSummary.containsKey(date)){
    double currentAmount=dailyExpenseSummary[date]!;
    currentAmount+=amount; 
    dailyExpenseSummary[date]=currentAmount;
  }
  else{
    dailyExpenseSummary.addAll({date:amount});
  }
}
return dailyExpenseSummary;
}
}   