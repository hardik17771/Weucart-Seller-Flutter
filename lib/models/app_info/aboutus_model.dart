import 'dart:convert';

class AboutUsModel {
  final int id;
  final String title;
  final String content;
  AboutUsModel({
    required this.id,
    required this.title,
    required this.content,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
    };
  }

  factory AboutUsModel.fromMap(Map<String, dynamic> map) {
    return AboutUsModel(
      id: map['id'] as int,
      title: map['title'] as String,
      content: map['content'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AboutUsModel.fromJson(String source) =>
      AboutUsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
