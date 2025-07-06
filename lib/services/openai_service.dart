import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' as http_parser;
import 'package:path_provider/path_provider.dart';

class OpenAIService {
  static const String _baseUrl = 'https://api.openai.com/v1/images/generations';
  static const String _editUrl = 'https://api.openai.com/v1/images/edits';
  static const String _apiKey = 'YOUR_OPENAI_API_KEY'; // Replace with your actual OpenAI API key

  Future<String?> generateImage({
    required String prompt,
    int retryCount = 0,
  }) async {
    try {
      final url = Uri.parse(_baseUrl);
      print('Requesting: $url');
      print('Prompt: $prompt');
      print('Retry count: $retryCount');

      final response = await http
          .post(
            url,
            headers: {
              'Authorization': 'Bearer $_apiKey',
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'model': 'gpt-image-1',
              'prompt': prompt,
              'n': 1,
            }),
          )
          .timeout(const Duration(seconds: 90));

      print('Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Full response: $responseData');

        // Check if we have a URL or base64
        final imageData = responseData['data'][0];
        String? imageUrl = imageData['url'];
        String? b64Json = imageData['b64_json'];

        print('Image URL: $imageUrl');
        print('Has b64_json: ${b64Json != null}');

        Uint8List bytes;

        if (imageUrl != null) {
          // Download the image from URL
          final imageResponse = await http.get(Uri.parse(imageUrl));
          if (imageResponse.statusCode == 200) {
            bytes = imageResponse.bodyBytes;
          } else {
            print('Failed to download image: ${imageResponse.statusCode}');
            return null;
          }
        } else if (b64Json != null) {
          // Decode base64 image
          bytes = base64Decode(b64Json);
        } else {
          print('No image URL or base64 data found in response');
          return null;
        }

        print('Image size: ${bytes.length} bytes');
        // Save image to local storage
        final imagePath = await _saveImageToStorage(bytes);
        print('Image saved to: $imagePath');
        return imagePath;
      } else {
        print('Error generating image: ${response.statusCode}');
        print('Response body: ${response.body}');

        // Parse error message if it's JSON
        try {
          final errorData = jsonDecode(response.body);
          print('Error details: $errorData');
        } catch (_) {
          // Not JSON, just print as is
        }

        return null;
      }
    } catch (e, stackTrace) {
      print('Exception in generateImage: $e');
      print('Stack trace: $stackTrace');
      return null;
    }
  }

  Future<String?> generateLabubuStyle({
    required String originalImagePath,
    required String styleDescription,
  }) async {
    try {
      // Load the original image as bytes
      Uint8List imageBytes;
      if (originalImagePath.startsWith('assets/')) {
        // Load from assets
        final byteData = await rootBundle.load(originalImagePath);
        imageBytes = byteData.buffer.asUint8List();
      } else {
        // Load from file system
        final file = File(originalImagePath);
        imageBytes = await file.readAsBytes();
      }

      // Create a detailed prompt for the edit
      final prompt = _createEditPrompt(styleDescription);

      // Use OpenAI's images.edit endpoint
      return await _editImage(imageBytes: imageBytes, prompt: prompt);
    } catch (e) {
      print('Error in generateLabubuStyle: $e');
      return null;
    }
  }

  Future<String?> _editImage({
    required Uint8List imageBytes,
    required String prompt,
  }) async {
    try {
      final url = Uri.parse(_editUrl);
      print('Requesting image edit: $url');
      print('Prompt: $prompt');

      // Create multipart request
      final request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer $_apiKey';

      // Add the image file with proper content type
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          imageBytes,
          filename: 'labubu.png',
          contentType: http_parser.MediaType('image', 'png'),
        ),
      );

      // Add other fields
      request.fields['model'] = 'gpt-image-1';
      request.fields['prompt'] = prompt;
      request.fields['n'] = '1';

      // Send request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print('Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Edit response: $responseData');

        // Check if we have a URL or base64
        final imageData = responseData['data'][0];
        String? imageUrl = imageData['url'];
        String? b64Json = imageData['b64_json'];

        print('Edited image URL: $imageUrl');
        print('Has b64_json: ${b64Json != null}');

        Uint8List bytes;

        if (imageUrl != null) {
          // Download the edited image
          final imageResponse = await http.get(Uri.parse(imageUrl));
          if (imageResponse.statusCode == 200) {
            bytes = imageResponse.bodyBytes;
          } else {
            print(
              'Failed to download edited image: ${imageResponse.statusCode}',
            );
            return null;
          }
        } else if (b64Json != null) {
          // Decode base64 image
          bytes = base64Decode(b64Json);
        } else {
          print('No image URL or base64 data found in edit response');
          return null;
        }

        print('Edited image size: ${bytes.length} bytes');
        // Save image to local storage
        final imagePath = await _saveImageToStorage(bytes);
        print('Edited image saved to: $imagePath');
        return imagePath;
      } else {
        print('Error editing image: ${response.statusCode}');
        print('Response body: ${response.body}');
        return null;
      }
    } catch (e, stackTrace) {
      print('Exception in _editImage: $e');
      print('Stack trace: $stackTrace');
      return null;
    }
  }

  String _createEditPrompt(String userStyle) {
    // Create a prompt specifically for editing the existing Labubu image
    return 'Transform this Labubu plush toy by $userStyle. '
        'Keep the same Labubu character and pose, but apply the new style. '
        'Maintain the plush toy aesthetic and cute character features. '
        'High quality product photography style on white background.';
  }

  Map<String, String> _extractCharacterInfo(String imagePath) {
    // Map of image paths to character descriptions
    final characterDescriptions = {
      '550x550.jpg': {
        'name': 'Classic Pink Labubu',
        'features':
            'Labubu plush toy with pink soft fur, round bunny ears, small eyes',
        'color': 'soft pink',
      },
      '550x550 (1).jpg': {
        'name': 'Happy Yellow Labubu',
        'features':
            'Labubu plush doll with yellow fur, smiling face, bunny ears',
        'color': 'bright yellow',
      },
      '550x550 (2).jpg': {
        'name': 'Cute Purple Labubu',
        'features':
            'Labubu rabbit plush with purple fur, bow accessory, round ears',
        'color': 'lavender purple',
      },
      '550x550 (3).jpg': {
        'name': 'Sleepy Blue Labubu',
        'features':
            'Labubu bunny toy with blue fur, sleepy expression, floppy ears',
        'color': 'soft blue',
      },
      '550x550 (4).jpg': {
        'name': 'Party Rainbow Labubu',
        'features':
            'Labubu plush character with colorful fur, party hat, bunny ears',
        'color': 'rainbow colors',
      },
    };

    // Extract filename from path
    final fileName = imagePath.split('/').last;
    return characterDescriptions[fileName] ??
        {
          'name': 'Labubu character',
          'features': 'cute bunny-like creature with round ears',
          'color': 'pastel colors',
        };
  }

  String _createDetailedPrompt(
    Map<String, String> characterInfo,
    String userStyle,
  ) {
    // Create a highly detailed prompt that preserves character identity
    return 'A cute Labubu plush toy character, ${characterInfo['features']}, '
        'in ${characterInfo['color']} color scheme, '
        '$userStyle, '
        'Labubu is a small rabbit-like plush toy with round bunny ears, '
        'chubby body, cute facial features with small eyes and tiny mouth, '
        'kawaii style plush doll, soft toy aesthetic, '
        'high quality product photography, white background, '
        'maintaining the original Labubu toy design';
  }

  Future<String> _saveImageToStorage(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final filePath = '${directory.path}/generated_labubu_$timestamp.png';

    final file = File(filePath);
    await file.writeAsBytes(bytes);
    return filePath;
  }

  // Check if API key is configured
  bool get isConfigured =>
      _apiKey != 'YOUR_OPENAI_API_KEY' && _apiKey.isNotEmpty;

  // Get API key instructions
  String get apiKeyInstructions => '''
To use AI image generation, you need an OpenAI API key:

1. Go to https://platform.openai.com/
2. Sign up or log in to your account
3. Go to API Keys section
4. Create new secret key
5. Replace YOUR_OPENAI_API_KEY in openai_service.dart

Note: OpenAI API requires a paid account with credits.
''';
}
