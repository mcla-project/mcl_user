import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:mcl_user/components/app_bar.dart';

class ChatPage extends StatefulWidget {
  static const routeName = '/chat';
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> _chatHistory = [
    {
      "time": DateTime.now(),
      "message": "Hello, I'm MCLA. How can I help you?",
      "isSender": false,
    },
  ];

  void getAnswer() async {
    const url =
        "https://generativelanguage.googleapis.com/v1beta2/models/chat-bison-001:generateMessage?key=AIzaSyAWsswakk1Yn_OyYKV9JmxhvFaoHgyS1O8";
    final uri = Uri.parse(url);
    List<Map<String, String>> msg = [];
    for (var i = 0; i < _chatHistory.length; i++) {
      msg.add({"content": _chatHistory[i]["message"]});
    }

    Map<String, dynamic> request = {
      "prompt": {
        "messages": [msg]
      },
      "temperature": 0.25,
      "candidateCount": 1,
      "topP": 1,
      "topK": 1
    };

    final response = await http.post(uri, body: jsonEncode(request));

    setState(() {
      _chatHistory.add({
        "time": DateTime.now(),
        "message": json.decode(response.body)["candidates"][0]["content"],
        "isSender": false,
      });
    });

    _scrollController.jumpTo(
      _scrollController.position.maxScrollExtent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat with Me!',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 27, 63, 49),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
          color: Colors.white,
        ),
      ),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Opacity(
              opacity: 0.2,
              child: Image.asset(
                'images/mnlcitylib_logo.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 160,
            child: ListView.builder(
              itemCount: _chatHistory.length,
              shrinkWrap: false,
              controller: _scrollController,
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.only(
                      left: 14, right: 14, top: 10, bottom: 10),
                  child: Align(
                    alignment: (_chatHistory[index]["isSender"]
                        ? Alignment.topRight
                        : Alignment.topLeft),
                    child: Row(
                      mainAxisAlignment: _chatHistory[index]["isSender"]
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: _chatHistory[index]["isSender"]
                          ? _userMessage(index)
                          : _botMessage(index),
                    ),
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border.fromBorderSide(
                            BorderSide(color: Colors.grey)),
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: "Type a message",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(8.0),
                          ),
                          controller: _chatController,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        if (_chatController.text.isNotEmpty) {
                          _chatHistory.add({
                            "time": DateTime.now(),
                            "message": _chatController.text,
                            "isSender": true,
                          });
                          _chatController.clear();
                        }
                      });
                      _scrollController.jumpTo(
                        _scrollController.position.maxScrollExtent,
                      );

                      getAnswer();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    padding: const EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromRGBO(27, 94, 32, 1),
                              Colors.green,
                            ]),
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      child: Container(
                          constraints: const BoxConstraints(
                              minWidth: 88.0, minHeight: 36.0),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.send,
                            color: Colors.white,
                          )),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _userMessage(int index) {
    return [
      Flexible(
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(27, 94, 32, 1),
                Colors.green,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(_chatHistory[index]["message"],
                style: const TextStyle(fontSize: 15, color: Colors.white)),
          ),
        ),
      ),
    ];
  }

  List<Widget> _botMessage(int index) {
    return [
      const Padding(
        padding: EdgeInsets.only(right: 10.0),
        child: CircleAvatar(
          backgroundImage: AssetImage('images/cbot.png'),
        ),
      ),
      Flexible(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(16),
          child: Text(_chatHistory[index]["message"],
              style: const TextStyle(fontSize: 15, color: Colors.black)),
        ),
      ),
    ];
  }
}
