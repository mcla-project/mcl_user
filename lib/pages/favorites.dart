import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          const Center(
            child: SizedBox(
              width: 265,
              child: Text(
                'RECENTLY VIEWED',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          const SearchBar(),
          bookItem(
              title: "El Filibusterismo",
              author: "by Dr. Jose Rizal",
              summary:
                  "El filibusterismo is the second novel written by Philippine national hero José Rizal. It is the sequel to Noli Me Tángere and, …",
              imagePath: 'assets/Elfili.png'),
          bookItem(
              title: "Alamat ng Pinya",
              author: "by Boots S. Agbayani",
              summary:
                  "Ang Alamat ng Pinya ay isa sa mga kilalang kwentong-bayan sa Pilipinas. Ito ay isang kuwento tungkol sa isang ina na nagngangalang...",
              imagePath: 'assets/pinya.png'),
          bookItem(
              title: "Florante at Laura",
              author: "by Francisco Balagtas",
              summary:
                  "Florante at Laura is an 1838 awit written by Tagalog poet Francisco Balagtas. The story was dedicated his former sweetheart María Asuncion Rivera.",
              imagePath: 'assets/florante&laura.png'),
          bookItem(
              title: "A Thousand Brains",
              author: "by Jeff Hawkins",
              summary:
                  "An author, neuroscientist, and computer engineer unveils a theory of intelligence, of understanding the brain and the future of AI. For all...",
              imagePath: 'assets/thousand_brains.png'),
          bookItem(
              title: "World War Z",
              author: "by Max Brooks",
              summary:
                  "The Zombie War came unthinkably close to eradicating humanity. Max Brooks, driven by the urgency of preserving the acid-etched first-hand...",
              imagePath: 'assets/WWZ.png'),
        ],
      ),
    );
  }

  Widget bookItem({required String title, required String author, required String summary, required String imagePath}) {
    return Column(
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
                  image: AssetImage(imagePath),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 2),
                  Text(author, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
                  const SizedBox(height: 5),
                  Text(summary, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.bookmark, color: Colors.amber),
              onPressed: () {
                // Handle bookmark button press here
              },
            ),
          ],
        ),
      ],
    );
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  SearchBarState createState() => SearchBarState();
}

class SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        hintText: 'Looking for something specific...',
        filled: true,
        fillColor: Colors.black.withOpacity(0.3),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  _controller.clear();
                });
              },
            ),
          ],
        ),
        prefixIcon: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle arrow button press here
            Navigator.of(context).pop();
          },
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}
