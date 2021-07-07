const String tableTransactions = 'user_transactions';

class TransactionFields {
  static final List<String> values = [
    id,
    isExpense,
    amount,
    title,
    date,
  ];

  static const String id = '_id';
  static const String title = 'title';

  //Stored as as string because it's easiert to manage this
  static const String amount = 'amount';
  static const String isExpense = 'isExpense';
  static const String date = 'date';
}

class Transaction {
  final int? id;
  final String title, amount;
  final DateTime date;
  final bool isExpense;

  const Transaction({
    this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.isExpense,
  });

  Transaction copy({
    int? id,
    String? title,
    amount,
    DateTime? date,
    bool? isExpense,
  }) =>
      Transaction(
        id: id ?? this.id,
        title: title ?? this.title,
        amount: amount ?? this.amount,
        date: date ?? this.date,
        isExpense: isExpense ?? this.isExpense,
      );

  static Transaction fromJson(Map<String, Object?> json) => Transaction(
    id: json[TransactionFields.id] as int,
    title: json[TransactionFields.title].toString(),
    amount: json[TransactionFields.amount].toString(),
    isExpense: json[TransactionFields.isExpense] == 1,
    date: DateTime.parse(json[TransactionFields.date] as String),


  );
}

