import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transactify/database/transactions_database.dart';
import 'package:transactify/models/transaction.dart';
import 'package:transactify/theme/constants.dart';
import 'package:transactify/theme/theme.dart';

import '../home_screen.dart';

class AddTransactionScreen extends StatefulWidget {
  static String routeName = '/add-transaction';

  const AddTransactionScreen({Key? key}) : super(key: key);

  @override
  _AddTransactionScreenState createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isExpense = false;
  String amount = '';
  String title = '';
  DateTime date = DateTime.now();

  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    Future<void> _selectDate(BuildContext context) async {
      await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019, 12),
        lastDate: DateTime.now(),
      ).then((pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() => date = pickedDate);
      });
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            },
            icon: Icon(Icons.close_rounded),
          ),
          actions: [buildButton()],
        ),
        body: SafeArea(
          child: SizedBox(
            height: double.infinity,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _errorMessage,
                        style: const TextStyle(color: kErrorColor),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Revenue',
                            style: TextStyle(fontSize: 20),
                          ),
                          Switch(
                            value: isExpense,
                            onChanged: (value) =>
                                setState(() => isExpense = value),
                            activeTrackColor: kErrorColor.withOpacity(0.7),
                            activeColor: kErrorColor,
                            inactiveTrackColor: kSuccessColor.withOpacity(0.7),
                            inactiveThumbColor: kSuccessColor,
                            splashRadius: 5,
                          ),
                          const Text(
                            'Expense',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        initialValue: amount,
                        decoration: inputDecorationTheme('Title'),
                        validator: (title) => title != null && title.isEmpty
                            ? 'The title cannot be empty'
                            : null,
                        onChanged: (value) => setState(() => title = value),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        initialValue: amount,
                        decoration: inputDecorationTheme('Amount'),
                        validator: (amount) => amount != null && amount.isEmpty
                            ? 'The ammount cannot be empty'
                            : null,
                        onChanged: (value) => setState(() => amount = value),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(formatter.format(date)),
                          TextButton(
                            onPressed: () => _selectDate(context),
                            child: Text(
                              'Choose date',
                              style: TextStyle(color: kPrimaryColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Widget buildButton() {
    final isFormValid = title.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        child: const Text('Save'),
        onPressed: addTransaction,
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? kPrimaryColor : Colors.grey.shade700,
        ),
      ),
    );
  }

  Future<void> addTransaction() async {
    final isValid = _formKey.currentState!.validate();

    try {
      double.parse(amount);
    } catch (e) {
      setState(() {
        _errorMessage = 'Please specify a valid amount.';
      });
      return;
    }
    if (isValid) {
      final transaction = Transaction(
        title: title,
        isExpense: isExpense,
        amount: amount,
        date: date,
      );

      await TransactionsDatabase.instance.create(transaction);

      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }
  }
}
