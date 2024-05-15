import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mcl_user/components/book.dart';
import '../components/book_item.dart';
import '../models/book.dart';
import '../services/book_repo.dart';
import '../utils/get_doc_id.dart';

class RecentsPage extends StatefulWidget {
  const RecentsPage({super.key});

  @override
  State<RecentsPage> createState() => _RecentsPageState();
}

class _RecentsPageState extends State<RecentsPage> {
  final DocIDService docIDService = DocIDService();
  final BookRepository bookRepository = BookRepository();
  List<Book> favoriteBooks = [];
  List<Book> recentBooks = [];
  Set<String> bookmarkedIds = {};
  bool isLoading = true;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    fetchRecentBooks();
  }

  Future<void> fetchRecentBooks() async {
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

    recentBooks = await bookRepository.fetchRecents(docId);
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
        title: const Text('Recents'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: recentBooks.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const Center(
                    child: SizedBox(
                      width: 265,
                      child: Text(
                        'RECENT READS',
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
                Book bookData = recentBooks[index - 1];
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

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  SearchBarState createState() => SearchBarState();
}

class SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        hintText: 'Looking for something specific...',
        filled: true,
        fillColor: Colors.black.withOpacity(0.3),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  _controller.clear();
                });
              },
            ),
          ],
        ),
        prefixIcon: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}
