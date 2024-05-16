import 'package:flutter/material.dart';
import '../../models/book.dart';

typedef BookTapCallback = void Function(Book book);

class BooksListView extends StatelessWidget {
  final List<Book> books;
  final BookTapCallback onBookTap;
  final Set<String> bookmarkedIds;

  const BooksListView({
    Key? key,
    required this.books,
    required this.onBookTap,
    required this.bookmarkedIds,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return GestureDetector(
          onTap: () => onBookTap(book),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
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
                Text(
                  book.title,
                  style: const TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
