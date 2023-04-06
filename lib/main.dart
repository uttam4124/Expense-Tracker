import 'package:expense_tracker/pages/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'data/expense_data.dart';
void main()async{
  // initialoze hive 
  await Hive.initFlutter();
  //open hive box
 await Hive.openBox("Expense_database") ;

  
 
  runApp(const MyApp() );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create:(context)=>ExpenseData(),
    builder:(context,child)=>const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
    );
  }
}