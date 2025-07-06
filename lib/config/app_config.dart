class AppConfig {
  // RevenueCat API Key
  // Get this from https://app.revenuecat.com
  static const String revenueCatApiKey = 'YOUR_REVENUECAT_API_KEY';
  
  // Cloud Functions URL
  // Get this after deploying Firebase functions
  // Format: https://REGION-PROJECT_ID.cloudfunctions.net
  static const String cloudFunctionsUrl = 'https://YOUR-REGION-YOUR-PROJECT.cloudfunctions.net';
  
  // OpenAI Configuration (only for development/testing)
  // WARNING: Never put API keys directly in client code for production!
  // In production, use Cloud Functions to protect your API key
  static const String openAiApiKey = 'YOUR_OPENAI_API_KEY'; // DO NOT USE IN PRODUCTION
  
  // App Settings
  static const int freeCreditsOnSignup = 3;
  static const double creditCostEuro = 0.35; // Cost per image generation
  
  // Development mode flag
  static const bool isDevelopment = true; // TODO: Set to false before App Store submission
}