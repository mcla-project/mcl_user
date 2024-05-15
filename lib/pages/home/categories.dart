import 'package:flutter/material.dart';
import '../../services/book_service.dart';
import 'genre_page.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  CategoriesPageState createState() => CategoriesPageState();
}

class CategoriesPageState extends State<CategoriesPage> {
  final BookService _bookService = BookService();
  List<String> genres = [];

  @override
  void initState() {
    super.initState();
    fetchGenres();
  }

  void fetchGenres() async {
    var fetchedGenres = await _bookService.fetchUniqueGenres();
    setState(() {
      genres = fetchedGenres;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Genres'),
        backgroundColor: Colors.white60,
      ),
      body: ListView.builder(
        itemCount: genres.length,
        itemBuilder: (context, index) {
          return Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 4,
            margin: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GenreBooksPage(genre: genres[index])),
                );
              },
              child: Container(
                color: Colors.white60,
                child: ListTile(
                  leading: const Icon(Icons.book, size: 56),
                  title: Text(genres[index], style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                  subtitle: Text('Explore this genre', style: TextStyle(color: Colors.grey[600])),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
