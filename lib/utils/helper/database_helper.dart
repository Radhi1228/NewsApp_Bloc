import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../model/news_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'news.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE news (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            urlToImage TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertNews(Article article) async {
    final db = await database;
    await db.insert(
      'news',
      {
        'title': article.title,
        'description': article.description,
        'urlToImage': article.urlToImage,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
//
  Future<List<Article>> fetchNews() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('news');
    return List.generate(
      maps.length,
          (i) => Article(
        title: maps[i]['title'],
        description: maps[i]['description'],
        urlToImage: maps[i]['urlToImage'],
      ),
    );
  }

  Future<void> clearNews() async {
    final db = await database;
    await db.delete('news');
  }
}
/*----*/
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import '../../model/news_model.dart';
// import 'package:http/http.dart' as http;
//
// class DatabaseHelper {
//   static final DatabaseHelper _instance = DatabaseHelper._internal();
//   static Database? _database;
//
//   DatabaseHelper._internal();
//
//   factory DatabaseHelper() => _instance;
//
//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }
//
//   Future<Database> _initDatabase() async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, 'news.db');
//
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) {
//         return db.execute('''
//           CREATE TABLE news (
//             id INTEGER PRIMARY KEY AUTOINCREMENT,
//             title TEXT,
//             description TEXT,
//             imagePath TEXT,
//             url TEXT
//           )
//         ''');
//       },
//     );
//   }
//
//   Future<void> insertNews(Article article) async {
//     final db = await database;
//
//     // Save image to local storage
//     String? localImagePath;
//     if (article.urlToImage != null) {
//       localImagePath = await _saveImageLocally(article.urlToImage!);
//     }
//
//     await db.insert(
//       'news',
//       {
//         'title': article.title,
//         'description': article.description,
//         'imagePath': localImagePath,
//         'url': article.url,
//       },
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }
//
//   Future<List<Article>> fetchNews() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('news');
//
//     return List.generate(
//       maps.length,
//           (i) => Article(
//         title: maps[i]['title'],
//         description: maps[i]['description'],
//         urlToImage: maps[i]['imagePath'], // Use local image path
//         url: maps[i]['url'],
//       ),
//     );
//   }
//
//   Future<void> clearNews() async {
//     final db = await database;
//     await db.delete('news');
//   }
//
//   Future<String> _saveImageLocally(String imageUrl) async {
//     try {
//       final response = await http.get(Uri.parse(imageUrl));
//       if (response.statusCode == 200) {
//         final directory = await getApplicationDocumentsDirectory();
//         final filePath = join(directory.path, '${DateTime.now().millisecondsSinceEpoch}.png');
//         final file = File(filePath);
//         await file.writeAsBytes(response.bodyBytes);
//         return filePath;
//       }
//     } catch (e) {
//       print("Failed to save image: $e");
//     }
//     return "";
//   }
// }
