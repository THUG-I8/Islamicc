# تطبيق "اعرف دينك" 📱

تطبيق إسلامي شامل يحتوي على القرآن الكريم، الأذكار والأدعية، أسماء الله الحسنى، وعداد التسبيح الرقمي.

## محتويات التطبيق 🕌

### الأقسام الرئيسية:
- **المصحف الشريف**: قراءة سور القرآن الكريم
- **الأذكار والأدعية**: أذكار مختارة مع الفوائد والمصادر
- **أسماء الله الحسنى**: الأسماء الحسنى مع معانيها
- **التسبيح**: عداد رقمي للتسبيح مع خيارات متعددة

### المميزات:
- ✅ واجهة عربية بالكامل مع دعم RTL
- ✅ تصميم إسلامي جميل ومريح للعين
- ✅ سهولة الاستخدام والتنقل
- ✅ عداد تسبيح مع اهتزاز تفاعلي
- ✅ محتوى إسلامي موثوق

---

## طريقة بناء ملف APK 🔨

### المتطلبات الأساسية:

#### 1. تثبيت Flutter:
```bash
# تحميل Flutter SDK
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.3-stable.tar.xz
tar xf flutter_linux_3.24.3-stable.tar.xz

# إضافة Flutter إلى PATH
export PATH="$PATH:`pwd`/flutter/bin"

# التحقق من التثبيت
flutter doctor
```

#### 2. تثبيت Android Studio و Android SDK:
```bash
# تحميل Android Studio من الموقع الرسمي
wget https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2023.3.1.18/android-studio-2023.3.1.18-linux.tar.gz

# فك الضغط وتشغيل Android Studio
tar -xzf android-studio-*-linux.tar.gz
cd android-studio/bin
./studio.sh
```

#### 3. إعداد Android SDK:
- افتح Android Studio
- اذهب إلى **Tools > SDK Manager**
- ثبت:
  - Android SDK Platform 33
  - Android SDK Build-Tools 33.0.2
  - Android SDK Platform-Tools
  - Android SDK Command-line Tools

#### 4. إعداد متغيرات البيئة:
```bash
# أضف هذه الأسطر إلى ~/.bashrc أو ~/.zshrc
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_HOME/build-tools/33.0.2
```

### خطوات بناء APK:

#### 1. نسخ مجلد التطبيق:
```bash
# انسخ مجلد islamic_app إلى جهازك
cp -r islamic_app ~/my_islamic_app
cd ~/my_islamic_app
```

#### 2. تثبيت Dependencies:
```bash
flutter pub get
```

#### 3. فحص المشروع:
```bash
# التأكد من عدم وجود أخطاء
flutter analyze

# فحص الإعداد
flutter doctor
```

#### 4. بناء APK:
```bash
# بناء APK للإصدار (Release)
flutter build apk --release

# أو بناء APK مقسم حسب البنية (أقل حجماً)
flutter build apk --split-per-abi --release
```

#### 5. العثور على ملف APK:
```bash
# ملف APK سيكون في:
ls build/app/outputs/flutter-apk/

# الملف الرئيسي:
# app-release.apk (حوالي 20-30 MB)

# أو الملفات المقسمة:
# app-arm64-v8a-release.apk (للأجهزة الحديثة)
# app-armeabi-v7a-release.apk (للأجهزة القديمة)
# app-x86_64-release.apk (للمحاكيات)
```

---

## البناء السريع (بدون Android Studio) ⚡

### إذا كنت تريد طريقة أسرع:

#### 1. تثبيت Android Command Line Tools فقط:
```bash
# إنشاء مجلد SDK
mkdir -p ~/android-sdk

# تحميل Command Line Tools
cd ~/android-sdk
wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip
unzip commandlinetools-linux-*_latest.zip

# ترتيب المجلدات
mkdir -p cmdline-tools/latest
mv cmdline-tools/* cmdline-tools/latest/ 2>/dev/null || true

# إعداد متغيرات البيئة
export ANDROID_HOME=~/android-sdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
```

#### 2. تثبيت المكونات المطلوبة:
```bash
# قبول التراخيص
yes | sdkmanager --licenses

# تثبيت المكونات الأساسية
sdkmanager "platform-tools" "platforms;android-33" "build-tools;33.0.2"
```

#### 3. بناء APK:
```bash
cd islamic_app
flutter pub get
flutter build apk --release
```

---

## حل المشاكل الشائعة 🔧

### مشكلة "Android SDK not found":
```bash
flutter config --android-sdk ~/android-sdk
```

### مشكلة "Java version":
```bash
# تثبيت Java 11
sudo apt install openjdk-11-jdk

# تعيين Java 11 كافتراضي
sudo update-alternatives --config java
```

### مشكلة "Gradle":
```bash
# في مجلد android/
./gradlew clean
flutter clean
flutter pub get
```

### مشكلة "License not accepted":
```bash
flutter doctor --android-licenses
# اكتب 'y' لقبول جميع التراخيص
```

---

## تجربة التطبيق 📱

### تشغيل على محاكي:
```bash
# إنشاء محاكي Android
flutter emulators --create --name test_emulator

# تشغيل المحاكي
flutter emulators --launch test_emulator

# تشغيل التطبيق
flutter run
```

### تثبيت APK على الجهاز:
```bash
# تمكين وضع المطور في الهاتف
# Settings > About Phone > Build Number (اضغط 7 مرات)

# تمكين USB Debugging
# Settings > Developer Options > USB Debugging

# توصيل الهاتف وتثبيت APK
adb install build/app/outputs/flutter-apk/app-release.apk
```

---

## إصدارات التطبيق 📈

### الإصدار الحالي: 1.0.0
- ✅ الواجهة الرئيسية
- ✅ قسم المصحف الشريف (أساسي)
- ✅ قسم الأذكار والأدعية
- ✅ قسم أسماء الله الحسنى
- ✅ عداد التسبيح الرقمي

### تحديثات مستقبلية (اختيارية):
- 📖 إضافة نصوص القرآن كاملة
- 🔊 إضافة التلاوات الصوتية
- 🕌 إضافة اتجاه القبلة
- ⏰ إضافة مواقيت الصلاة
- 📚 إضافة المزيد من الأحاديث والقصص
- 🌙 إضافة التقويم الهجري

---

## الدعم والمساعدة 💬

### إذا واجهت مشاكل:

1. **تأكد من إصدارات البرامج:**
   - Flutter 3.24.3 أو أحدث
   - Android SDK 33
   - Java 11

2. **شغل الأوامر التالية للتشخيص:**
   ```bash
   flutter doctor -v
   flutter analyze
   ```

3. **روابط مفيدة:**
   - [دليل Flutter الرسمي](https://docs.flutter.dev/)
   - [إعداد Android SDK](https://developer.android.com/studio/install)
   - [دليل بناء APK](https://docs.flutter.dev/deployment/android)

---

## ملاحظات هامة ⚠️

- **حجم APK:** متوقع بين 15-25 ميجابايت
- **الأجهزة المدعومة:** Android 5.0 (API 21) وأحدث  
- **الأذونات:** التطبيق لا يحتاج أذونات خاصة
- **الاتصال بالإنترنت:** التطبيق يعمل offline بالكامل

---

## رخصة الاستخدام 📜

هذا التطبيق مجاني للاستخدام الشخصي والتعليمي. يرجى عدم بيعه أو استخدامه لأغراض تجارية.

---

**جزاكم الله خيراً** 🤲

*"وَمَنْ أَحْيَاهَا فَكَأَنَّمَا أَحْيَا النَّاسَ جَمِيعًا"*