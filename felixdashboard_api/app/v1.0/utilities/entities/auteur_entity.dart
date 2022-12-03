import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

class Auteur {
  String? id;

  Auteur({
    this.id,
  });

  Auteur copyWith({
    String? id,
  }) {
    return Auteur(
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap({bool withId = true}) {
    return {
      if (withId) 'id': id,
    };
  }

  factory Auteur.fromMap(Map<String, dynamic> map) {
    return Auteur(
      id: map['_id'] is ObjectId
          ? map['_id'].toHexString()
          : map['_id'].toString(),
    );
  }

  Map<String, dynamic> toJson() => toMap();

  factory Auteur.fromJson(String source) => Auteur.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Auteur(id:)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Auteur && other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
