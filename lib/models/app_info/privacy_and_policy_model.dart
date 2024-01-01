import 'dart:convert';

class PrivacyAndPolicyModel {
  final int id;
  final String title;
  final String content;
  PrivacyAndPolicyModel({
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

  factory PrivacyAndPolicyModel.fromMap(Map<String, dynamic> map) {
    return PrivacyAndPolicyModel(
      id: map['id'] as int,
      title: map['title'] as String,
      content: map['content'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PrivacyAndPolicyModel.fromJson(String source) =>
      PrivacyAndPolicyModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
