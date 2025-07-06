class LabubuImage {
  final String id;
  final String path;
  final String name;
  final String description;
  final String emoji;
  final String color;
  final bool isUploaded;

  const LabubuImage({
    required this.id,
    required this.path,
    required this.name,
    required this.description,
    required this.emoji,
    required this.color,
    this.isUploaded = false,
  });

  static List<LabubuImage> getAvailableImages() {
    return [
      const LabubuImage(
        id: 'labubu_classic',
        path: 'assets/labubu_images/550x550.jpg',
        name: 'Classic Labubu',
        description: 'Original pink Labubu with simple outfit',
        emoji: '🐰💗',
        color: 'pink',
      ),
      const LabubuImage(
        id: 'labubu_happy',
        path: 'assets/labubu_images/550x550 (1).jpg',
        name: 'Happy Labubu',
        description: 'Cheerful Labubu with big smile',
        emoji: '🐰😊',
        color: 'yellow',
      ),
      const LabubuImage(
        id: 'labubu_cute',
        path: 'assets/labubu_images/550x550 (2).jpg',
        name: 'Cute Labubu',
        description: 'Adorable Labubu with bow tie',
        emoji: '🐰🎀',
        color: 'purple',
      ),
      const LabubuImage(
        id: 'labubu_sleepy',
        path: 'assets/labubu_images/550x550 (3).jpg',
        name: 'Sleepy Labubu',
        description: 'Peaceful Labubu with sleepy eyes',
        emoji: '🐰😴',
        color: 'blue',
      ),
      const LabubuImage(
        id: 'labubu_party',
        path: 'assets/labubu_images/550x550 (4).jpg',
        name: 'Party Labubu',
        description: 'Festive Labubu ready to party',
        emoji: '🐰🎉',
        color: 'rainbow',
      ),
    ];
  }
}