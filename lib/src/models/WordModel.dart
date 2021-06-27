import 'dart:convert';

class WordModel {
  WordModel({
    required this.word,
    required this.phonetics,
    required this.meanings,
  });

  String word;
  List<Phonetic> phonetics;
  List<Meaning> meanings;

  factory WordModel.fromJson(String str) => WordModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WordModel.fromMap(Map<String, dynamic> json) => WordModel(
    word: json["word"],
    phonetics: List<Phonetic>.from(json["phonetics"].map((x) => Phonetic.fromMap(x))),
    meanings: List<Meaning>.from(json["meanings"].map((x) => Meaning.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "word": word,
    "phonetics": List<dynamic>.from(phonetics.map((x) => x.toMap())),
    "meanings": List<dynamic>.from(meanings.map((x) => x.toMap())),
  };
}

class Meaning {
  Meaning({
    required this.partOfSpeech,
    required this.definitions,
  });

  String partOfSpeech;
  List<Definition> definitions;

  factory Meaning.fromJson(String str) => Meaning.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Meaning.fromMap(Map<String, dynamic> json) => Meaning(
    partOfSpeech: json["partOfSpeech"],
    definitions: List<Definition>.from(json["definitions"].map((x) => Definition.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "partOfSpeech": partOfSpeech,
    "definitions": List<dynamic>.from(definitions.map((x) => x.toMap())),
  };
}

class Definition {
  Definition({
    required this.definition,
    required this.synonyms,
    required this.example,
  });

  String definition;
  List<String>? synonyms;
  String example;

  factory Definition.fromJson(String str) => Definition.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Definition.fromMap(Map<String, dynamic> json) => Definition(
    definition: json["definition"],
    synonyms: json["synonyms"] == null ? null : List<String>.from(json["synonyms"].map((x) => x)),
    example: json["example"],
  );

  Map<String, dynamic> toMap() => {
    "definition": definition,
    "synonyms": synonyms == null ? null : List<dynamic>.from(synonyms!.map((x) => x)),
    "example": example,
  };
}

class Phonetic {
  Phonetic({
    required this.text,
    required this.audio,
  });

  String text;
  String audio;

  factory Phonetic.fromJson(String str) => Phonetic.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Phonetic.fromMap(Map<String, dynamic> json) => Phonetic(
    text: json["text"],
    audio: json["audio"],
  );

  Map<String, dynamic> toMap() => {
    "text": text.toString(),
    "audio": audio,
  };
}
