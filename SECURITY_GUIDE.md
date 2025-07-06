# Security Guide: Protecting Your API Keys and Sensitive Data

## Current Security Status

### ✅ What's Already Protected:
1. `.env` file is in `.gitignore` - won't be committed to Git
2. Using Vercel Edge Functions - keys stay on server
3. Supabase Row Level Security - database protection

### ⚠️ What Needs Attention:
1. OpenAI API key in Flutter app code
2. Ensure `.env` is never committed
3. Rotate any exposed keys

## Security Architecture

```
┌─────────────────────┐
│   Flutter App       │ (Client - PUBLIC)
│  - Supabase Anon    │ ✅ Safe
│  - Stripe Publish   │ ✅ Safe  
│  - NO Secret Keys!  │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│  Vercel Edge Funcs  │ (Server - PRIVATE)
│  - All Secret Keys  │ ✅ Protected
│  - OpenAI API      │ ✅ Protected
│  - Stripe Secret    │ ✅ Protected
│  - Supabase Service │ ✅ Protected
└─────────────────────┘
```

## Immediate Actions Required

### 1. Check Git History
```bash
# Check if .env was ever committed
git log --all -- .env

# If found, you MUST rotate all keys!
```

### 2. Remove OpenAI Key from Flutter Code

Update `lib/config/app_config.dart`:
```dart
// REMOVE this line:
static const String openAiApiKey = 'YOUR_OPENAI_API_KEY';

// Replace with:
static const String openAiApiKey = ''; // Use Edge Functions instead
```

### 3. Update OpenAI Service to Use Edge Functions

Update `lib/services/openai_service.dart`:
```dart
Future<String?> generateLabubuStyle({
  required String originalImagePath,
  required String styleDescription,
}) async {
  // For production, call Vercel Edge Function
  if (!AppConfig.isDevelopment) {
    return await _callEdgeFunction(originalImagePath, styleDescription);
  }
  
  // Development only - remove for production
  if (AppConfig.openAiApiKey.isEmpty) {
    throw Exception('OpenAI API key not configured');
  }
  
  // ... rest of the code
}

Future<String?> _callEdgeFunction(String imagePath, String description) async {
  final response = await http.post(
    Uri.parse('${AppConfig.vercelApiUrl}/generate-image'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${getCurrentUserId()}',
    },
    body: jsonEncode({
      'originalImagePath': imagePath,
      'prompt': description,
    }),
  );
  
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['imageUrl'];
  }
  throw Exception('Failed to generate image');
}
```

## Key Protection Rules

### 1. Client-Side (Flutter App) - PUBLIC
**CAN USE:**
- ✅ Supabase URL (public)
- ✅ Supabase Anon Key (public)
- ✅ Stripe Publishable Key (public)
- ✅ Vercel API URL (public)

**NEVER USE:**
- ❌ OpenAI API Key
- ❌ Stripe Secret Key
- ❌ Supabase Service Key
- ❌ Any "secret" or "private" key

### 2. Server-Side (Vercel/Edge Functions) - PRIVATE
**USE ALL KEYS HERE:**
- ✅ All secret keys
- ✅ Service role keys
- ✅ API keys

### 3. Environment Variables Best Practices

**Local Development (.env file):**
```bash
# Never commit this file
# Add to .gitignore immediately
# Use for local testing only
```

**Production (Vercel Dashboard):**
- Set environment variables in Vercel Dashboard
- Never hardcode in deployment files
- Use Vercel's encrypted storage

## Verifying Security

### 1. Check Your Repository
```bash
# Ensure .env is ignored
cat .gitignore | grep .env

# Check for accidental commits
git ls-files | grep -E "(secret|key|token|password)"

# Search for hardcoded keys
grep -r "sk_" --include="*.dart" .
grep -r "eyJ" --include="*.dart" .
```

### 2. Test Security
```bash
# This should fail (no API key in client)
curl https://api.openai.com/v1/images/generations \
  -H "Authorization: Bearer [nothing]"

# This should work (through Edge Function)
curl https://imagan-lsz2ac38a-quantyais-projects.vercel.app/api/generate-image
```

## If Keys Were Exposed

### Immediate Steps:
1. **Rotate ALL keys immediately**
2. **Check usage logs** for unauthorized access
3. **Update all applications** with new keys

### How to Rotate Keys:

**OpenAI:**
1. Go to platform.openai.com/api-keys
2. Delete the exposed key
3. Create a new key
4. Update in Vercel only

**Stripe:**
1. Go to dashboard.stripe.com/apikeys
2. Roll secret key
3. Update in Vercel only

**Supabase Service Key:**
1. Contact Supabase support
2. They'll help rotate service key
3. Update in Vercel only

## Production Checklist

- [ ] Remove all secret keys from Flutter code
- [ ] Set `isDevelopment = false` in app_config.dart
- [ ] All API calls go through Edge Functions
- [ ] Environment variables set in Vercel
- [ ] `.env` file not in Git history
- [ ] Test with fresh clone (no .env file)

## Monitoring Security

1. **OpenAI Dashboard**: Check for unusual usage
2. **Stripe Dashboard**: Monitor for unexpected charges
3. **Supabase Dashboard**: Review auth logs
4. **Vercel Dashboard**: Check function invocations

## Additional Security Measures

### 1. Rate Limiting (Already implemented)
- Supabase: 5 SMS per hour
- Credits: Prevent abuse

### 2. Add API Key Rotation Schedule
- Rotate keys every 90 days
- Document rotation dates
- Use calendar reminders

### 3. Enable Alerts
- OpenAI: Usage alerts
- Stripe: Unusual activity alerts
- Vercel: High usage alerts

## Remember

🔐 **Golden Rule**: If a key has "secret", "private", or "service" in its name, it NEVER goes in client code!

📱 **Flutter App**: Only uses "public" or "publishable" keys

🖥️ **Edge Functions**: Where all secret keys live

🚫 **Git**: Never commit `.env` files

🔄 **Rotation**: If exposed, rotate immediately!