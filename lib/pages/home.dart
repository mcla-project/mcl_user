import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../utils/get_doc_id.dart';
import 'home/all_books.dart';


class Genre {
  final String name;
  final String description;

  Genre({required this.name, required this.description});
}

class Book {
  final String title;
  final String coverUrl;

  Book({required this.title, required this.coverUrl});
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final DocIDService docIDService = DocIDService();
  List<Map<String, dynamic>> favoriteBooks = [];
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

    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(docId).get();
    Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
    List<dynamic> bookIds = userData?['favorites'] ?? [];

    if (userData != null && userData.containsKey('favorites')) {
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
          'genre': bookData['genre'],
        });
      }
    }

    if (mounted) {
      setState(() {
        favoriteBooks = booksWithAuthors;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Search for books',
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            GenreList(),
            FavoriteBooks(),
          ],
        ),
      ),
    );
  }
}

class GenreList extends StatelessWidget {
  final List<Genre> genres = [
    Genre(
        name: 'Fiction',
        description:
            'Supporting line text lorem ipsum dolor sit amet, consectetur'),
    Genre(
        name: 'History',
        description:
            'Supporting line text lorem ipsum dolor sit amet, consectetur'),
    Genre(
        name: 'Mystery',
        description:
            'Supporting line text lorem ipsum dolor sit amet, consectetur'),
  ];

  GenreList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Text('Available Genres',
                    style: Theme.of(context).textTheme.titleSmall),
                const Spacer(), // Add some space between the texts
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const AllBooksPage()),
                        );
                  },
                  child: Text('View All',
                      style: Theme.of(context).textTheme.titleSmall),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: genres.length,
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: ListTile(
                  title: Text(genres[index].name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(genres[index].description),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class FavoriteBooks extends StatelessWidget {
  final List<Book> favoriteBooks = [
    Book(title: 'Will in the World', coverUrl: 'images/mnlcitylib_logo.png'),
    Book(
        title: 'The Disguised Princess',
        coverUrl: 'images/mnlcitylib_logo.png'),
    Book(title: 'Horror Stories', coverUrl: 'images/mnlcitylib_logo.png'),
    Book(
        title: 'Astounding Science Fiction',
        coverUrl: 'images/mnlcitylib_logo.png'),
  ];

  FavoriteBooks({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('Favorites',
                style: Theme.of(context).textTheme.titleLarge),
          ),
          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: favoriteBooks.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(favoriteBooks[index].coverUrl,
                            fit: BoxFit.cover, width: 100, height: 140),
                      ),
                      const SizedBox(height: 5),
                      Text(favoriteBooks[index].title,
                          style: const TextStyle(fontSize: 12),
                          textAlign: TextAlign.center),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
