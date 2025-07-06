# App Store Submission Checklist for Labubu Styler

## 🚀 Pre-Submission Checklist

### 1. ✅ Complete Your App Features
- [x] User authentication (Email/Phone)
- [x] Image generation with OpenAI
- [x] Credit system
- [x] Payment processing (Stripe)
- [ ] Test all features thoroughly
- [ ] Fix any remaining bugs

### 2. 🔐 Security & Production Setup

#### Switch to Production Mode:
```dart
// lib/config/app_config.dart
static const bool isDevelopment = false; // CHANGE THIS
```

#### Update API Keys (if using production):
- [ ] Get production Stripe keys (live mode)
- [ ] Update Vercel with production keys
- [ ] Ensure OpenAI API has sufficient credits

### 3. 📱 iOS Specific Requirements

#### Update Info.plist:
```xml
<!-- ios/Runner/Info.plist -->

<!-- Camera Usage (for image picker) -->
<key>NSCameraUsageDescription</key>
<string>Labubu Styler needs camera access to take photos for styling</string>

<!-- Photo Library Usage -->
<key>NSPhotoLibraryUsageDescription</key>
<string>Labubu Styler needs access to your photos to select images for styling</string>

<!-- Network Usage -->
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <false/>
</dict>
```

#### Update App Display Name:
```xml
<!-- ios/Runner/Info.plist -->
<key>CFBundleDisplayName</key>
<string>Labubu Styler</string>
```

### 4. 🎨 App Store Assets

Create these in **Figma/Photoshop**:

#### App Icon (Required):
- 1024x1024px (App Store)
- No transparency
- No rounded corners (Apple adds them)

#### Screenshots (Required):
- iPhone 6.7" (1290 x 2796px) - iPhone 15 Pro Max
- iPhone 6.5" (1242 x 2688px) - iPhone 11 Pro Max
- iPhone 5.5" (1242 x 2208px) - iPhone 8 Plus
- iPad 12.9" (2048 x 2732px) - iPad Pro

**Screenshot Ideas:**
1. Welcome/Login screen
2. Gallery of Labubu characters
3. Style generation in action
4. Before/after comparison
5. Credits/payment screen

#### App Preview Video (Optional):
- 15-30 seconds
- Show key features
- 1080x1920px or higher

### 5. 📝 App Store Listing Information

#### Basic Information:
```
App Name: Labubu Styler
Subtitle: AI-Powered Character Styling
Category: Entertainment / Photo & Video
Age Rating: 4+ (no objectionable content)
```

#### Description Template:
```
Transform your favorite Labubu characters with AI-powered styling!

Labubu Styler lets you reimagine your beloved Labubu characters in countless creative ways. Simply select a character, describe your vision, and watch as AI brings it to life.

KEY FEATURES:
• Choose from our curated Labubu collection or upload your own
• Describe any style: "eating watermelon", "superhero costume", "at the beach"
• AI generates unique, high-quality styled images
• Download and share your creations
• Simple credit system - pay only for what you use

HOW IT WORKS:
1. Select a Labubu character
2. Describe your creative vision
3. Generate your styled image in seconds
4. Download and share with friends

PRICING:
• 3 free credits to start
• 1 credit = 1 image generation
• Purchase more credits as needed
• Secure payment via Stripe

Perfect for Labubu collectors, creative enthusiasts, and anyone who loves personalizing their favorite characters!

Note: This app is not affiliated with Pop Mart or the official Labubu brand.
```

#### Keywords:
```
labubu, ai art, character styling, image generator, creative, pop mart, designer toy, AI filter, character creator, style transfer
```

#### Privacy Policy URL: (Required)
You need to create this. Template:
```
https://labubu-styler.com/privacy-policy
```

#### Support URL: (Required)
```
https://labubu-styler.com/support
```

### 6. 💼 Legal Requirements

#### Privacy Policy Must Include:
- What data you collect (email, phone, images)
- How you use the data
- Third-party services (OpenAI, Stripe, Supabase)
- Data retention policy
- User rights (deletion, access)

#### Terms of Service Should Include:
- Acceptable use policy
- Content ownership (user owns their images)
- Refund policy
- Limitation of liability

### 7. 🧪 Testing Requirements

#### TestFlight Beta Testing:
1. Upload build to TestFlight
2. Test with 5-10 users minimum
3. Fix any reported issues
4. Test all payment flows

#### Device Testing:
- [ ] iPhone 15 Pro
- [ ] iPhone 14
- [ ] iPhone 13 mini
- [ ] iPhone SE
- [ ] iPad (if supporting)

### 8. 🏗️ Build & Upload Process

#### 1. Update Version:
```yaml
# pubspec.yaml
version: 1.0.0+1  # Increment for each submission
```

#### 2. Create Release Build:
```bash
# Clean build
flutter clean
flutter pub get
cd ios && pod install && cd ..

# Create release build
flutter build ios --release
```

#### 3. Open in Xcode:
```bash
open ios/Runner.xcworkspace
```

#### 4. Configure Signing:
- Select your Apple Developer account
- Choose correct provisioning profile
- Ensure bundle ID matches App Store Connect

#### 5. Archive & Upload:
1. Product → Archive
2. Distribute App → App Store Connect
3. Upload

### 9. 📱 App Store Connect Setup

1. Create app in [App Store Connect](https://appstoreconnect.apple.com)
2. Fill in all metadata
3. Upload screenshots
4. Set pricing (Free with In-App Purchases)
5. Configure In-App Purchases (if using)

### 10. 🚦 Submission Review

#### Common Rejection Reasons to Avoid:
- [ ] Missing privacy policy
- [ ] Unclear app purpose
- [ ] Payment issues
- [ ] Copyright concerns (mention not affiliated with Pop Mart)
- [ ] Crashes or bugs
- [ ] Inappropriate content

#### Review Guidelines:
- Be clear about AI generation
- Explain credit system clearly
- Provide test account if needed
- Respond quickly to review feedback

## 📅 Timeline

- **Preparation**: 3-5 days
- **TestFlight Testing**: 5-7 days
- **App Review**: 24-48 hours (usually)
- **Total**: ~2 weeks

## 🎯 Next Immediate Steps

1. **Create Privacy Policy & Terms**
2. **Design App Icon**
3. **Take Screenshots**
4. **Test everything thoroughly**
5. **Set isDevelopment = false**
6. **Create Apple Developer account** ($99/year)

## 💡 Pro Tips

1. **Submit on Monday-Wednesday** (faster review)
2. **Include "AI-generated" in descriptions** (transparency)
3. **Test Stripe thoroughly** (Apple checks payments)
4. **Have 10+ test transactions** before submission
5. **Prepare for questions** about Labubu trademark

## 🆘 If Rejected

1. **Don't panic** - it's common
2. **Read feedback carefully**
3. **Fix issues promptly**
4. **Resubmit with detailed notes**
5. **Can appeal if needed**

---

Ready to submit? Start with creating your Privacy Policy and App Icon!