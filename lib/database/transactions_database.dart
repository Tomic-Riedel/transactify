import 'package:flutter/material.dart';
import 'package:transactify/models/transaction.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sql;

class TransactionsDatabase with ChangeNotifier {
  static final TransactionsDatabase instance = TransactionsDatabase._init();

  static sql.Database? _database;

  TransactionsDatabase._init();

  Future<sql.Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('transactions.db');
    return _database!;
  }

  Future<sql.Database> _initDB(String filePath) async {
    final dbPath = await sql.getDatabasesPath();
    final path = join(dbPath, filePath);

    return sql.openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(sql.Database db, int version) async {
    await db.execute(
        'CREAT TABLE IF NOT EXISTS user_transactions (_id INTEGER PRIMARY KEY, title TEXT NOT NULL, amount TEXT NOT NULL, isExpense BOOL NOT NULL, date TEXT NOT NULL)');
  }

  Future<void> create(Transaction transaction) async {
    final db = await instance.database;

    //I know there is clearly a better way to insert data, however I am most familiar with this way
    final sql = '''
    INSERT INTO user_transactions
    (
      ${TransactionFields.id},
      ${TransactionFields.title},
      ${TransactionFields.amount},
      ${TransactionFields.isExpense},
      ${TransactionFields.date}
    )
    VALUES
    (
      ${transaction.id},
      "${transaction.title}",
      "${transaction.amount}",
      ${transaction.isExpense},
      "${transaction.date}"
    )
    ''';

    await db.rawInsert(sql);
  }

  Future<Transaction> readTransaction(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableTransactions,
      columns: TransactionFields.values,
      where: '${TransactionFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Transaction.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Transaction>> readAllTransactions() async {
    final db = await instance.database;

    final orderBy = '${TransactionFields.date} DESC';

    final result = await db.query(tableTransactions, orderBy: orderBy);
    return result.map((json) => Transaction.fromJson(json)).toList();
  }

  Future<void> delete(int id) async {
    final db = await instance.database;

    db.delete(
      tableTransactions,
      where: '${TransactionFields.id} = ?',
      whereArgs: [id],
    );
  }
}
