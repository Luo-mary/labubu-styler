import 'package:flutter/material.dart';
import 'dart:io';
import '../models/labubu_image.dart';
import 'styling_screen.dart';
import 'package:image_picker/image_picker.dart';

class ImageGalleryScreen extends StatefulWidget {
  const ImageGalleryScreen({super.key});

  @override
  State<ImageGalleryScreen> createState() => _ImageGalleryScreenState();
}

class _ImageGalleryScreenState extends State<ImageGalleryScreen> {
  final ImagePicker _picker = ImagePicker();
  List<LabubuImage> images = [];
  
  @override
  void initState() {
    super.initState();
    images = LabubuImage.getAvailableImages();
  }
  
  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1080,
        maxHeight: 1080,
        imageQuality: 90,
      );
      
      if (pickedFile != null) {
        // Create a custom LabubuImage for the uploaded file
        final uploadedImage = LabubuImage(
          id: 'uploaded_${DateTime.now().millisecondsSinceEpoch}',
          name: 'My Custom Labubu',
          path: pickedFile.path,
          description: 'Uploaded by user',
          color: 'custom',
          emoji: '📷',
          isUploaded: true,
        );
        
        // Navigate to styling screen with the uploaded image
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StylingScreen(selectedImage: uploadedImage),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to pick image: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Choose Your Labubu',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        elevation: 0,
        actions: const [
          SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select a Labubu to style:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // Upload button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.upload_file),
                label: const Text('Upload Your Own Image'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  foregroundColor: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Or choose from our collection:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.9,
                ),
                itemCount: images.length,
                itemBuilder: (context, index) {
                  final image = images[index];
                  return _buildImageCard(context, image);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCard(BuildContext context, LabubuImage image) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StylingScreen(selectedImage: image),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: image.isUploaded
                          ? Image.file(
                              File(image.path),
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: _getGradientColors(image.color),
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        color: _getMainColor(image.color),
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.white, width: 3),
                                      ),
                                      child: Center(
                                        child: Text(
                                          image.emoji,
                                          style: const TextStyle(fontSize: 32),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          : Image.asset(
                              image.path,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: _getGradientColors(image.color),
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        color: _getMainColor(image.color),
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.white, width: 3),
                                      ),
                                      child: Center(
                                        child: Text(
                                          image.emoji,
                                          style: const TextStyle(fontSize: 32),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          image.emoji,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    image.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    image.description,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Color> _getGradientColors(String colorName) {
    switch (colorName) {
      case 'pink':
        return [Colors.pink.shade50, Colors.pink.shade100];
      case 'yellow':
        return [Colors.yellow.shade50, Colors.amber.shade100];
      case 'purple':
        return [Colors.purple.shade50, Colors.purple.shade100];
      case 'blue':
        return [Colors.blue.shade50, Colors.cyan.shade100];
      case 'rainbow':
        return [Colors.pink.shade50, Colors.purple.shade50, Colors.blue.shade50];
      case 'custom':
        return [Colors.grey.shade50, Colors.grey.shade100];
      default:
        return [Colors.pink.shade50, Colors.purple.shade50];
    }
  }

  Color _getMainColor(String colorName) {
    switch (colorName) {
      case 'pink':
        return Colors.pink.shade200;
      case 'yellow':
        return Colors.amber.shade200;
      case 'purple':
        return Colors.purple.shade200;
      case 'blue':
        return Colors.blue.shade200;
      case 'rainbow':
        return Colors.pink.shade200;
      case 'custom':
        return Colors.grey.shade300;
      default:
        return Colors.pink.shade200;
    }
  }
}