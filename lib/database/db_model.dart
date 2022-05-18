import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'db_prodect_model.dart';

class ProductDatabase {
  Database? _database;
  Future<Database> get database async {
    final dbpath = await getDatabasesPath();
    const dbname = 'product.db';
    final path = join(dbpath, dbname);
    _database = await openDatabase(path, version: 1, onCreate: _createDB);
    return _database!;
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE product(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        price TEXT,
        image TEXT,
        ratings REAL,
        isChecked INTEGER
      )
     ''');
  }

  Future<void> insertProduct(Product products) async {
    final db = await database;
    await db.insert(
      'product',
      products.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteProduct(Product products) async {
    final db = await database;
    await db.delete(
      'product',
      where: 'id == ?',
      whereArgs: [products.id],
    );
  }

  Future<void> updateProduct(Product products) async {
    final db = await database;
    await db.update(
      'product',
      products.toMap(),
      where: 'id == ?',
      whereArgs: [products.id],
    );
  }

  Future<List<Product>> getProduct() async {
    final db = await database;
    List<Map<String, dynamic>> items = await db.query(
      'product',
      orderBy: 'id DESC',
    );

    return List.generate(
      items.length,
      (i) => Product(
          id: items[i]['id'],
          title: items[i]['title'],
          price: items[i]['price'],
          image: items[i]['image'],
          ratings: items[i]['ratings'],
          isChecked: items[i]['isChecked'] == 1 ? true : false),
    );
  }
}
