import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transactify/database/transactions_database.dart';
import 'package:transactify/models/transaction.dart';
import 'package:transactify/screens/home/home_screen.dart';
import 'package:transactify/theme/constants.dart';
import 'package:transactify/theme/theme.dart';

class AddTransactionScreen extends StatefulWidget {
  final Transaction? transaction;

  static String routeName = '/add-edit-transaction-screen';

  const AddTransactionScreen({
    Key? key,
    this.transaction,
  }) : super(key: key);
  @override
  _AddTransactionScreenState createState() =>
      _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isExpense = false;
  String amount = '';
  String title = '';
  DateTime date = DateTime.now();

  String _errorMessage = '';

  @override
  void initState() {
    super.initState();

    isExpense = widget.transaction?.isExpense ?? false;
    amount = widget.transaction?.amount ?? '';
    title = widget.transaction?.title ?? '';
    date = widget.transaction?.date ?? DateTime.now();
  }

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
        setState(() {
          date = pickedDate;
        });
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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(_errorMessage, style: const TextStyle(color: kErrorColor)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Revenue',
                      style: TextStyle(fontSize: 20),
                    ),
                    Switch(
                      
                      value: isExpense,
                      onChanged: (value) => setState(() {
                        isExpense = value;
                      }),
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
                  initialValue: title,
                  cursorColor: kPrimaryColor,
                  decoration: inputDecorationTheme('Title'),
                  validator: (title) => title != null && title.isEmpty
                      ? 'The title cannot be empty'
                      : null,
                  onChanged: (value) => setState(() {
                    title = value;
                  }),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  initialValue: amount,
                  cursorColor: kPrimaryColor,
                  decoration: inputDecorationTheme('Amount'),
                  validator: (amount) => amount != null && amount.isEmpty
                      ? 'The amount cannot be empty'
                      : null,
                  onChanged: (value) => setState(() {
                    amount = value;
                  }),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatter.format(date),
                    ),
                    TextButton(
                      onPressed: () => _selectDate(context),
                      child: Text(
                        'Choose date',
                        style: TextStyle(
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildButton() {
    final isFormValid = title.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? kPrimaryColor : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateTransaction,
        child: const Text('Save'),
      ),
    );
  }

  Future<void> addOrUpdateTransaction() async {
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
      final isUpdating = widget.transaction != null;

      if (isUpdating) {
        await updateTransaction();
      } else {
        await addTransaction();
      }
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }
  }

  Future updateTransaction() async {
    final transaction = widget.transaction!.copy(
      isExpense: isExpense,
      amount: amount,
      title: title,
      date: date,
    );

    await TransactionsDatabase.instance.update(transaction);
  }

  Future addTransaction() async {
    final transaction = Transaction(
      title: title,
      isExpense: isExpense,
      amount: amount,
      date: date,
    );

    await TransactionsDatabase.instance.create(transaction);
  }
}
