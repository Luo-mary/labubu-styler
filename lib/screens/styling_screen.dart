import 'package:flutter/material.dart';
import 'dart:io';
import '../models/labubu_image.dart';
import '../models/labubu_style.dart';
import '../widgets/ai_generated_image.dart';
import '../services/openai_service.dart';

class StylingScreen extends StatefulWidget {
  final LabubuImage selectedImage;

  const StylingScreen({
    super.key,
    required this.selectedImage,
  });

  @override
  State<StylingScreen> createState() => _StylingScreenState();
}

class _StylingScreenState extends State<StylingScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final OpenAIService _openAIService = OpenAIService();
  
  LabubuStyle _currentStyle = LabubuStyle.defaultStyle();
  bool _isGenerating = false;
  String? _generatedImageUrl;
  String? _errorMessage;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _updateStyleFromDescription() {
    if (_descriptionController.text.trim().isEmpty) return;
    
    setState(() {
      _currentStyle = LabubuStyle.fromDescription(_descriptionController.text);
    });
  }

  Future<void> _generateAIImage() async {
    if (_descriptionController.text.trim().isEmpty) {
      setState(() {
        _errorMessage = 'Please describe the style you want';
      });
      return;
    }

    setState(() {
      _isGenerating = true;
      _generatedImageUrl = null;
      _errorMessage = null;
    });

    try {
      final imageUrl = await _openAIService.generateLabubuStyle(
        originalImagePath: widget.selectedImage.path,
        styleDescription: _descriptionController.text,
      );
      
      if (mounted) {
        setState(() {
          _generatedImageUrl = imageUrl;
          _isGenerating = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Failed to generate image: $e';
          _isGenerating = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Style Your Labubu',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Original Image Preview
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Original Labubu:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: widget.selectedImage.isUploaded
                            ? Image.file(
                                File(widget.selectedImage.path),
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                widget.selectedImage.path,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.selectedImage.name,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Style Description Input
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Describe your style:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _descriptionController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: 'e.g., wearing a superhero costume with cape, magical sparkles, rainbow background...',
                        border: OutlineInputBorder(),
                        filled: true,
                      ),
                      onChanged: (_) => _updateStyleFromDescription(),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _isGenerating ? null : _generateAIImage,
                        icon: _isGenerating
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Icon(Icons.auto_awesome),
                        label: Text(_isGenerating ? 'Generating...' : 'Generate AI Image'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Error Message
            if (_errorMessage != null) ...[
              const SizedBox(height: 16),
              Card(
                color: Colors.red.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red.shade700),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: TextStyle(color: Colors.red.shade700),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            
            // Style Preview
            const SizedBox(height: 24),
            const Text(
              'Style Preview:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.color_lens, color: Theme.of(context).colorScheme.primary),
                        const SizedBox(width: 8),
                        Text('Color: ${_currentStyle.color}'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.mood, color: Theme.of(context).colorScheme.primary),
                        const SizedBox(width: 8),
                        Text('Mood: ${_currentStyle.mood}'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.landscape, color: Theme.of(context).colorScheme.primary),
                        const SizedBox(width: 8),
                        Text('Background: ${_currentStyle.background}'),
                      ],
                    ),
                    if (_currentStyle.accessories.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.auto_awesome, color: Theme.of(context).colorScheme.primary),
                          const SizedBox(width: 8),
                          Text('Accessories: ${_currentStyle.accessories}'),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
            
            // AI Generated Image
            if (_generatedImageUrl != null) ...[
              const SizedBox(height: 24),
              const Text(
                'AI Generated Result:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              AIGeneratedImage(imagePath: _generatedImageUrl!),
            ],
          ],
        ),
      ),
    );
  }
}