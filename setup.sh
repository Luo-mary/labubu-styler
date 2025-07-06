#!/bin/bash

echo "🚀 Labubu Styler Setup Script"
echo "============================"

# Check if Firebase CLI is installed
if ! command -v firebase &> /dev/null; then
    echo "❌ Firebase CLI not found. Installing..."
    npm install -g firebase-tools
else
    echo "✅ Firebase CLI found"
fi

# Login to Firebase
echo "📱 Logging into Firebase..."
firebase login

# Initialize Firebase
echo "🔧 Initializing Firebase..."
firebase init

# Install Flutter dependencies
echo "📦 Installing Flutter dependencies..."
flutter pub get

# Install Cloud Functions dependencies
echo "☁️ Installing Cloud Functions dependencies..."
cd functions
npm install
cd ..

# Set up environment variables
echo "🔑 Setting up environment variables..."
echo "Please enter your OpenAI API key:"
read -s OPENAI_KEY
firebase functions:config:set openai.key="$OPENAI_KEY"

echo "Please enter your Stripe Secret key (or press Enter to skip):"
read -s STRIPE_KEY
if [ ! -z "$STRIPE_KEY" ]; then
    firebase functions:config:set stripe.secret="$STRIPE_KEY"
fi

echo "Please enter your RevenueCat API key (or press Enter to skip):"
read -s REVENUECAT_KEY

# Create Firebase configuration file
echo "📝 Creating Firebase configuration..."
cat > lib/config/firebase_config.dart << EOL
class FirebaseConfig {
  static const String functionsUrl = 'YOUR_CLOUD_FUNCTIONS_URL';
  static const String revenueCatApiKey = '$REVENUECAT_KEY';
}
EOL

# Deploy Firestore rules
echo "🔒 Deploying Firestore security rules..."
cat > firestore.rules << 'EOL'
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can only read/write their own data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Transactions are private to users
    match /transactions/{transactionId} {
      allow read: if request.auth != null && request.auth.uid == resource.data.userId;
      allow write: if false; // Only backend can write
    }
    
    // Generated images are private to users
    match /generated_images/{imageId} {
      allow read: if request.auth != null && request.auth.uid == resource.data.userId;
      allow write: if false; // Only backend can write
    }
    
    // Credit packages are public read
    match /credit_packages/{packageId} {
      allow read: if true;
      allow write: if false; // Only admin can write
    }
  }
}
EOL

# Deploy Storage rules
echo "📁 Deploying Storage rules..."
cat > storage.rules << 'EOL'
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    // Users can only access their own images
    match /users/{userId}/generated/{allPaths=**} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    match /users/{userId}/original/{allPaths=**} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
EOL

# Deploy to Firebase
echo "🚀 Deploying to Firebase..."
firebase deploy

echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Add GoogleService-Info.plist to ios/Runner/"
echo "2. Update the Cloud Functions URL in lib/config/firebase_config.dart"
echo "3. Configure RevenueCat products in the dashboard"
echo "4. Set up payment methods (Stripe/Apple Pay/Google Pay)"
echo "5. Run 'flutter run' to test the app"