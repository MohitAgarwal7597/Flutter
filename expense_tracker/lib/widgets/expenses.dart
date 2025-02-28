import 'package:expense_tracker/models/new_expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  void openAddExpenseOverlay() {
    showModalBottomSheet(context: context, builder: (ctx) => NewExpense());
  }

  final List<Expense> _list = [
    Expense(
      title: "Flutter Course",
      amount: 499.00,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: "Movie",
      amount: 300,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Tracker"),
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: openAddExpenseOverlay),
        ],
      ),
      body: Column(
        children: [
          Text("This is chart"),
          Expanded(child: ExpensesList(expenses: _list)),
        ],
      ),
    );
  }
}
