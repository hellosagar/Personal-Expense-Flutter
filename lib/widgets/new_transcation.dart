import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTranscation extends StatefulWidget {
  final Function addUserTranscation;

  NewTranscation(this.addUserTranscation);

  @override
  _NewTranscationState createState() => _NewTranscationState();
}

class _NewTranscationState extends State<NewTranscation> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    final title = _titleController.text;
    final amount = double.parse(_amountController.text);

    if (title.isEmpty || amount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addUserTranscation(title, amount, _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          _selectedDate = pickedDate;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              controller: _titleController,
              onChanged: (value) {},
              decoration: InputDecoration(labelText: 'Enter Title'),
            ),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Enter Amount'),
              keyboardType: TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              onSubmitted: (_) => _submitData,
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(_selectedDate == null
                        ? 'Choose Date!'
                        : 'Picked Date: ' +
                            DateFormat.yMd().format(_selectedDate)),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      _presentDatePicker(context);
                    },
                    child: Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            FlatButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                _submitData();
                print('${_titleController.text} ${_amountController.text}');
              },
              child: Text(
                'Add Transcation',
                style: TextStyle(
                  color: Theme.of(context).textTheme.button.color,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
