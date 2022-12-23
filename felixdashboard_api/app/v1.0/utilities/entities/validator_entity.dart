import 'dart:convert';

class ISBNValidator {
  final RegExp _isbnRegex = RegExp(
    //source pour le regex https://chat.openai.com/chat
    r'^(?:ISBN(?:-1[03])?:?\ )?(?=[0-9X]{10}$|(?=(?:[0-9]+[-\ ]){3})[-\ 0-9X]{13}$|97[89][0-9]{10}$|(?=(?:[0-9]+[-\ ]){4})[-\ 0-9]{17}$)(?:97[89][-\ ]?)?[0-9]{1,5}[-\ ]?[0-9]+[-\ ]?[0-9]+[-\ ]?[0-9X]$',
  );

  bool isValidISBN(String isbn) => _isbnRegex.hasMatch(isbn);
}
