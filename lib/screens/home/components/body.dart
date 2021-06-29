import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transactify/database/transactions_database.dart';
import 'package:transactify/models/transaction.dart';
import 'package:transactify/screens/home/components/add_transaction_screen.dart';
import 'package:transactify/theme/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Body> {
  late List<Transaction> transactions;
  bool isLoading = false;

  double? currentBalance;

  Future<void> get _currentBalance async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    final double? balance = preferences.getDouble('balance');

    currentBalance = balance;
  }

  @override
  void initState() {
    super.initState();
    _currentBalance;
    refreshTransactions();
  }

  @override
  void dispose() {
    transactions.clear();
    super.dispose();
  }

  Future refreshTransactions() async {
    setState(() => isLoading = true);

    transactions = await TransactionsDatabase.instance.readAllTransactions();

    for (var i = 0; i < transactions.length; i++) {
      setState(() {
        if (!transactions[i].isExpense) {
          currentBalance =
              currentBalance! + double.parse(transactions[i].amount);
        } else {
          currentBalance =
              currentBalance! - double.parse(transactions[i].amount);
        }
      });
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppBar(
            title: Row(
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                    children: <TextSpan>[
                      const TextSpan(
                        text: 'Transactify',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: ' | \$ $currentBalance',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(AddTransactionScreen.routeName);
                },
                icon: const Icon(Icons.add_rounded),
              ),
            ],
          ),
          Container(
            height: 900,
            child: isLoading
                ? ListView.builder(
                    itemCount: 6,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Shimmer.fromColors(
                            highlightColor: Colors.grey[400]!,
                            baseColor: Colors.grey[300]!,
                            period: const Duration(seconds: 1),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                              child: ListTile(
                                leading: const CircleAvatar(),
                                title: Container(height: 10, width: 50),
                                subtitle: Container(height: 10, width: 100),
                              ),
                            ),
                          ));
                    })
                : transactions.isEmpty
                    ? Column(
                        children: <Widget>[
                          const Text(
                            'No transactions added yet!',
                            style: headingStyle,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 200,
                            child: Image.asset(
                              'assets/images/empty.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      )
                    : ListView.builder(
                        itemCount: transactions.length,
                        itemBuilder: (context, index) {
                          final transaction = transactions[index];

                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15),
                            child: Card(
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: !transaction.isExpense
                                      ? Colors.green
                                      : Colors.red,
                                  child: Text(
                                    !transaction.isExpense ? 'R' : 'E',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 24),
                                  ),
                                ),
                                title: Text(transaction.title),
                                subtitle: Text(
                                    '${DateFormat.yMMMd().format(transaction.date)} - \$${transaction.amount}'),
                                trailing: IconButton(
                                  onPressed: () async {
                                    await TransactionsDatabase.instance
                                        .delete(transaction.id!);
                                    refreshTransactions();
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: kErrorColor,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
