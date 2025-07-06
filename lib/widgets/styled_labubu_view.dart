import 'package:flutter/material.dart';
import 'dart:io';
import '../models/labubu_image.dart';
import '../models/labubu_style.dart';

class StyledLabubuView extends StatelessWidget {
  final LabubuImage image;
  final LabubuStyle style;
  final bool isOriginal;

  const StyledLabubuView({
    super.key,
    required this.image,
    required this.style,
    required this.isOriginal,
  });

  Color _getStyleColor(String colorName) {
    switch (colorName) {
      case 'blue':
        return Colors.blue.shade300;
      case 'purple':
        return Colors.purple.shade300;
      case 'yellow':
        return Colors.yellow.shade300;
      case 'green':
        return Colors.green.shade300;
      case 'red':
        return Colors.red.shade300;
      case 'rainbow':
        return Colors.pink.shade300;
      default:
        return Colors.pink.shade300;
    }
  }

  String _getMoodEmoji(String mood) {
    switch (mood) {
      case 'sad':
        return '😢';
      case 'excited':
        return '🤩';
      case 'sleepy':
        return '😴';
      case 'surprised':
        return '😲';
      default:
        return '😊';
    }
  }

  Widget _buildBackground() {
    if (isOriginal) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink.shade50, Colors.purple.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      );
    }

    switch (style.background) {
      case 'stars':
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Positioned.fill(
            child: Center(
              child: Text(
                '✨⭐✨⭐✨',
                style: TextStyle(fontSize: 20, color: Colors.white70),
              ),
            ),
          ),
        );
      case 'hearts':
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pink.shade100, Colors.red.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Positioned.fill(
            child: Center(
              child: Text('💕💖💕💖💕', style: TextStyle(fontSize: 20)),
            ),
          ),
        );
      case 'flowers':
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green.shade100, Colors.yellow.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Positioned.fill(
            child: Center(
              child: Text('🌸🌺🌸🌺🌸', style: TextStyle(fontSize: 20)),
            ),
          ),
        );
      case 'sparkles':
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.cyan.shade100, Colors.purple.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Positioned.fill(
            child: Center(
              child: Text('✨💫✨💫✨', style: TextStyle(fontSize: 20)),
            ),
          ),
        );
      default:
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pink.shade50, Colors.purple.shade50],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        );
    }
  }

  List<Widget> _buildStyleOverlays() {
    if (isOriginal) return [];

    List<Widget> overlays = [];

    // Add outfit overlay
    if (style.outfit != 'simple') {
      overlays.add(
        Positioned(
          bottom: 80,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getStyleColor(style.color).withOpacity(0.8),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Text(
                _getOutfitEmoji(style.outfit),
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
        ),
      );
    }

    // Add accessories overlay
    if (style.accessories != 'none') {
      overlays.add(
        Positioned(
          top: 20,
          right: 20,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              _getAccessoryEmoji(style.accessories),
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
      );
    }

    return overlays;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: SizedBox(
        height: 250,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned.fill(child: _buildBackground()),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: image.isUploaded
                    ? Image.file(
                        File(image.path),
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: Text('📷', style: TextStyle(fontSize: 48)),
                            ),
                          );
                        },
                      )
                    : Image.asset(
                        image.path,
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.pink.shade200,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: Text('🐰', style: TextStyle(fontSize: 48)),
                            ),
                          );
                        },
                      ),
              ),
            ),
            ..._buildStyleOverlays(),
            if (!isOriginal)
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    style.description.length > 40
                        ? '${style.description.substring(0, 40)}...'
                        : style.description,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _getOutfitEmoji(String outfit) {
    switch (outfit) {
      case 'dress':
        return '👗';
      case 'suit':
        return '🤵';
      case 'casual':
        return '👕';
      case 'party':
        return '🎉';
      default:
        return '👚';
    }
  }

  String _getAccessoryEmoji(String accessory) {
    switch (accessory) {
      case 'bow':
        return '🎀';
      case 'hat':
        return '👒';
      case 'glasses':
        return '👓';
      case 'flower':
        return '🌸';
      case 'wings':
        return '🦋';
      default:
        return '';
    }
  }
}
