import 'package:flutter/material.dart';
import '../../components/book.dart';
import '../../components/no_books.dart';
import '../../models/book.dart';
import '../../services/book_service.dart';

class AllBooksPage extends StatefulWidget {
  const AllBooksPage({super.key});

  @override
  State<AllBooksPage> createState() => _AllBooksPageState();
}

class _AllBooksPageState extends State<AllBooksPage> {
  late Future<List<Book>> booksFuture;
  TextEditingController searchController = TextEditingController();
  final BookService _bookService = BookService();

  @override
  void initState() {
    super.initState();
    booksFuture = _bookService.fetchBooksFromFirebase();
  }

  void searchBooks(String query) {
    setState(() {
      // Update the booksFuture to fetch based on the search query
      booksFuture = _bookService.fetchBooksFromFirebase(query: query.trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search Books',
            suffixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => searchBooks(searchController.text),
            ),
          ),
          onSubmitted: (value) => searchBooks(value),
        ),
      ),
      body: buildBookGrid(),
    );
  }

  Widget buildBookGrid() {
    return FutureBuilder(
      future: booksFuture,
      builder: (context, AsyncSnapshot<List<Book>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (snapshot.hasData && snapshot.data!.isEmpty) {
          return const NoBooksFoundWidget();
        } else if (snapshot.hasData) {
          return GestureDetector(
            onTap: () {},
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.7,
                crossAxisSpacing: 5,
                mainAxisSpacing: 7,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Book book = snapshot.data![index];
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
          );
        } else {
          return const NoBooksFoundWidget();
        }
      },
    );
  }

  double _getFontSize(String title) {
    if (title.length < 10) return 16; // Large size for short titles
    if (title.length < 20) return 14; // Medium size for medium-length titles
    return 12; // Small size for long titles
  }
}
