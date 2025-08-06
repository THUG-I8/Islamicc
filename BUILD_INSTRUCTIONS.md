# تعليمات بناء تطبيق اعرف دينك

## الميزات الجديدة المضافة ✨

✅ **أوقات الصلاة** - عرض أوقات الصلوات الخمس والشروق  
✅ **اتجاه القبلة** - بوصلة تفاعلية لتحديد اتجاه القبلة  
✅ **تسبيح متقدم** - عداد تفاعلي مع رسوم متحركة  
✅ **أذكار شاملة** - أذكار الصباح والمساء والنوم والاستيقاظ  
✅ **أسماء الله الحسنى** - مع المعاني والشروحات  
✅ **تصميم محسن** - واجهة جميلة مع تدرجات وظلال  
✅ **الدعم العربي الكامل** - RTL وخطوط عربية  

## متطلبات البناء 🛠️

### 1. تثبيت Flutter
```bash
# تحميل Flutter SDK
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"
flutter doctor
```

### 2. تثبيت Android SDK
```bash
# تحميل Android command line tools
wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip
unzip commandlinetools-linux-11076708_latest.zip
mkdir -p android-sdk/cmdline-tools/latest
mv cmdline-tools/* android-sdk/cmdline-tools/latest/
export ANDROID_HOME="$PWD/android-sdk"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools"

# تثبيت المكونات المطلوبة
sdkmanager "platform-tools" "platforms;android-33" "build-tools;33.0.2"
flutter doctor --android-licenses
```

## خطوات البناء 🚀

### 1. استخراج الملف
```bash
unzip islamic_app_enhanced.zip
cd simple_islamic
```

### 2. تثبيت Dependencies
```bash
flutter pub get
```

### 3. فحص البيئة
```bash
flutter doctor
```

### 4. بناء APK
```bash
# للاختبار (debug)
flutter build apk --debug

# للنشر (release)
flutter build apk --release

# للنشر مع تحسين الحجم
flutter build apk --split-per-abi --release
```

### 5. العثور على APK
```bash
# ملف APK يكون في:
build/app/outputs/flutter-apk/
```

## حل المشاكل الشائعة 🔧

### مشكلة: Flutter command not found
```bash
export PATH="$PATH:/path/to/flutter/bin"
```

### مشكلة: Android licenses not accepted
```bash
flutter doctor --android-licenses
# اكتب 'y' لجميع الرخص
```

### مشكلة: SDK not found
```bash
export ANDROID_HOME="/path/to/android-sdk"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"
```

### مشكلة: Gradle build failed
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter build apk
```

## بدائل البناء 🔄

### GitHub Actions (موصى به)
1. ارفع المشروع على GitHub
2. GitHub Actions سيبني APK تلقائياً
3. حمل APK من Artifacts أو Releases

### Android Studio
1. افتح المشروع في Android Studio
2. Build → Flutter → Build APK

### VS Code
1. افتح المشروع في VS Code
2. Ctrl+Shift+P → Flutter: Build APK

## ملاحظات مهمة 📋

- حجم APK المتوقع: 15-25 MB
- يدعم Android 5.0 (API 21) فما فوق
- التطبيق باللغة العربية بالكامل
- جميع الميزات تعمل بدون إنترنت

## المساعدة والدعم 💬

إذا واجهت مشاكل:
1. تأكد من تثبيت Flutter و Android SDK بشكل صحيح
2. راجع `flutter doctor` للتأكد من البيئة
3. جرب `flutter clean` ثم `flutter pub get`
4. استخدم `flutter build apk --debug` للاختبار أولاً

---

**بالتوفيق! 🤲**