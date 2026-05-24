import 'package:flutter/material.dart';

import '../services/gemini_service.dart';

class QuizScreen extends StatefulWidget {

  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {

  final TextEditingController topicController =
  TextEditingController();

  final TextEditingController numberController =
  TextEditingController();

  final GeminiService geminiService = GeminiService();

  String quiz = '';

  bool isLoading = false;

  Future<void> generateQuiz() async {

    FocusScope.of(context).unfocus();

    final topic = topicController.text.trim();

    final number = numberController.text.trim();

    if (topic.isEmpty || number.isEmpty) return;

    setState(() {
      isLoading = true;
      quiz = '';
    });

    final prompt = '''

Generate $number multiple choice questions about $topic.

Rules:
- Each question should have 4 options
- Mark the correct answer
- Keep explanations short
- Format neatly

Example:

1. Question

A)
B)
C)
D)

Answer: B

''';

    final result =
    await geminiService.generateResponse(prompt);

    setState(() {
      quiz = result;
      isLoading = false;
    });
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFF0F0F1A),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F1A),
        title: const Text("Quiz Generator"),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(
              "Generate AI Quizzes",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Create custom quizzes instantly",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 30),

            TextField(

              controller: topicController,

              style: const TextStyle(color: Colors.white),

              decoration: InputDecoration(

                hintText: "Enter topic",

                hintStyle:
                const TextStyle(color: Colors.grey),

                filled: true,

                fillColor: const Color(0xFF1B1B2D),

                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),

                contentPadding:
                const EdgeInsets.all(18),
              ),
            ),

            const SizedBox(height: 20),

            TextField(

              controller: numberController,

              keyboardType: TextInputType.number,

              style: const TextStyle(color: Colors.white),

              decoration: InputDecoration(

                hintText: "Number of Questions",

                hintStyle:
                const TextStyle(color: Colors.grey),

                filled: true,

                fillColor: const Color(0xFF1B1B2D),

                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),

                contentPadding:
                const EdgeInsets.all(18),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(

              width: double.infinity,
              height: 58,

              child: ElevatedButton(

                onPressed:
                isLoading ? null : generateQuiz,

                style: ElevatedButton.styleFrom(

                  backgroundColor:
                  const Color(0xFF8B5CF6),

                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(18),
                  ),
                ),

                child: Text(

                  isLoading
                      ? "Generating..."
                      : "Generate Quiz",

                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            if (isLoading)

              const Center(
                child: CircularProgressIndicator(),
              ),

            if (quiz.isNotEmpty)

              Container(

                width: double.infinity,

                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(

                  color: const Color(0xFF1B1B2D),

                  borderRadius:
                  BorderRadius.circular(20),
                ),

                child: Text(

                  quiz,

                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    height: 1.7,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}