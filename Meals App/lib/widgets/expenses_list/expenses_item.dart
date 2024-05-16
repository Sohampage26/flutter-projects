import 'package:meals/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(
    this.expense, {
    super.key,
  });
  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 14,
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            expense.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            children: [
              Text(
                '+Rs${expense.amount.toStringAsFixed(2)}',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              const SizedBox(
                width: 180,
              ),
              Row(
                children: [
                  Icon(categoricalIcon[expense.category]),
                  const SizedBox(width: 8),
                  Text(
                    expense.formatedDate,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    ));
  }
}
