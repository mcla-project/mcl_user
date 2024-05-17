import 'package:flutter/material.dart';
import 'home/all_books.dart';
import 'home/favorites.dart';
import 'home/categories.dart';
import '../utils/get_doc_id.dart';
import '../../models/book.dart';
import '../../services/book_service.dart';

class Genre {
  final String name;
  final String description;

  Genre({required this.name, required this.description});
}

// class Book {
//   final String title;
//   final String coverUrl;

//   Book({required this.title, required this.coverUrl});
// }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DocIDService docIDService = DocIDService();
  List<Map<String, dynamic>> favoriteBooks = [];
  Set<String> bookmarkedIds = {};
  bool isLoading = true;
  Map<String, dynamic>? userData;
  late Future<List<Book>> bookFuture;
  TextEditingController searchController = TextEditingController();
  final BookService _bookService = BookService();

  @override
  void initState() {
    super.initState();
    bookFuture = _bookService.fetchBooksFromFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: 400,
                child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    labelText: 'Search for books',
                    suffixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 3.0, horizontal: 20.0),
                    fillColor: Color(0x4D808080),
                    filled: true,
                  ),
                  onSubmitted: (String text) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => AllBooksPage(
                                initialQuery: searchController.text.trim(),
                              )),
                    );
                  },
                ),
              ),
            ),
            GenreList(),
            const FavoriteBooks(),
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
    return SingleChildScrollView(
      child: Padding(
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
                  const Spacer(),
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
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: genres[index].name == 'History'
                          ? const Color(0xFFF1F1F1)
                          : const Color(0xFF013822),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        genres[index].name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: genres[index].name == 'History'
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        genres[index].description,
                        style: TextStyle(
                          color: genres[index].name == 'History'
                              ? Colors.black54
                              : Colors.white70,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: genres[index].name == 'History'
                            ? Colors.black
                            : Colors.white,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CategoriesPage(),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
