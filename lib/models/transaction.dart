const String tableTransactions = 'user_transactions';

class TransactionFields {
  static final List<String> values = [
    id, isExpense, amount, title, date,
  ];

  static const String id = '_id';
  static const String title = 'title';
  static const String amount = 'amount';
  static const String isExpense = 'isExpense';
  static const String date = 'date';
}

class Transaction {
  final int? id;
  final String title;
  final String amount;
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
    String? amount,
    DateTime? date,
    bool? isExpense,
  }) =>
      Transaction(
        id: id ?? this.id,
        title: title ?? this.title,
        amount: amount ?? this.amount,
        isExpense: isExpense ?? this.isExpense,
        date: date ?? this.date,
      );

  static Transaction fromJson(Map<String, Object?> json) => Transaction(
        id: json[TransactionFields.id] as int,
        title: json[TransactionFields.title].toString(),
        amount: json[TransactionFields.amount].toString(),
        isExpense: json[TransactionFields.isExpense] == 1,
        date: DateTime.parse(json[TransactionFields.date] as String),
      );

  Map<String, Object?> toJson() => {
        TransactionFields.id: id,
        TransactionFields.title: title,
        TransactionFields.amount: amount,
        TransactionFields.isExpense: isExpense ? 1 : 0,
        TransactionFields.date: date.toIso8601String(),
      };
}
