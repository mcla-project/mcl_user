import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/get_doc_id.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final DocIDService docIDService = DocIDService();
  List<Map<String, dynamic>> favoriteBooks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFavoriteBooks();
  }

  Future<void> fetchFavoriteBooks() async {
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

    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(docId).get();
    Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
    List<dynamic> bookIds = userData?['favorites'] ?? [];

    List<Map<String, dynamic>> booksWithAuthors = [];
    for (var bookId in bookIds) {
      DocumentSnapshot bookDoc = await FirebaseFirestore.instance
          .collection('books')
          .doc(bookId)
          .get();
      if (bookDoc.data() != null) {
        Map<String, dynamic> bookData = bookDoc.data() as Map<String, dynamic>;
        List<dynamic> authorsIds = List.from(bookData['authors_id'] ?? []);

        List<String> authorNames = [];
        for (var authorId in authorsIds) {
          DocumentSnapshot authorDoc = await FirebaseFirestore.instance
              .collection('authors')
              .doc(authorId)
              .get();
          if (authorDoc.data() != null) {
            Map<String, dynamic> authorData =
                authorDoc.data() as Map<String, dynamic>;
            authorNames.add(authorData['name']);
          }
        }

        booksWithAuthors.add({
          'id': bookDoc.id,
          'title': bookData['title'],
          'authors': authorNames,
          'synopsis': bookData['synopsis'],
          'book_cover': bookData['book_cover'],
        });
      }
    }

    setState(() {
      favoriteBooks = booksWithAuthors;
      isLoading = false;
    });
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
                  // Header item
                  return const Center(
                    child: SizedBox(
                      width: 265,
                      child: Text(
                        'RECENTLY VIEWED',
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
                // Use the fetched book data directly
                Map<String, dynamic> bookData = favoriteBooks[index - 1];
                return bookItem(
                  title: bookData['title'] ?? 'No title',
                  authors: bookData['authors'].join(", ") ?? 'No authors',
                  summary: bookData['synopsis'] ?? 'No summary available',
                  imagePath: bookData['book_cover'] ??
                      'https://via.placeholder.com/150',
                );
              },
            ),
    );
  }

  Widget bookItem({
    required String title,
    required String authors,
    required String summary,
    required String imagePath,
  }) {
    return Column(
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
                  Text(title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 2),
                  Text(authors, // Displaying multiple authors
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w400)),
                  const SizedBox(height: 5),
                  Text(
                    summary,
                    style: const TextStyle(
                        fontSize: 10, fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.bookmark, color: Colors.amber),
              onPressed: () {
                // Handle bookmark button press here
              },
            ),
          ],
        ),
      ],
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
            // Handle arrow button press here
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
