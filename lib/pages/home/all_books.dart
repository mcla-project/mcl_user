import 'package:flutter/material.dart';
import '../../components/app_bar.dart';
import '../../components/book.dart';
import '../../components/no_books.dart';
import '../../models/book.dart';
import '../../services/book_service.dart';

class AllBooksPage extends StatefulWidget {
  final String? initialQuery; // Optional parameter to pass initial search query

  const AllBooksPage({super.key, this.initialQuery});

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
    if (widget.initialQuery != null) {
      searchController.text = widget.initialQuery!;
      booksFuture =
          _bookService.fetchBooksFromFirebase(query: widget.initialQuery!);
    } else {
      booksFuture = _bookService.fetchBooksFromFirebase();
    }
  }

  void searchBooks(String query) {
    setState(() {
      booksFuture = _bookService.fetchBooksFromFirebase(query: query.trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search Books',
                prefixIcon: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context)
                        .pop(); // Navigate back to the recent page
                  },
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => searchBooks(searchController.text),
                ),
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                fillColor: const Color(0x4D808080),
                filled: true,
              ),
              onSubmitted: (value) => searchBooks(value),
            ),
          ),
          Expanded(
            child: buildBookGrid(),
          ),
        ],
      ),
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
          return GridView.builder(
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
                      const SizedBox(height: 5),
                      Flexible(
                        child: Text(
                          book.title,
                          style: TextStyle(
                              fontSize:
                                  12), // Adjust based on your font size needs
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return const NoBooksFoundWidget();
        }
      },
    );
  }
}
