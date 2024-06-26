import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import '../components/book_item.dart';
import '../models/book.dart';
import '../services/book_repo.dart';
import '../utils/get_doc_id.dart';
import 'similar.dart';

class BookScreen extends StatefulWidget {
  final String title;
  final String authors;
  final String summary;
  final String imagePath;
  final bool isBookmarked;
  final String bookId;
  final String genre;

  const BookScreen({
    Key? key,
    required this.title,
    required this.authors,
    required this.summary,
    required this.imagePath,
    required this.isBookmarked,
    required this.bookId,
    required this.genre,
  }) : super(key: key);

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  final DocIDService docIDService = DocIDService();
  final BookRepository bookRepository = BookRepository();
  List<Book> favoriteBooks = [];
  Set<String> bookmarkedIds = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFavoriteBooks();
  }

  Future<void> fetchFavoriteBooks() async {
    if (!mounted) return;

    setState(() {
      isLoading = true;
    });

    String? docId = await docIDService.getDocId();
    if (docId == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    favoriteBooks = await bookRepository.fetchFavorites(docId);
    bookmarkedIds = Set.from(favoriteBooks.map((book) => book.bookId));

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Navigate back to the recent page
          },
          color: Colors.white, // Set color of the icon button to white
        ),
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white, // Set text color to white
            fontWeight: FontWeight.bold, // Make text bold
          ),
        ),
        backgroundColor:
            const Color.fromARGB(255, 27, 63, 49), // Set background color
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              color: const Color.fromARGB(255, 27, 63, 49),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(
                      widget.imagePath,
                      width: 200,
                      height: 240,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          widget.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      IconButton(
                        icon: Icon(
                          bookmarkedIds.contains(widget.bookId) ? Icons.bookmark : Icons.bookmark_border,
                          color: Colors.yellowAccent[700],
                        ),
                        onPressed: () => toggleBookmark(widget.bookId),
                      ),
                    ],
                  ),
                  Text(
                    'by: ${widget.authors}',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Icon(Icons.star, color: Colors.yellow[700], size: 20),
                      Icon(Icons.star, color: Colors.yellow[700], size: 20),
                      Icon(Icons.star, color: Colors.yellow[700], size: 20),
                      Icon(Icons.star, color: Colors.yellow[700], size: 20),
                      Icon(Icons.star, color: Colors.yellow[700], size: 20),
                      Text(" 5 (by 500 users)",
                          style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Synopsis",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.summary,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Similar Books",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const SimilarBooks(),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bookThumbnail(String assetName) {
    return Container(
      width: 70,
      height: 100,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        image: DecorationImage(
          image: NetworkImage(assetName),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  void toggleBookmark(String bookId) {
    bool isCurrentlyBookmarked = bookmarkedIds.contains(bookId);
    setState(() {
      if (isCurrentlyBookmarked) {
        bookmarkedIds.remove(bookId);
      } else {
        bookmarkedIds.add(bookId);
      }
    });
    updateFavoritesInFirestore(bookId, !isCurrentlyBookmarked);
  }

  Future<void> updateFavoritesInFirestore(String bookId, bool isAdding) async {
    String? docId = await docIDService.getDocId();
    if (docId != null) {
      DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(docId);
      if (isAdding) {
        userDoc.update({
          'favorites': FieldValue.arrayUnion([bookId])  // Adds the bookId to the 'favorites' array
        });
      } else {
        userDoc.update({
          'favorites': FieldValue.arrayRemove([bookId])  // Removes the bookId from the 'favorites' array
        });
      }
    }
  }
}

