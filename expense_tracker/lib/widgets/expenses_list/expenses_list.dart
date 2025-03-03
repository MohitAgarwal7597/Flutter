import 'package:expense_tracker/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> expenses;
  final Function(Expense expense) removeExpense;
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.removeExpense,
  });
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder:
          (context, index) => Dismissible(
            background: ClipRRect(
              // borderRadius: BorderRadius.circular(40),
              child: Container(
                alignment: Alignment.centerRight,
                // color: Theme.of(context).colorScheme.error, can be used to give only red color when expense is deleted
                margin: EdgeInsets.symmetric(
                  horizontal: Theme.of(context).cardTheme.margin!.horizontal,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    // begin: Alignment.topLeft,
                    // end: Alignment.bottomRight,
                    colors: [
                      const Color.fromARGB(255, 247, 0, 0),
                      Colors.orange,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            onDismissed: (direction) => removeExpense(expenses[index]),
            key: ValueKey(expenses[index]),
            child: ExpensesItem(expenses[index]),
          ),
    );
  }
}
