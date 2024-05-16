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
        title: const Text(
          'Genres',
          style: TextStyle(
            color: Colors.white, // Set text color to white
            fontWeight: FontWeight.bold, // Make text bold
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 27, 63, 49), // Set background color
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white, // Set button color to white
          ),
          onPressed: () {
            Navigator.of(context).pop(); // Navigate back to the recent page
          },
        ),
      ),
      body: ListView.builder(
        itemCount: genres.length,
        itemBuilder: (context, index) {
          Color backgroundColor = index % 2 == 0
              ? const Color(0xFF013822)
              : const Color(0xFFF1F1F1);
          if (index == 0) {
            backgroundColor = const Color(0xFF013822);
          }

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
                  MaterialPageRoute(
                    builder: (context) => GenreBooksPage(genre: genres[index]),
                  ),
                );
              },
              child: Container(
                color: backgroundColor,
                child: ListTile(
                  leading: Icon(
                    Icons.book,
                    size: 56,
                    color: backgroundColor == const Color(0xFF013822)
                        ?  const Color(0xFFF1F1F1)
                        : const Color(0xFF49454F),
                  ),
                  title: Text(
                    genres[index],
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: backgroundColor == const Color(0xFF013822)
                          ? const Color(0xFFF1F1F1)
                          : const Color(0xFF49454F),
                    ),
                  ),
                  subtitle: Text(
                    'Explore this genre',
                    style: TextStyle(
                        color: backgroundColor == const Color(0xFF013822)
                            ? const Color(0xFFF1F1F1)
                            : Colors.grey[600]),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
