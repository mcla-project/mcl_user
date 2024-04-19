import 'package:flutter/material.dart';

class RecentsPage extends StatelessWidget {
  const RecentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recents'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          const Center(
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
          const SizedBox(height: 20),
          const SearchBar(),
          bookItem(
            title: "El Filibusterismo",
            author: "by Dr. Jose Rizal",
            summary:
                "El filibusterismo is the second novel written by Philippine national hero José Rizal. It is the sequel to Noli Me Tángere and, …",
            imagePath: 'assets/Elfili.png',
          ),
          bookItem(
            title: "Alamat ng Pagong",
            author: "by Segundo B. Matias",
            summary:
                "Ang alamat ng pagong ay tungkol sa isang binatang matulungin sa kapwa. Subalit, dahil sa isang masamang hangarin...",
            imagePath: 'assets/pagong.png',
          ),
          bookItem(
            title: "Florante at Laura",
            author: "by Francisco Balagtas",
            summary:
                "Florante at Laura is an 1838 awit written by Tagalog poet Francisco Balagtas. The story was dedicated his former sweetheart María Asuncion Rivera.",
            imagePath: 'assets/florante&laura.png',
          ),
          bookItem(
            title: "I Love You Since 1892",
            author: "by Binibinig Mia",
            summary:
                "Carmelita Montecarlos was the youngest daughter of San Alfonso’s wealthiest family, while Juanito Alfonso was the son of the most powerful and...",
            imagePath: 'assets/ily1892.png',
          ),
          bookItem(
            title: "Pride and Prejudice",
            author: "by Jane Austen",
            summary:
                "A classic of English literature, written with incisive wit and superb character delineation, it centers on the burgeoning ...",
            imagePath: 'assets/pride&prejudice.png',
          ),
        ],
      ),
    );
  }

  Widget bookItem({required String title, required String author, required String summary, required String imagePath}) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      height: 150,
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 1,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 90,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 35.0, top: 20.0),
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
                    author,
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
                  ),
                ],
              ),
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
