import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

class Auteur {
  String? id;
  String? nom;
  String? prenom;
  //getter for nom + prenom
  String get nomComplet => '$nom $prenom';
  Auteur({
    this.id,
    this.nom,
    this.prenom,
  });

  Auteur copyWith({
    String? id,
    String? nom,
    String? prenom,
  }) {
    return Auteur(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      prenom: prenom ?? this.prenom,
    );
  }

  Map<String, dynamic> toMap({bool withId = true}) {
    return {
      if (withId) 'id': id,
      'nom': nom,
      'prenom': prenom,
    };
  }

  factory Auteur.fromMap(Map<String, dynamic> map) {
    return Auteur(
      id: map['_id'] is ObjectId
          ? map['_id'].toHexString()
          : map['_id'].toString(),
      nom: map['nom'],
      prenom: map['prenom'],
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
