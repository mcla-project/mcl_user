import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../components/book.dart';

class Book {
  final String title;
  final List<String> authors;
  final String summary;
  final String imagePath;
  final bool isBookmarked;
  final String bookId;
  final List<String> genre;

  Book({
    required this.title,
    required this.authors,
    required this.summary,
    required this.imagePath,
    required this.isBookmarked,
    required this.bookId,
    required this.genre,
  });

  factory Book.fromFirestore(Map<String, dynamic> data, String id) {
    return Book(
      title: data['title'] ?? 'No Title',
      authors: data['authors_id'] != null
          ? List<String>.from(data['authors_id'])
          : ['Unknown'],
      summary: data['synopsis'] ?? 'No Summary Available',
      imagePath: data['book_cover'] ?? 'images/mnlcitylib_logo.png',
      isBookmarked: data['isBookmarked'] ?? false,
      bookId: id,
      genre: data['genre'] != null
          ? List<String>.from(data['genre'])
          : ['No Genre'],
    );
  }
}

class ViewCardPage extends StatefulWidget {
  const ViewCardPage({Key? key}) : super(key: key);

  @override
  State<ViewCardPage> createState() => _ViewCardPageState();
}

class _ViewCardPageState extends State<ViewCardPage> {
  Future<String> fetchAuthorNameById(String authorId) async {
    try {
      DocumentSnapshot authorDoc = await FirebaseFirestore.instance
          .collection('authors')
          .doc(authorId)
          .get();
      if (authorDoc.exists && authorDoc.data() != null) {
        Map<String, dynamic> authorData =
        authorDoc.data()! as Map<String, dynamic>;
        if (authorData.containsKey('name')) {
          return authorData['name'];
        } else {
          return "Name not available";
        }
      } else {
        return "Unknown Author";
      }
    } catch (e) {
      return "Error in data";
    }
  }

  Future<List<Book>> fetchBooksFromFirebase() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await firestore.collection('books').get();

    List<Future<Book>> bookFutures = snapshot.docs.map((doc) async {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      List<String> authorIds = List<String>.from(data['authors_id']);
      List<String> authorNames = [];

      for (String authorId in authorIds) {
        String name = await fetchAuthorNameById(authorId);
        authorNames.add(name);
      }

      return Book(
        title: data['title'],
        authors: authorNames,
        summary: data['synopsis'],
        imagePath: data['book_cover'],
        isBookmarked: data['isBookmarked'] ?? false,
        bookId: doc.id,
        genre: List<String>.from(data['genre']),
      );
    }).toList();

    return await Future.wait(bookFutures);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'View Catalogue',
          style: TextStyle(
            color: Colors.white, // Set text color to white
            fontWeight: FontWeight.bold, // Make text bold
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 27, 63, 49), // Set background color
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white, // Set icon color to white
          ),
          onPressed: () {
            Navigator.of(context).pop(); // Navigate back to the previous screen
          },
        ),
      ),
      body: FutureBuilder(
        future: fetchBooksFromFirebase(),
        builder: (context, AsyncSnapshot<List<Book>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            return GestureDetector(
              onTap: () {},
              child: GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
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
                    child: Card(
                      child: Column(
                        children: [
                          Expanded(
                            child:
                            Image.network(book.imagePath, fit: BoxFit.cover),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Text(
                              book.title,
                              style: TextStyle(
                                  fontSize: _getFontSize(book.title),
                                  fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            book.authors.join(", "),
                            style: TextStyle(
                              fontSize: _getFontSize(
                                book.authors.join(", "),
                              ),
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(child: Text("No books found"));
          }
        },
      ),
    );
  }

      double _getFontSize(String title) {
    if (title.length < 10) return 16; // Large size for short titles
    if (title.length < 20) return 14; // Medium size for medium-length titles
    return 12; // Small size for long titles
  }
}
