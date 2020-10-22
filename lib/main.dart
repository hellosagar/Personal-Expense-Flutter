import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './widgets/new_transcation.dart';
import './widgets/transcation_list.dart';
import './widgets/chart.dart';
import 'models/transcation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Personal Expenses",
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          errorColor: Colors.red,
          fontFamily: 'QuickSand',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                button: TextStyle(
                  color: Colors.white,
                ),
              ),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                      headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                  )))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transcation> _userTranscations = [
    // Transcation(
    //   id: 't1',
    //   amount: 69.99,
    //   title: 'New Shoes',
    //   date: DateTime.now(),
    // ),
    // Transcation(
    //   id: 't21',
    //   amount: 25.99,
    //   title: 'T-Shirt',
    //   date: DateTime.now(),
    // ),
  ];

  List<Transcation> get _recentTranscations {
    return _userTranscations.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTranscation(
      String txTitle, double txAmount, DateTime pickedDate) {
    final newTxn = Transcation(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: pickedDate,
    );

    setState(() {
      _userTranscations.add(newTxn);
    });
  }

  void _deleteTranscation(String id) {
    setState(() {
      _userTranscations.removeWhere((txn) => txn.id == id);
    });
  }

  void _startAddNewTranscation(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return GestureDetector(
            onTap: () {},
            child: NewTranscation(_addNewTranscation),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Personal Expenses",
          style: TextStyle(fontFamily: 'Open Sans'),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTranscation(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Chart(
              recentTxns: _recentTranscations,
            ),
            TranscationList(_userTranscations, _deleteTranscation),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTranscation(context),
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
