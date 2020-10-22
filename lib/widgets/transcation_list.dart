import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transcation.dart';

class TranscationList extends StatelessWidget {
  final List<Transcation> transcations;
  final Function deleteTranscation;

  TranscationList(this.transcations, this.deleteTranscation);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transcations.isEmpty
          ? Column(
              children: [
                Text(
                  'No Trascations added yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 8,
                  ),
                  elevation: 4,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text('\$${transcations[index].amount}'),
                        ),
                      ),
                    ),
                    title: Text('${transcations[index].title}'),
                    subtitle: Text(
                      '${DateFormat.yMMMd().format(transcations[index].date)}',
                    ),
                    trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Theme.of(context).errorColor,
                        ),
                        onPressed: () {
                          deleteTranscation(transcations[index].id);
                        }),
                  ),
                );
              },
              itemCount: transcations.length,
            ),
    );
  }
}
