import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
              top: 130,
              left: (MediaQuery.of(context).size.width - 270) / 2,
              child: const SizedBox(
                width: 265,
                child: Text(
                  'RECENTLY VIEWED',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
            ),
            const Positioned(
              top: 160,
              left: 20,
              right: 20,
              child: SearchBar(),
            ),
            Positioned(
              top: 220,
              left: 20,
              right: 20,
              child: Container(
                width: 400,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0x00d9d9d9),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 1,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: const Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 125.0, top: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "El Filibusterismo",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "by Dr. Jose Rizal",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "El filibusterismo is the second novel written by Philippine national hero José Rizal. It is the sequel to Noli Me Tángere and, …",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 222,
              right: 20,
              child: IconButton(
                icon: const Icon(
                  Icons.bookmark,
                  color: Colors.amber,
                ),
                onPressed: () {
                  // Handle bookmark button press here
                },
              ),
            ),
            Positioned(
              top: 235,
              left: (MediaQuery.of(context).size.width - 337) / 2,
              child: Container(
                width: 90,
                height: 100,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/Elfili.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 350,
              left: 20,
              right: 20,
              child: Container(
                width: 400,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0x00d9d9d9),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 1,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: const Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 125.0, top: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Alamat ng Pinya",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "by Boots S. Agbayani",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Ang Alamat ng Pinya ay isa sa mga kilalang kwentong-bayan sa Pilipinas. Ito ay isang kuwento tungkol sa isang ina na nagngangalang...",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 352,
              right: 20,
              child: IconButton(
                icon: const Icon(
                  Icons.bookmark,
                  color: Colors.amber,
                ),
                onPressed: () {
                  // Handle bookmark button press here
                },
              ),
            ),
            Positioned(
              top: 365,
              left: (MediaQuery.of(context).size.width - 330) / 2,
              child: Container(
                width: 80,
                height: 100,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/pinya.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 480,
              left: 20,
              right: 20,
              child: Container(
                width: 400,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0x00d9d9d9),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 1,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: const Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 125.0, top: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Florante at Laura",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "by Francisco Balagtas",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Florante at Laura is an 1838 awit written by Tagalog poet Francisco Balagtas. The story was dedicated his former sweetheart María Asuncion Rivera.",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 482,
              right: 20,
              child: IconButton(
                icon: const Icon(
                  Icons.bookmark,
                  color: Colors.amber,
                ),
                onPressed: () {
                  // Handle bookmark button press here
                },
              ),
            ),
            Positioned(
              top: 495,
              left: (MediaQuery.of(context).size.width - 330) / 2,
              child: Container(
                width: 80,
                height: 100,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/florante&laura.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 610,
              left: 20,
              right: 20,
              child: Container(
                width: 400,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0x00d9d9d9),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 1,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: const Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 125.0, top: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "A Thousand Brains",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "by Jeff Hawkins",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "An author, neuroscientist, and computer engineer unveils a theory of intelligence, of understanding the brain and the future of AI. For all...",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 612,
              right: 20,
              child: IconButton(
                icon: const Icon(
                  Icons.bookmark,
                  color: Colors.amber,
                ),
                onPressed: () {
                  // Handle bookmark button press here
                },
              ),
            ),
            Positioned(
              top: 625,
              left: (MediaQuery.of(context).size.width - 330) / 2,
              child: Container(
                width: 80,
                height: 100,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/thousand_brains.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 738,
              left: 20,
              right: 20,
              child: Container(
                width: 400,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0x00d9d9d9),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 1,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: const Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 125.0, top: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "World War Z",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "by Max Brooks",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "The Zombie War came unthinkably close to eradicating humanity. Max Brooks, driven by the urgency of preserving the acid-etched first-hand...",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 740,
              right: 20,
              child: IconButton(
                icon: const Icon(
                  Icons.bookmark,
                  color: Colors.amber,
                ),
                onPressed: () {
                  // Handle bookmark button press here
                },
              ),
            ),
            Positioned(
              top: 750,
              left: (MediaQuery.of(context).size.width - 330) / 2,
              child: Container(
                width: 80,
                height: 100,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/WWZ.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
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
