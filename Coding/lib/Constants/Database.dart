import 'package:mongo_dart/mongo_dart.dart';

class Database {
  final String uri =
      "mongodb+srv://admin:admin@peccluster.lmpcaju.mongodb.net/PEC?retryWrites=true&w=majority";
  Future<Db> connect() async {
    var db = await Db.create(uri);
    await db.open();
    return db;
  }
}
