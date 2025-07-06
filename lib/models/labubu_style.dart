class LabubuStyle {
  final String description;
  final String outfit;
  final String accessories;
  final String color;
  final String mood;
  final String background;

  const LabubuStyle({
    required this.description,
    required this.outfit,
    required this.accessories,
    required this.color,
    required this.mood,
    required this.background,
  });

  static LabubuStyle defaultStyle() {
    return const LabubuStyle(
      description: 'Default cute Labubu',
      outfit: 'simple',
      accessories: 'none',
      color: 'pink',
      mood: 'happy',
      background: 'plain',
    );
  }

  static LabubuStyle fromDescription(String description) {
    final lowerDesc = description.toLowerCase();

    String outfit = 'simple';
    if (lowerDesc.contains('dress')) {
      outfit = 'dress';
    } else if (lowerDesc.contains('suit'))
      outfit = 'suit';
    else if (lowerDesc.contains('casual'))
      outfit = 'casual';
    else if (lowerDesc.contains('party'))
      outfit = 'party';

    String accessories = 'none';
    if (lowerDesc.contains('bow') || lowerDesc.contains('ribbon')) {
      accessories = 'bow';
    } else if (lowerDesc.contains('hat'))
      accessories = 'hat';
    else if (lowerDesc.contains('glasses'))
      accessories = 'glasses';
    else if (lowerDesc.contains('flower'))
      accessories = 'flower';
    else if (lowerDesc.contains('wings'))
      accessories = 'wings';

    String color = 'pink';
    if (lowerDesc.contains('blue')) {
      color = 'blue';
    } else if (lowerDesc.contains('purple'))
      color = 'purple';
    else if (lowerDesc.contains('yellow'))
      color = 'yellow';
    else if (lowerDesc.contains('green'))
      color = 'green';
    else if (lowerDesc.contains('red'))
      color = 'red';
    else if (lowerDesc.contains('rainbow'))
      color = 'rainbow';

    String mood = 'happy';
    if (lowerDesc.contains('sad')) {
      mood = 'sad';
    } else if (lowerDesc.contains('excited'))
      mood = 'excited';
    else if (lowerDesc.contains('sleepy'))
      mood = 'sleepy';
    else if (lowerDesc.contains('surprised'))
      mood = 'surprised';

    String background = 'plain';
    if (lowerDesc.contains('star')) {
      background = 'stars';
    } else if (lowerDesc.contains('heart'))
      background = 'hearts';
    else if (lowerDesc.contains('flower'))
      background = 'flowers';
    else if (lowerDesc.contains('sparkle'))
      background = 'sparkles';

    return LabubuStyle(
      description: description,
      outfit: outfit,
      accessories: accessories,
      color: color,
      mood: mood,
      background: background,
    );
  }

  LabubuStyle copyWith({
    String? description,
    String? outfit,
    String? accessories,
    String? color,
    String? mood,
    String? background,
  }) {
    return LabubuStyle(
      description: description ?? this.description,
      outfit: outfit ?? this.outfit,
      accessories: accessories ?? this.accessories,
      color: color ?? this.color,
      mood: mood ?? this.mood,
      background: background ?? this.background,
    );
  }
}
