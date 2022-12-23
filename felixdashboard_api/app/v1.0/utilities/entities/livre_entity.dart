import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

import 'validator_entity.dart';

class Livre {
  String? id;
  String? isbn;
  String titre;
  String? auteurId;
  String? langage;
  String? description;
  String? image;
  int nbPages;
  String? categorie;
  String? editeur;
  DateTime? datePublication;
  Livre({
    this.id,
    this.isbn,
    required this.titre,
    this.auteurId,
    this.langage,
    this.description,
    this.image,
    required this.nbPages,
    this.categorie,
    this.editeur,
    this.datePublication,
  });

  Livre copyWith({
    String? id,
    String? isbn,
    String? titre,
    String? auteurId,
    String? langage,
    String? description,
    String? image,
    int? nbPages,
    String? categorie,
    String? editeur,
    DateTime? datePublication,
  }) {
    return Livre(
      id: id ?? this.id,
      isbn: isbn ?? this.isbn,
      titre: titre ?? this.titre,
      auteurId: auteurId ?? this.auteurId,
      langage: langage ?? this.langage,
      description: description ?? this.description,
      image: image ?? this.image,
      nbPages: nbPages ?? this.nbPages,
      categorie: categorie ?? this.categorie,
      editeur: editeur ?? this.editeur,
      datePublication: datePublication ?? this.datePublication,
    );
  }

  Map<String, dynamic> toMap({bool withId = true}) {
    return {
      if (withId) 'id': id,
      'isbn': isbn,
      'titre': titre,
      'auteur_id': auteurId,
      'langage': langage,
      'description': description,
      'image': image,
      'nb_pages': nbPages,
      'categorie': categorie,
      'editeur': editeur,
      'date_publication': datePublication?.millisecondsSinceEpoch,
    };
  }

  factory Livre.fromMap(Map<String, dynamic> map) {
    var validator = ISBNValidator();
    return Livre(
      id: map['_id'] is ObjectId
          ? map['_id'].toHexString()
          : map['_id'].toString(),
      isbn: map['isbn'] != null && validator.isValidISBN(map['isbn'])
          ? map['isbn'].toString()
          : null,
      titre: map['titre'],
      auteurId: map['auteur_id'] != null ? map['auteur_id'].toString() : null,
      langage: map['langage'] != null ? map['langage'].toString() : "fr",
      description:
          map['description'] != null ? map['description'].toString() : null,
      image: map['image'] != null ? map['image'].toString() : null,
      nbPages:
          map['nb_pages'] != null ? int.parse(map['nb_pages'].toString()) : 0,
      categorie: map['categorie'] != null ? map['categorie'].toString() : null,
      editeur: map['editeur'] != null ? map['editeur'].toString() : null,
      datePublication: map['date_publication'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              int.parse(map['date_publication'].toString()))
          : null,
    );
  }

  Map<String, dynamic> toJson() => toMap();

  factory Livre.fromJson(String source) => Livre.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Livre(id: $id, isbn: $isbn, titre: $titre, auteurId: $auteurId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Livre &&
        other.id == id &&
        other.isbn == isbn &&
        other.titre == titre &&
        other.auteurId == auteurId;
  }

  @override
  int get hashCode {
    return id.hashCode ^ isbn.hashCode ^ titre.hashCode ^ auteurId.hashCode;
  }
}
