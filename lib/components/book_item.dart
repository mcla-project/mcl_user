import 'package:flutter/material.dart';
import 'book.dart';

// Callback type for bookmark toggling
typedef ToggleBookmarkCallback = void Function(String bookId);

class BookItem extends StatelessWidget {
  final String title;
  final String authors;
  final String summary;
  final String imagePath;
  final bool isBookmarked;
  final String bookId;
  final String genre;
  final ToggleBookmarkCallback onBookmarkToggle;

  const BookItem({
    Key? key,
    required this.title,
    required this.authors,
    required this.summary,
    required this.imagePath,
    required this.isBookmarked,
    required this.bookId,
    required this.genre,
    required this.onBookmarkToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookScreen(
              title: title,
              authors: authors,
              summary: summary,
              imagePath: imagePath,
              isBookmarked: isBookmarked,
              bookId: bookId,
              genre: genre,
            ),
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
                onPressed: () => onBookmarkToggle(bookId),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
