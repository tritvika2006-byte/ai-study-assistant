import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/gemini_service.dart';

class SummaryScreen extends StatefulWidget {

  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() =>
      _SummaryScreenState();
}

class _SummaryScreenState
    extends State<SummaryScreen> {

  final TextEditingController controller =
  TextEditingController();

  final GeminiService geminiService =
  GeminiService();

  String summary = '';

  bool isLoading = false;

  String selectedMode = 'Medium';

  Future<void> summarizeText() async {

    FocusScope.of(context).unfocus();

    if (controller.text.trim().isEmpty) return;

    setState(() {
      isLoading = true;
      summary = '';
    });

    final prompt = '''

Summarize the following notes in a $selectedMode style.

Rules:
- Use bullet points
- Keep it student friendly
- Highlight important concepts
- Keep formatting clean

Notes:
${controller.text}

''';

    final result =
    await geminiService.generateResponse(prompt);

    setState(() {
      summary = result;
      isLoading = false;
    });
  }

  void copySummary() {

    Clipboard.setData(
      ClipboardData(text: summary),
    );

    ScaffoldMessenger.of(context).showSnackBar(

      const SnackBar(
        content: Text("Summary copied"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFF0F0F1A),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F1A),
        title: const Text("Summarize Notes"),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            const Text(
              "AI Notes Summarizer",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Convert long notes into easy points",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 30),

            Row(

              children: [

                modeChip("Short"),
                const SizedBox(width: 10),

                modeChip("Medium"),
                const SizedBox(width: 10),

                modeChip("Detailed"),
              ],
            ),

            const SizedBox(height: 25),

            TextField(

              controller: controller,

              maxLines: 10,

              style:
              const TextStyle(color: Colors.white),

              decoration: InputDecoration(

                hintText: "Paste your notes here...",

                hintStyle:
                const TextStyle(color: Colors.grey),

                filled: true,

                fillColor:
                const Color(0xFF1B1B2D),

                border: OutlineInputBorder(

                  borderRadius:
                  BorderRadius.circular(20),

                  borderSide: BorderSide.none,
                ),

                contentPadding:
                const EdgeInsets.all(20),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(

              width: double.infinity,
              height: 58,

              child: ElevatedButton(

                onPressed:
                isLoading ? null : summarizeText,

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
                      ? "Summarizing..."
                      : "Generate Summary",

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

            if (summary.isNotEmpty)

              Container(

                width: double.infinity,

                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(

                  color:
                  const Color(0xFF1B1B2D),

                  borderRadius:
                  BorderRadius.circular(20),
                ),

                child: Column(

                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    Row(

                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                      children: [

                        const Text(
                          "Summary",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                        IconButton(

                          onPressed: copySummary,

                          icon: const Icon(
                            Icons.copy,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    Text(

                      summary,

                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        height: 1.7,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget modeChip(String mode) {

    final bool isSelected =
        selectedMode == mode;

    return GestureDetector(

      onTap: () {

        setState(() {
          selectedMode = mode;
        });
      },

      child: Container(

        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 10,
        ),

        decoration: BoxDecoration(

          color: isSelected
              ? const Color(0xFF8B5CF6)
              : const Color(0xFF1B1B2D),

          borderRadius:
          BorderRadius.circular(30),
        ),

        child: Text(

          mode,

          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}