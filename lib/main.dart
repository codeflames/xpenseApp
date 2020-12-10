import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './model/transaction_model.dart';
import './widget/chart.dart';
import './widget/inputArea.dart';
import './widget/transacton_area.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setPreferredOrientations(
  //  [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
          primarySwatch: Colors.lightGreen,
          accentColor: Colors.lightGreenAccent,
          fontFamily: 'Quicksand',
          appBarTheme: AppBarTheme(
              textTheme: TextTheme(
                  headline6:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 24)))),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> transactions = [];

  List<Transaction> get _recentTransactions {
    return transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _newTransactionUpdate(
      String titleUpdate, double amountUpdate, DateTime chosenDate) {
    final txUpdate = Transaction(
        title: titleUpdate,
        amount: amountUpdate,
        id: DateTime.now().toString(),
        date: chosenDate);

    setState(() {
      transactions.add(txUpdate);
    });
  }

  bool showChart = false;

  void _deleteTx(id) {
    setState(() {
      transactions.removeWhere((element) => element.id == id);
    });
  }

  void bottomSheet(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (val) {
          return InputArea(_newTransactionUpdate);
        });
  }

  @override
  Widget build(BuildContext context) {
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text('Test App'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => bottomSheet(context),
        )
      ],
    );
    final txWidget = Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.7,
        child:
            TransactionArea(transactions: transactions, deleteTx: _deleteTx));

    final chartWidget = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          .3,
      child: Chart(_recentTransactions),
    );
    final chartWidgetLandscape = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          .6,
      child: Chart(_recentTransactions),
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              if (isLandscape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    showChart == true
                        ? Text(
                            'Hide Chart',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )
                        : Text(
                            'Show Chart',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                    Switch(
                        value: showChart,
                        onChanged: (val) {
                          setState(() {
                            showChart = val;
                          });
                        }),
                  ],
                ),
              if (!isLandscape) chartWidget,
              if (!isLandscape) txWidget,
              if (isLandscape) showChart ? chartWidgetLandscape : txWidget
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        child: Icon(Icons.add),
        onPressed: () => bottomSheet(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
