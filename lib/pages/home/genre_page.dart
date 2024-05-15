import 'package:flutter/material.dart';
import '../../models/book.dart';
import '../../services/book_service.dart';

class GenreBooksPage extends StatefulWidget {
  final String genre;

  const GenreBooksPage({required this.genre, super.key});

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
      books = fetchedBooks.where((book) => book.genre.contains(widget.genre)).toList();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.genre),
        backgroundColor: Colors.deepPurple,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(books[index].title),
                  subtitle: Text(books[index].authors.join(', ')),
                  leading: Image.network(books[index].imagePath, width: 56, height: 56, fit: BoxFit.cover),
                );
              },
            ),
    );
  }
}
