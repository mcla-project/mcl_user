import 'package:flutter/material.dart';
import '../../components/book.dart';
import '../../components/book_list.dart';
import '../../models/book.dart';
import '../../services/book_repo.dart';
import '../../utils/get_doc_id.dart';

class SimilarBooks extends StatefulWidget {
  const SimilarBooks({Key? key}) : super(key: key);

  @override
  State<SimilarBooks> createState() => _SimilarBooksState();
}

class _SimilarBooksState extends State<SimilarBooks> {
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

  void handleBookTap(Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookScreen(
          title: book.title,
          authors: book.authors.join(", "),
          summary: book.summary,
          imagePath: book.imagePath,
          isBookmarked:
              bookmarkedIds.contains(book.bookId),
          bookId: book.bookId,
          genre: book.genre.join(", "),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),

          ),
          isLoading
              ? const CircularProgressIndicator()
              : SizedBox(
                  height: 180,
                  child: BooksListView(
                    books: favoriteBooks,
                    bookmarkedIds: bookmarkedIds,
                    onBookTap: handleBookTap,
                  ),
                ),
        ],
      ),
    );
  }
}
