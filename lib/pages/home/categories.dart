import 'package:flutter/material.dart';

class Genre {
  final String name;
  final String description;
  final String imagePath;

  Genre({required this.name, required this.description, required this.imagePath});
}


class CategoriesPage extends StatelessWidget {
  final List<Genre> genres = [
    Genre(name: "Science Fiction", description: "Explore new worlds and futuristic scenarios.", imagePath: "images/mnlcitylib_logo.png"),
    Genre(name: "Autobiography", description: "Delve into the stories of extraordinary lives.", imagePath: "images/mnlcitylib_logo.png"),
    Genre(name: "Philippine Literature", description: "Discover the rich literary heritage of the Philippines.", imagePath: "images/mnlcitylib_logo.png"),
    Genre(name: "Romance", description: "Dive into tales of love and passion.", imagePath: "images/mnlcitylib_logo.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Genres'),
      ),
      body: ListView.builder(
        itemCount: genres.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Image.asset(genres[index].imagePath, width: 50, height: 50),
              title: Text(genres[index].name),
              subtitle: Text(genres[index].description),
            ),
          );
        },
      ),
    );
  }
}