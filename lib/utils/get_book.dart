import 'package:cloud_firestore/cloud_firestore.dart';

class BookService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchBooks({required List<String> bookIds}) async {
    List<Map<String, dynamic>> booksWithAuthors = [];

    for (var bookId in bookIds) {
      DocumentSnapshot bookDoc = await _firestore.collection('books').doc(bookId).get();
      if (bookDoc.data() != null) {
        Map<String, dynamic> bookData = bookDoc.data() as Map<String, dynamic>;
        List<dynamic> authorsIds = List.from(bookData['authors_id'] ?? []);

        List<String> authorNames = [];
        for (var authorId in authorsIds) {
          DocumentSnapshot authorDoc = await _firestore.collection('authors').doc(authorId).get();
          if (authorDoc.data() != null) {
            Map<String, dynamic> authorData = authorDoc.data() as Map<String, dynamic>;
            authorNames.add(authorData['name']);
          }
        }

        booksWithAuthors.add({
          'id': bookDoc.id,
          'title': bookData['title'],
          'authors': authorNames,
          'synopsis': bookData['synopsis'],
          'book_cover': bookData['book_cover'],
        });
      }
    }

    return booksWithAuthors;
  }
}
