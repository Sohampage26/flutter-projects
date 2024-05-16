import 'package:meals/widgets/chart/chart.dart';
import 'package:meals/widgets/expenses_list/expenses_list.dart';
import 'package:meals/models/expense.dart';
import 'package:meals/widgets/new_expense.dart';
import 'package:flutter/material.dart';
class Expenses extends StatefulWidget{
 const  Expenses({super.key});
  @override
  State<Expenses> createState() {
    return Expenses2();
  }
}
class Expenses2 extends  State<Expenses>{
  final List<Expense> _registeredExpense = [
    Expense(title: 'Buying Game', amount: 24.44, date: DateTime.now(), category: Category.game,),
    Expense(title: 'Trip', amount: 30.22, date: DateTime.now(), category: Category.travel),
  ];
  void _openAddExpenseOverlay(){
    showModalBottomSheet(
    isScrollControlled: true,  
    context: context, 
    builder: (ctx)=>NewExpense(onAddExpense: _saveExpense,));
  }
  void _saveExpense(Expense expense){
    setState(() {
      _registeredExpense.add(expense);
    });
  }
  void _removeExpense(Expense expense){
    setState(() {
      _registeredExpense.remove(expense);
    });
  }
  @override
  Widget build(context){
    return   Scaffold(
      appBar: AppBar(
         title:  const Text('Flutter Expense'),
        actions: [
        IconButton(onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add)),  
      ],),
      body: Column(
        children: [
          Chart(expenses: _registeredExpense),
          Expanded(child: ExpensesList(expenses: _registeredExpense,onRemoveExpense: _removeExpense,)),
        ],
      ),
    );
  }
}