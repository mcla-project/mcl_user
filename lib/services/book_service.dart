import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/book.dart';

class BookService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> fetchAuthorNameById(String authorId) async {
    try {
      DocumentSnapshot authorDoc =
          await _firestore.collection('authors').doc(authorId).get();
      if (authorDoc.exists && authorDoc.data() != null) {
        Map<String, dynamic> authorData =
            authorDoc.data()! as Map<String, dynamic>;
        return authorData['name'] ?? "Name not available";
      } else {
        return "Unknown Author";
      }
    } catch (e) {
      print("Error fetching author name: ${e.toString()}");
      return "Error in data";
    }
  }

  Future<List<Book>> fetchBooksFromFirebase({String query = ''}) async {
    Query collectionQuery = _firestore.collection('books');

    if (query.isNotEmpty) {
      collectionQuery = collectionQuery
          .where('title', isGreaterThanOrEqualTo: query)
          .where('title', isLessThanOrEqualTo: '$query\uf8ff');
    }

    try {
      QuerySnapshot snapshot = await collectionQuery.get();
      List<Future<Book>> bookFutures = snapshot.docs.map((doc) async {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        List<String> authorIds = List<String>.from(data['authors_id']);
        List<String> authorNames = [];

        for (String authorId in authorIds) {
          String name = await fetchAuthorNameById(authorId);
          authorNames.add(name);
          print("Fetched author name: $name for ID: $authorId"); // Debug log
        }

        return Book(
          title: data['title'],
          authors: authorNames,
          summary: data['synopsis'],
          imagePath: data['book_cover'],
          isBookmarked: data['isBookmarked'] ?? false,
          bookId: doc.id,
          genre: List<String>.from(data['genre']),
        );
      }).toList();

      return await Future.wait(bookFutures);
    } catch (e) {
      print('Error fetching data: ${e.toString()}');
      return [];
    }
  }
}
