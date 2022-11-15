import 'package:mongo_dart/mongo_dart.dart';

/// MongoClient
class MongoClient {
  /// The database name
  factory MongoClient() => _instance;
  MongoClient._internal();

  /// create singleton instance
  static final MongoClient _instance = MongoClient._internal();

  Db? _db;

  /// connect to the database
  Future<void> connect() async {
    if (_db != null) {
      return;
    }
    // connection string
    const connectionString =
        'mongodb+srv://root:lSK1cwOmfrLxXvST@cluster0.soywi.mongodb.net/dart_frog?retryWrites=true&w=majority';
    // connect to the database
    final db = await Db.create(connectionString);
    // open the connection
    await db.open();
    // return the database
    _db = db;
  }

  /// get the database
  Db? get db => _db;
}
