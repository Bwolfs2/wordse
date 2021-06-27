import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String wordsTable = "wordsTable";
final String idColumn = "id";
final String wordPortugueseColumn = "wordPortuguese";
final String wordEnglishColumn = "wordEnglish";
final String favoriteColumn = "favorite";
final String speakColumn = "speak";
final String definitionColumn = "definition";
final String partOfSpeechColumn = "partOfSpeech";
final dynamic jsonResponseColumn = "jsonResponse";

class WordsStore {

  static final WordsStore _instance = WordsStore.internal();
  factory WordsStore() => _instance;
  WordsStore.internal();

  Database? _db;

  Future<dynamic> get db async {
    if(_db != null){
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "wordse.db");
    print(path);
    return await openDatabase(path, version: 1, onCreate: (Database db, int newerVersion) async {
      await db.execute(
        "CREATE TABLE $wordsTable("
            "$idColumn INTEGER PRIMARY KEY, "
            "$wordPortugueseColumn TEXT, "
            "$wordEnglishColumn TEXT, "
            "$favoriteColumn BOOLEAN, "
            "$speakColumn TEXT,"
            "$definitionColumn TEXT,"
            "$partOfSpeechColumn TEXT,"
            "$jsonResponseColumn TEXT)"
      );
    });
  }

  Future saveWord(Words words) async {
    Database dbContext = await db;
    Map<String, dynamic> w = {
      wordPortugueseColumn: words.wordPortuguese,
      wordEnglishColumn: words.wordEnglish,
      favoriteColumn: words.favorite,
      speakColumn: words.speak,
      definitionColumn: words.definition,
      partOfSpeechColumn: words.partOfSpeech,
      jsonResponseColumn: words.jsonResponse
    };

    var query = await dbContext.insert(wordsTable, w);

    return query;
  }
  
  Future<dynamic> getWord(int id) async {
    Database dbContext = await db;
    
    List<Map> maps = await dbContext.query(wordsTable,
        columns: [
          idColumn,
          wordPortugueseColumn,
          wordEnglishColumn,
          favoriteColumn,
          speakColumn,
          definitionColumn,
          partOfSpeechColumn,
          jsonResponseColumn
        ], where: "$idColumn = ?", whereArgs: [id]);

    if(maps.length > 0){
      return Words.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteWord(int id) async {
    Database dbContext = await db;
    return await dbContext.delete(wordsTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<dynamic> updateFavorite(int id, int fav) async {
    Database dbContext = await db;
    return await dbContext.rawUpdate("UPDATE $wordsTable SET $favoriteColumn = $fav WHERE $idColumn = $id");
  }

  Future<List> getFavoritesWords() async {
    Database dbContext = await db;
    List listMap = await dbContext.rawQuery("SELECT * FROM $wordsTable WHERE $favoriteColumn = 1");
    List<Words> wordsList = <Words>[];

    for(Map m in listMap){
      wordsList.add(Words.fromMap(m));
    }

    return wordsList;
  }

  Future<List> getAllWords() async {
    Database dbContext = await db;
    List listMap = await dbContext.rawQuery("SELECT * FROM $wordsTable");
    List<Words> wordsList = <Words>[];

    for(Map m in listMap){
      wordsList.add(Words.fromMap(m));
    }

    return wordsList;
  }

  Future<dynamic> getNumber() async {
    Database dbContext = await db;
    return Sqflite.firstIntValue(await dbContext.rawQuery("SELECT COUNT(*) FROM $wordsTable"));
  }

  Future close() async {
    Database dbContext = await db;
    await dbContext.close();
  }
}

class Words {
  int? id;
  String? wordPortuguese;
  String? wordEnglish;
  String? speak;
  int favorite = 0;
  String? definition;
  String? partOfSpeech;
  dynamic jsonResponse;

  Words();

  Words.fromMap(Map map){
    id = map[idColumn];
    wordPortuguese = map[wordPortugueseColumn];
    wordEnglish = map[wordEnglishColumn];
    favorite = map[favoriteColumn];
    speak = map[speakColumn];
    definition = map[definitionColumn];
    partOfSpeech = map[partOfSpeechColumn];
    jsonResponse = map[jsonResponseColumn];
  }

  Map toMap(){
    Map<String, dynamic> map = {
      wordPortugueseColumn: wordPortuguese,
      wordEnglishColumn: wordEnglish,
      favoriteColumn: favorite,
      speakColumn: speak,
      definitionColumn: definition,
      partOfSpeechColumn: partOfSpeech,
      jsonResponseColumn: jsonResponse
    };

    if(id != null){
      map[idColumn] = id;
    }

    return map;
  }

  @override
  String toString() {
    return "Words(id: $id, wordPortuguese: $wordPortuguese, "
        "wordEnglish: $wordEnglish, "
        "favorite: $favorite, "
        "speak: $speak, "
        "definition: $definition, "
        "partOfSpeech: $partOfSpeech, "
        "json: $jsonResponse";
  }
}