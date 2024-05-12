import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pim/apiConstants.dart';

class JavaBotPage extends StatefulWidget {
  @override
  _JavaBotPageState createState() => _JavaBotPageState();
}

class _JavaBotPageState extends State<JavaBotPage> {
  final TextEditingController _textController = TextEditingController();
  List<ChatMessage> _messages = [];

  Future<void> _handleSubmitted(String text) async {
    _textController.clear();
    ChatMessage message = ChatMessage(
      text: text,
      isUserMessage: true,
    );
    setState(() {
      _messages.insert(0, message);
    });

    // Call your API here to send the user's message and get the bot's response
    final response = await http.post(
      Uri.parse('${APIConstants.baseURL}/note/ask'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{'question': text}),
    );

    if (response.statusCode == 200) {
      // Add the bot's response to _messages
      final jsonResponse = jsonDecode(response.body);
      final botResponse = jsonResponse['response'];
      ChatMessage botMessage = ChatMessage(
        text: botResponse,
        isUserMessage: false,
      );
      setState(() {
        _messages.insert(0, botMessage);
      });
    } else {
      throw Exception('Failed to load response');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Java Bot'),
        backgroundColor: Color.fromARGB(255, 214, 28, 28),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (_, int index) => _messages[index],
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Color.fromARGB(255, 217, 55, 19)),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: InputDecoration.collapsed(
                  hintText: 'Send a message',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () => _handleSubmitted(_textController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class ChatMessage extends StatelessWidget {
  ChatMessage({required this.text, required this.isUserMessage});

  final String text;
  final bool isUserMessage;

  String getFirstSentence() {
    final firstSentence = text.split('.').first + '.';
    return firstSentence;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              child: Text(isUserMessage ? 'User' : 'Bot'),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  isUserMessage ? 'You' : 'Java Bot',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: Text(getFirstSentence()), // Utilisez la méthode getFirstSentence
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}