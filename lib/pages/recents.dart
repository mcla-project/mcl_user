import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mcl_user/components/book.dart';
import '../utils/get_doc_id.dart';

class RecentsPage extends StatefulWidget {
  const RecentsPage({super.key});

  @override
  State<RecentsPage> createState() => _RecentsPageState();
}

class _RecentsPageState extends State<RecentsPage> {

  final DocIDService docIDService = DocIDService();
  List<Map<String, dynamic>> recentBooks = [];
  Set<String> bookmarkedIds = {};
  bool isLoading = true;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    fetchRecentBooks();
  }

  Future<void> fetchRecentBooks() async {
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
    List<dynamic> bookIds = userData?['recents'] ?? [];

    if (userData != null && userData.containsKey('recents')) {
      bookmarkedIds = Set.from(bookIds);
    }

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
      recentBooks = booksWithAuthors;
      isLoading = false;
    });
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
                Map<String, dynamic> bookData = recentBooks[index - 1];
                bool isBookmarked =
                    userData?['favorites'].contains(bookData['id']) ?? false;
                return bookItem(
                  title: bookData['title'] ?? 'No title',
                  authors: bookData['authors'].join(", ") ?? 'No authors',
                  summary: bookData['synopsis'] ?? 'No summary available',
                  imagePath: bookData['book_cover'] ??
                      'https://via.placeholder.com/150',
                  isBookmarked: isBookmarked,
                  bookId: bookData['id'],
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
      // Update the Firestore document asynchronously
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
  }) {
    bool isBookmarked = bookmarkedIds.contains(bookId);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const BookScreen(),
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
