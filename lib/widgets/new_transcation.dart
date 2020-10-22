import 'package:flutter/material.dart';

class NewTranscation extends StatefulWidget {
  final Function addUserTranscation;

  NewTranscation(this.addUserTranscation);

  @override
  _NewTranscationState createState() => _NewTranscationState();
}

class _NewTranscationState extends State<NewTranscation> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final title = titleController.text;
    final amount = double.parse(amountController.text);

    if (title.isEmpty || amount <= 0) {
      return;
    }

    widget.addUserTranscation(title, amount);

    Navigator.of(context).pop();
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
              controller: titleController,
              onChanged: (value) {},
              decoration: InputDecoration(labelText: 'Enter Title'),
            ),
            TextField(
              controller: amountController,
              decoration: InputDecoration(labelText: 'Enter Amount'),
              keyboardType: TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              onSubmitted: (_) => submitData,
            ),
            FlatButton(
              onPressed: () {
                submitData();
                print('${titleController.text} ${amountController.text}');
              },
              child: Text(
                'Add Transcation',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
