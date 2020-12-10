import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputArea extends StatefulWidget {

  final Function addTransactionToList;

  InputArea(this.addTransactionToList);

  @override
  _InputAreaState createState() => _InputAreaState();
}

class _InputAreaState extends State<InputArea> {

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime date;

  void _submitInput() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || date == null) {
      return;
    }
    widget.addTransactionToList(enteredTitle, enteredAmount, date);

    Navigator.of(context).pop();
  }

  void presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        date = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      child: SingleChildScrollView(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: titleController,
                  keyboardType: TextInputType.text,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) {
                    _submitInput();
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(child: Text(date == null ? 'No Date Chosen' : date.toString())),
                    RaisedButton(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Pick Date',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      onPressed: presentDatePicker,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
                RaisedButton(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Add Transaction',
                    style:
                        TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    _submitInput();
                  },
                  color: Theme.of(context).primaryColor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
