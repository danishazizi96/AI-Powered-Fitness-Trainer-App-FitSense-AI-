import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isTyping = false; // Variable to track bot typing status

  Future<void> _sendMessage(String message) async {
    setState(() {
      _messages.add({'sender': 'user', 'message': message});
      _isTyping = true; // Show typing indicator
    });

    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Authorization': '{secret key}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': 'gpt-4',
          'messages': [
            {
              'role': 'system',
              'content': 'You are a fitness trainer named "Fit". You are tasked with providing helpful fitness tips, and provide workout plans (according to their age, weight, experience and goals. Do not answer any questions that is not related to fitness. Act naturally like a proper fitness trainer. not too Ai-like)'
            },
            ..._messages.map((msg) => {
              'role': msg['sender'] == 'user' ? 'user' : 'assistant',
              'content': msg['message']
            }),
            {'role': 'user', 'content': message},
          ],
          'max_tokens': 150,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String reply = data['choices'][0]['message']['content'];

        setState(() {
          _messages.add({'sender': 'bot', 'message': reply});
          _isTyping = false; // Hide typing indicator
        });
      } else {
        setState(() {
          _messages.add({
            'sender': 'bot',
            'message': 'Failed to get a response. Please try again.'
          });
          _isTyping = false; // Hide typing indicator
        });
      }
    } catch (e) {
      setState(() {
        _messages.add({
          'sender': 'bot',
          'message': 'An error occurred. Please try again.'
        });
        _isTyping = false; // Hide typing indicator
      });
    }
  }

  void _handlePromptSelected(String prompt) {
    _sendMessage(prompt);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FitSense Powered by GPT-4'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length + (_isTyping ? 1 : 0), // Add extra item for typing indicator
              itemBuilder: (context, index) {
                if (index == _messages.length) {
                  // Show typing indicator
                  return ListTile(
                    title: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 172, 108, 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text('Fit is typing...', style: TextStyle(color: Colors.white)),
                            SizedBox(width: 5),
                            CircularProgressIndicator(
                              strokeWidth: 2.0,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                final message = _messages[index];
                return ListTile(
                  title: Align(
                    alignment: message['sender'] == 'user'
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: message['sender'] == 'user'
                            ? Color.fromARGB(255, 255, 145, 49)
                            : Color.fromARGB(255, 255, 179, 112),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        message['message'] ?? '',
                        style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SuggestedPrompts(onPromptSelected: _handlePromptSelected),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: 'Enter your message',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        if (_controller.text.isNotEmpty) {
                          _sendMessage(_controller.text);
                          _controller.clear();
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SuggestedPrompts extends StatelessWidget {
  final Function(String) onPromptSelected;

  const SuggestedPrompts({required this.onPromptSelected, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prompts = [
      'What arm workouts can I do today?',
      'I have a Smith Machine. What kind of workout can I do?',
      'I am taking Creatine. How much should I take?',
      'I want to go on a run. How long should I run?',
    
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'What to ask Today :',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: prompts.map((prompt) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ElevatedButton(
                  onPressed: () => onPromptSelected(prompt),
                  child: Text(prompt),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
