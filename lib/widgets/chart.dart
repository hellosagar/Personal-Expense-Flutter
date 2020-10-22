import 'package:flutter/material.dart';
import 'package:personal_expenses_app/models/transcation.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transcation> recentTxns;

  Chart({this.recentTxns});

  List<Map<String, Object>> get groupEdValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum;

      for (var txn in recentTxns) {
        if (txn.date.day == weekDay.day &&
            txn.date.month == weekDay.month &&
            txn.date.year == weekDay.year) {
          totalSum += txn.amount;
        }
      }

      return {'day': DateFormat.E(weekDay), 'amount': totalSum};
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[],
          )
        ],
      ),
    );
  }
}
