import 'dart:convert';

class TermsAndConditionsModel {
  final int id;
  final String title;
  final String content;
  TermsAndConditionsModel({
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

  factory TermsAndConditionsModel.fromMap(Map<String, dynamic> map) {
    return TermsAndConditionsModel(
      id: map['id'] as int,
      title: map['title'] as String,
      content: map['content'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TermsAndConditionsModel.fromJson(String source) =>
      TermsAndConditionsModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
