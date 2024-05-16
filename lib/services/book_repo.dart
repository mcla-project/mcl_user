import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/book.dart';

class BookRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Book>> fetchBooks(List<String> bookIds,
      {bool isBookmarked = false}) async {
    List<Book> books = [];
    for (var bookId in bookIds) {
      DocumentSnapshot bookDoc =
          await _firestore.collection('books').doc(bookId).get();
      if (bookDoc.data() != null) {
        Map<String, dynamic> bookData = bookDoc.data() as Map<String, dynamic>;

        List<String> authors = [];
        for (var authorId in bookData['authors_id'] ?? []) {
          DocumentSnapshot authorDoc =
              await _firestore.collection('authors').doc(authorId).get();
          if (authorDoc.data() != null) {
            Map<String, dynamic> authorData =
                authorDoc.data() as Map<String, dynamic>;
            authors.add(authorData['name']);
          }
        }

        Book book = Book(
          title: bookData['title'],
          authors: authors,
          summary: bookData['synopsis'],
          imagePath: bookData['book_cover'],
          isBookmarked: isBookmarked,
          bookId: bookId,
          genre: List<String>.from(bookData['genre'] ?? []),
        );
        books.add(book);
      }
    }
    return books;
  }

  Future<List<Book>> fetchFavorites(String userId) async {
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(userId).get();
    Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
    List<dynamic> favoriteIds = userData?['favorites'] ?? [];
    return fetchBooks(List<String>.from(favoriteIds), isBookmarked: true);
  }

  Future<List<Book>> fetchRecents(String userId) async {
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(userId).get();
    Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
    List<dynamic> recentIds = userData?['recents'] ?? [];
    return fetchBooks(List<String>.from(recentIds));
  }
}
