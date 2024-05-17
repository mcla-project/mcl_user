import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/book_item.dart';
import '../models/book.dart';
import '../services/book_repo.dart';
import '../utils/get_doc_id.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
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
        title: const Text(
          'Favorites',
          style: TextStyle(
            color: Colors.white, // Set text color to white
            fontWeight: FontWeight.bold, // Make text bold
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 27, 63, 49), // Set background color
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Navigate back to the previous screen
          },
          color: Colors.white, // Set icon color to white
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: favoriteBooks.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const Center(
                    child: SizedBox(
                      width: 265,
                      child: Text(
                        'FAVORITE READS',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }
                Book bookData = favoriteBooks[index - 1];
                bool isBookmarked = bookmarkedIds.contains(bookData.bookId);

                return BookItem(
                  title: bookData.title,
                  authors: bookData.authors.join(", "),
                  summary: bookData.summary,
                  imagePath: bookData.imagePath,
                  isBookmarked: isBookmarked,
                  bookId: bookData.bookId,
                  genre: bookData.genre.join(", "),
                  onBookmarkToggle: toggleBookmark,
                );
              },
            ),
    );
  }

  void toggleBookmark(String bookId) {
    setState(() {
      if (bookmarkedIds.contains(bookId)) {
        bookmarkedIds.remove(bookId);
      } else {
        bookmarkedIds.add(bookId);
      }
      updateFavoritesInFirestore(bookId);
    });
  }

  Future<void> updateFavoritesInFirestore(String bookId) async {
    String? docId = await docIDService.getDocId();
    if (docId != null) {
      List<String> updatedFavorites = bookmarkedIds.toList();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(docId)
          .update({'favorites': updatedFavorites});
    }
  }
}
