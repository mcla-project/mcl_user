import 'package:flutter/material.dart';
import 'home/all_books.dart';
import 'home/favorites.dart';
import 'home/categories.dart';
import '../utils/get_doc_id.dart';

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
  final DocIDService docIDService = DocIDService();
  List<Map<String, dynamic>> favoriteBooks = [];
  Set<String> bookmarkedIds = {};
  bool isLoading = true;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
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
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: ListTile(
                  title: Text(genres[index].name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(genres[index].description),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CategoriesPage(),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
