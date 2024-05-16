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
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: SizedBox(
                width: 400, // Adjust the width as per your requirement
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Search for books',
                    suffixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 3.0, horizontal: 20.0),
                    fillColor: Color(0x4D808080),
                    filled: true,
                  ),
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
                  borderRadius: BorderRadius.circular(
                      12), // Set the card's border radius to 12
                ),
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: genres[index].name == 'History'
                        ? Color(
                            0xFFF1F1F1) // Set the background color for 'History' to #F1F1F1
                        : Color(
                            0xFF013822), // Set the default background color to #013822
                    borderRadius: BorderRadius.circular(
                        12), // Set the border radius to 12
                    border: Border.all(
                      color: Colors.grey, // Set border color
                      width: 1, // Set border width
                    ),
                  ),
                  child: ListTile(
                    title: Text(
                      genres[index].name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: genres[index].name == 'History'
                            ? Colors
                                .black // Set text color to black for 'History'
                            : Colors
                                .white, // Set text color to white for other genres
                      ),
                    ),
                    subtitle: Text(
                      genres[index].description,
                      style: TextStyle(
                        color: genres[index].name == 'History'
                            ? Colors
                                .black54 // Set subtitle color to black54 for 'History'
                            : Colors
                                .white70, // Set subtitle color to white70 for other genres
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: genres[index].name == 'History'
                          ? Colors
                              .black // Set icon color to black for 'History'
                          : Colors
                              .white, // Set icon color to white for other genres
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
    );
  }
}
