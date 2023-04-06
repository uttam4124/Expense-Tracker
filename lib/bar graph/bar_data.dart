import 'package:expense_tracker/bar%20graph/individual_bar.dart';

class BarData{
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thursAmount;
  final double fridAmount;
  final double satAmount;
  
  BarData({
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thursAmount,
    required this.fridAmount,
    required this.satAmount,
    required this.sunAmount,
  });
  List<IndividualBar>barData=[];
  void initializeBarData(){
    barData=[
      
      IndividualBar(x: 0, y: sunAmount),
      IndividualBar(x: 1, y: monAmount),
      IndividualBar(x: 2, y: tueAmount),
      IndividualBar(x: 3, y: wedAmount),
      IndividualBar(x: 4, y: thursAmount),
      IndividualBar(x: 5, y: fridAmount),
      IndividualBar(x: 6, y: satAmount),
      
    ];
  }
}