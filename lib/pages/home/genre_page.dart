import 'package:flutter/material.dart';
import '../../components/book.dart';
import '../../models/book.dart';
import '../../services/book_service.dart';

class GenreBooksPage extends StatefulWidget {
  final String genre;

  const GenreBooksPage({required this.genre, Key? key}) : super(key: key);

  @override
  GenreBooksPageState createState() => GenreBooksPageState();
}

class GenreBooksPageState extends State<GenreBooksPage> {
  final BookService _bookService = BookService();
  List<Book> books = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  void fetchBooks() async {
    var fetchedBooks = await _bookService.fetchBooksFromFirebase();
    setState(() {
      books = fetchedBooks
          .where((book) => book.genre.contains(widget.genre))
          .toList();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.genre,
          style: TextStyle(color: Colors.white),
          // Set text color to white
        ),
        backgroundColor: Color(0xFF013822),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : GestureDetector(
              onTap: () {},
              child: GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 7,
                ),
                itemCount: books.length,
                itemBuilder: (context, index) {
                  Book book = books[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookScreen(
                            title: book.title,
                            authors: book.authors.join(", "),
                            summary: book.summary,
                            imagePath: book.imagePath,
                            isBookmarked: book.isBookmarked,
                            bookId: book.bookId,
                            genre: book.genre.join(", "),
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              book.imagePath,
                              fit: BoxFit.cover,
                              width: 100,
                              height: 140,
                            ),
                          ),
                          const SizedBox(height: 0),
                          Flexible(
                            child: Text(
                              book.title,
                              style:
                                  TextStyle(fontSize: _getFontSize(book.title)),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }

  double _getFontSize(String title) {
    if (title.length < 10) return 16; // Large size for short titles
    if (title.length < 20) return 14; // Medium size for medium-length titles
    return 12; // Small size for long titles
  }
}
