import 'package:flutter/material.dart';
import '../services/gemini_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController controller = TextEditingController();

  final GeminiService geminiService = GeminiService();

  String response = '';

  bool isLoading = false;

  Future<void> askAI() async {
    setState(() {
      isLoading = true;
    });

    final result = await geminiService.generateResponse(
      controller.text,
    );

    setState(() {
      response = result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Ask AI'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
                children: [
                TextField(
                controller: controller,
                maxLines: 5,
                  textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: 'Ask something...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () async {

                      // Hide keyboard
                      FocusScope.of(context).unfocus();

                      // Show loading
                      setState(() {
                        isLoading = true;
                      });

                      // Get AI response
                      final result =
                      await geminiService.generateResponse(controller.text);

                      // Update screen
                      setState(() {
                        response = result;
                        isLoading = false;
                      });
                    },

                    child: const Text('Generate'),
                  ),

                  const SizedBox(height: 20),

                  if (isLoading)
                    const CircularProgressIndicator(),

                  if (!isLoading)
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          response,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                ],
            ),
        ),
    );
  }
}
