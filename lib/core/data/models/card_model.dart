import 'dart:convert';

class CardModel {
  String id;
  String title;
  String description;
  DateTime createdAt;

  CardModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  // Factory Constructor من Map
  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      createdAt: DateTime(4),

    );
  }

  
  factory CardModel.fromJson(String jsonString) {
    final Map<String, dynamic> map = jsonDecode(jsonString);
    return CardModel.fromMap(map);
  }

  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  
  String toJson() {
    return jsonEncode(toMap());
  }

  
  static String encode(List<CardModel> list) {
    return jsonEncode(
      list.map((item) => item.toMap()).toList(),
    );
  }

 
  static List<CardModel> decode(String jsonString) {
   
      final List<dynamic> decodedList = jsonDecode(jsonString);
      return decodedList
          .map((item) => CardModel.fromMap(item as Map<String, dynamic>))
          .toList();
    
  }
}