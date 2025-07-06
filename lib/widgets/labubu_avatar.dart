import 'package:flutter/material.dart';
import '../models/labubu_style.dart';

class LabubuAvatar extends StatelessWidget {
  final LabubuStyle style;

  const LabubuAvatar({super.key, required this.style});

  Color _getColor(String colorName) {
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
          child: const Center(
            child: Text('✨⭐✨⭐✨', style: TextStyle(fontSize: 24)),
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
          child: const Center(
            child: Text('💕💖💕💖💕', style: TextStyle(fontSize: 24)),
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
          child: const Center(
            child: Text('🌸🌺🌸🌺🌸', style: TextStyle(fontSize: 24)),
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
          child: const Center(
            child: Text('✨💫✨💫✨', style: TextStyle(fontSize: 24)),
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

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: SizedBox(
        height: 300,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned.fill(child: _buildBackground()),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: _getColor(style.color),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('🐰', style: TextStyle(fontSize: 40)),
                          Text(
                            _getMoodEmoji(style.mood),
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Text(
                          _getOutfitEmoji(style.outfit),
                          style: const TextStyle(fontSize: 24),
                        ),
                        if (style.accessories != 'none')
                          Text(
                            _getAccessoryEmoji(style.accessories),
                            style: const TextStyle(fontSize: 20),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      style.description.length > 30
                          ? '${style.description.substring(0, 30)}...'
                          : style.description,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
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
