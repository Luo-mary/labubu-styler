class CreditPackage {
  final String id;
  final String name;
  final int credits;
  final double price;
  final double pricePerCredit;
  final String? badge; // e.g., "Best Value", "Popular"
  
  const CreditPackage({
    required this.id,
    required this.name,
    required this.credits,
    required this.price,
    required this.pricePerCredit,
    this.badge,
  });
  
  // Predefined packages
  static const List<CreditPackage> packages = [
    CreditPackage(
      id: 'starter',
      name: 'Starter Pack',
      credits: 5,
      price: 4.99,
      pricePerCredit: 0.998,
    ),
    CreditPackage(
      id: 'popular',
      name: 'Popular Pack',
      credits: 20,
      price: 17.99,
      pricePerCredit: 0.899,
      badge: 'Most Popular',
    ),
    CreditPackage(
      id: 'pro',
      name: 'Pro Pack',
      credits: 50,
      price: 39.99,
      pricePerCredit: 0.799,
      badge: 'Best Value',
    ),
    CreditPackage(
      id: 'mega',
      name: 'Mega Pack',
      credits: 100,
      price: 69.99,
      pricePerCredit: 0.699,
      badge: 'Save 30%',
    ),
  ];
  
  // Calculate savings percentage compared to single credit price (1 euro)
  double get savingsPercentage => ((1.0 - pricePerCredit) * 100).roundToDouble();
}