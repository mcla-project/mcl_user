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
      authors: data['authors_id'] != null ? List<String>.from(data['authors_id']) : ['Unknown'],
      summary: data['synopsis'] ?? 'No Summary Available',
      imagePath: data['book_cover'] ?? 'images/mnlcitylib_logo.png',
      isBookmarked: data['isBookmarked'] ?? false,
      bookId: id,
      genre: data['genre'] != null ? List<String>.from(data['genre']) : ['No Genre'],
    );
  }
}
