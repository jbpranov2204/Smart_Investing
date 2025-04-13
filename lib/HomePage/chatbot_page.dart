import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_markdown/flutter_markdown.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    // Add bot's welcome message as the first chat message
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _messages.insert(
          0,
          ChatMessage(
            text:
                "Hi! How can I assist you today? Feel free to ask me anything!",
            isUser: false,
          ),
        );
      });
    });
  }

  void _handleSubmitted(String text) {
    if (text.isEmpty) return;
    _textController.clear();
    setState(() {
      _messages.insert(0, ChatMessage(text: text, isUser: true));
      _isTyping = true;
    });

    // Get response from API
    _getApiResponse(text)
        .then((response) {
          setState(() {
            _isTyping = false;
            _messages.insert(0, ChatMessage(text: response, isUser: false));
          });
        })
        .catchError((error) {
          setState(() {
            _isTyping = false;
            _messages.insert(
              0,
              ChatMessage(
                text:
                    "Sorry, I couldn't connect to the server. Please try again later.",
                isUser: false,
              ),
            );
          });
          print("API Error: $error");
        });
  }

  Future<String> _getApiResponse(String userMessage) async {
    final url = Uri.parse('https://yuvakrish-finance.hf.space/api/chat');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'message': userMessage}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['response'] ??
            "I couldn't understand that. Can you try again?";
      } else {
        print('API Error: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to get response: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception caught: $e');
      throw Exception('Error communicating with the API: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  padding: EdgeInsets.all(10.0),
                  itemCount:
                      _isTyping ? _messages.length + 1 : _messages.length,
                  itemBuilder: (context, index) {
                    if (_isTyping && index == 0) {
                      return TypingIndicator();
                    }
                    return _messages[_isTyping ? index - 1 : index];
                  },
                ),
              ),
              _buildTextComposer(),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey[100],
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(80),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2E3192), Color(0xFF1BFFFF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 5, spreadRadius: 2),
          ],
        ),
        child: SafeArea(
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'ChatBot',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: InputDecoration(
                hintText: 'Type your message...',
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: Color(0xFF2E3192),
            child: IconButton(
              icon: Icon(Icons.send, color: Colors.white),
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isUser ? Colors.blueAccent : Colors.grey[200],
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 1),
            ],
          ),
          child:
              isUser
                  ? Text(
                    text,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )
                  : MarkdownBody(
                    data: text,
                    styleSheet: MarkdownStyleSheet(
                      p: TextStyle(color: Colors.black87, fontSize: 16),
                      code: TextStyle(
                        backgroundColor: Colors.grey[300],
                        fontSize: 14,
                      ),
                      codeblockDecoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    selectable: true,
                  ),
        ),
      ),
    );
  }
}

class TypingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 1),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Typing", style: TextStyle(color: Colors.black54)),
              SizedBox(width: 8),
              SizedBox(
                width: 12,
                height: 12,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black54),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
