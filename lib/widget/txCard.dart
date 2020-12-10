import 'package:flutter/material.dart';
import '../model/transaction_model.dart';

class TxCard extends StatelessWidget {
  const TxCard({
    Key key,
    @required this.mediaQuery,
    @required this.deleteTx,
    @required this.tx
  }) : super(key: key);

  final MediaQueryData mediaQuery;
  final Function deleteTx;
  final Transaction tx;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        title: Text(tx.title),
        leading: CircleAvatar(
          child: FittedBox(child: Text('\$${tx.amount}')),
          radius: 30,
        ),
        subtitle: Text(tx.date.toString()),
        trailing:mediaQuery.size.width > 360? FlatButton.icon(
          icon: Icon(Icons.delete),
          textColor: Theme.of(context).errorColor,
          label: Text('Delete', style: TextStyle(fontWeight: FontWeight.bold),),
          onPressed:  () {
            deleteTx(tx.id);
          },) : IconButton(
          icon: Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () {
            deleteTx(tx.id);
          },
        ),
      ),
    );
  }
}
