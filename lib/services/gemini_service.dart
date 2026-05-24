import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {

  final String apiKey = 'paste-api-key';

  Future<String> generateResponse(String prompt) async {

    final url = Uri.parse(
      'https://openrouter.ai/api/v1/chat/completions',
    );

    try {

      final response = await http.post(
        url,

        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },

        body: jsonEncode({

          "model": "openai/gpt-3.5-turbo",

          "messages": [
            {
              "role": "user",
              "content": prompt
            }
          ]

        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {

        return data['choices'][0]['message']['content'];

      } else {

        return 'Error: ${response.body}';
      }

    } catch (e) {

      return 'Error: $e';
    }
  }
}

