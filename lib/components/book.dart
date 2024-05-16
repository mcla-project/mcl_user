import 'package:flutter/material.dart';
import 'package:mcl_user/components/app_bar.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              color: const Color.fromARGB(255, 27, 63, 49),               child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 10, 
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        20.0), // Adjust the radius as needed
                    child: Image.network(
                      'https://upload.wikimedia.org/wikipedia/en/4/41/PlaceCalledFreedom.jpg',
                      width: 200,
                      height: 240,
                      fit: BoxFit.fitWidth,
                      
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Frankenstein",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "by Mary Shelley (1818)",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Icon(Icons.star, color: Colors.yellow[700], size: 20),
                      Icon(Icons.star, color: Colors.yellow[700], size: 20),
                      Icon(Icons.star, color: Colors.yellow[700], size: 20),
                      Icon(Icons.star, color: Colors.yellow[700], size: 20),
                      Icon(Icons.star, color: Colors.yellow[700], size: 20),
                      Text(" 5 (by 500 users)",
                          style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Synopsis",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Mary Shelley started writing classic gothic thriller Frankenstein when she was 18 years old. Two centuries later, it is a major ancestor of both the science fiction and horror genres, tackling huge themes like the nature of life and death, immortality and genetic engineering. It is a pro-science novel that at its heart shows Dr Frankenstein as the callous fiend of the story, who created a being and was not willing to accept responsibility for his actions. In an age where the space between technical life and death is narrower than ever, and scientists are playing with the makeup of what makes us humans, Frankenstein can still teach an important lesson: just because you can, does not mean you should.",
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Similar Books",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      bookThumbnail(
                          "https://upload.wikimedia.org/wikipedia/en/4/41/PlaceCalledFreedom.jpg"),
                      const SizedBox(width: 10),
                      bookThumbnail(
                          "https://upload.wikimedia.org/wikipedia/en/4/41/PlaceCalledFreedom.jpg"),
                      const SizedBox(width: 10),
                      bookThumbnail(
                          "https://upload.wikimedia.org/wikipedia/en/4/41/PlaceCalledFreedom.jpg"),
                      const SizedBox(width: 10),
                      bookThumbnail(
                          "https://upload.wikimedia.org/wikipedia/en/4/41/PlaceCalledFreedom.jpg"),
                    ],
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bookThumbnail(String assetName) {
    return Container(
      width: 70,
      height: 100,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        image: DecorationImage(
          image: NetworkImage(assetName),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
