import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widget/txCard.dart';

import '../model/transaction_model.dart';

class TransactionArea extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionArea({this.transactions, this.deleteTx});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints){
            return Column(
              children: <Widget>[
                Text(
                  'No transactions yet!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Container(
                    height: constraints.maxHeight *.6,
                    margin: EdgeInsets.all(20),
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    )),
              ],
            );
      },)
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: transactions.map((tx) {
                    return TxCard(mediaQuery: mediaQuery, deleteTx: deleteTx, tx: tx);
                  }).toList(),
                ),
              ),
            ),
    );
  }
}

