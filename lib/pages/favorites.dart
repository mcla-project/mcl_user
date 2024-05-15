import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mcl_user/components/book.dart';
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
  Map<String, dynamic>? userData;

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
        title: const Text('Favorites'),
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

                return bookItem(
                  title: bookData.title,
                  authors: bookData.authors.join(", "),
                  summary: bookData.summary,
                  imagePath: bookData.imagePath,
                  isBookmarked: isBookmarked,
                  bookId: bookData.bookId,
                  genre: bookData.genre.join(", "),
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

  Widget bookItem({
    required String title,
    required String authors,
    required String summary,
    required String imagePath,
    required bool isBookmarked,
    required String bookId,
    required String genre,
  }) {
    // bool isBookmarked = bookmarkedIds.contains(bookId);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookScreen(
              title: title,
              authors: authors,
              summary: summary,
              imagePath: imagePath,
              isBookmarked: isBookmarked,
              bookId: bookId,
              genre: genre,
            ),
          ),
        );
      },
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imagePath),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      authors,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      summary,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: Colors.yellowAccent[700],
                ),
                onPressed: () => toggleBookmark(bookId),
              ),
            ],
          ),
        ],
      ),
    );
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
