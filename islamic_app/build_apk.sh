#!/bin/bash

# =====================================
# سكريبت بناء تطبيق "اعرف دينك" 
# Islamic App APK Builder
# =====================================

echo "🕌 مرحباً بك في منشئ تطبيق اعرف دينك"
echo "====================================="

# الألوان للرسائل
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# دالة طباعة الرسائل الملونة
print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# فحص وجود Flutter
check_flutter() {
    print_info "فحص وجود Flutter..."
    if ! command -v flutter &> /dev/null; then
        print_error "Flutter غير مثبت!"
        print_info "يرجى تثبيت Flutter أولاً من: https://flutter.dev"
        exit 1
    else
        FLUTTER_VERSION=$(flutter --version | head -n 1)
        print_success "Flutter موجود: $FLUTTER_VERSION"
    fi
}

# فحص Android SDK
check_android_sdk() {
    print_info "فحص Android SDK..."
    if [ -z "$ANDROID_HOME" ]; then
        print_warning "متغير ANDROID_HOME غير محدد"
        print_info "سيتم البحث عن Android SDK في المسارات الافتراضية..."
        
        # البحث في المسارات الافتراضية
        if [ -d "$HOME/Android/Sdk" ]; then
            export ANDROID_HOME="$HOME/Android/Sdk"
            export PATH="$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin"
            print_success "تم العثور على Android SDK في: $ANDROID_HOME"
        elif [ -d "/opt/android-sdk" ]; then
            export ANDROID_HOME="/opt/android-sdk"
            export PATH="$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin"
            print_success "تم العثور على Android SDK في: $ANDROID_HOME"
        else
            print_error "لم يتم العثور على Android SDK!"
            print_info "يرجى تثبيت Android SDK أولاً"
            exit 1
        fi
    else
        print_success "Android SDK موجود في: $ANDROID_HOME"
    fi
}

# فحص Java
check_java() {
    print_info "فحص Java..."
    if ! command -v java &> /dev/null; then
        print_error "Java غير مثبت!"
        print_info "يرجى تثبيت Java 11 أولاً"
        exit 1
    else
        JAVA_VERSION=$(java -version 2>&1 | head -n 1)
        print_success "Java موجود: $JAVA_VERSION"
    fi
}

# تشغيل flutter doctor
run_flutter_doctor() {
    print_info "تشغيل فحص Flutter..."
    flutter doctor
    echo ""
    
    read -p "هل تريد المتابعة رغم وجود تحذيرات؟ (y/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_warning "تم إلغاء العملية"
        exit 1
    fi
}

# تنظيف المشروع
clean_project() {
    print_info "تنظيف المشروع..."
    flutter clean
    print_success "تم تنظيف المشروع"
}

# تثبيت Dependencies
install_dependencies() {
    print_info "تثبيت dependencies..."
    flutter pub get
    if [ $? -eq 0 ]; then
        print_success "تم تثبيت dependencies بنجاح"
    else
        print_error "فشل في تثبيت dependencies"
        exit 1
    fi
}

# بناء APK
build_apk() {
    print_info "بناء APK..."
    echo "اختر نوع البناء:"
    echo "1) APK موحد (حجم أكبر، يعمل على جميع الأجهزة)"
    echo "2) APK مقسم حسب البنية (حجم أصغر، ملفات متعددة)"
    
    read -p "اختر رقم (1 أو 2): " -n 1 -r
    echo
    
    case $REPLY in
        1)
            print_info "بناء APK موحد..."
            flutter build apk --release
            APK_PATH="build/app/outputs/flutter-apk/app-release.apk"
            ;;
        2)
            print_info "بناء APK مقسم..."
            flutter build apk --split-per-abi --release
            APK_PATH="build/app/outputs/flutter-apk/"
            ;;
        *)
            print_warning "اختيار غير صحيح، سيتم بناء APK موحد..."
            flutter build apk --release
            APK_PATH="build/app/outputs/flutter-apk/app-release.apk"
            ;;
    esac
    
    if [ $? -eq 0 ]; then
        print_success "تم بناء APK بنجاح!"
        show_results
    else
        print_error "فشل في بناء APK"
        exit 1
    fi
}

# عرض النتائج
show_results() {
    echo ""
    print_success "🎉 تم بناء التطبيق بنجاح!"
    echo "============================="
    
    print_info "مسار ملفات APK:"
    if [ -f "build/app/outputs/flutter-apk/app-release.apk" ]; then
        APK_SIZE=$(du -h "build/app/outputs/flutter-apk/app-release.apk" | cut -f1)
        echo "📱 app-release.apk ($APK_SIZE)"
    fi
    
    if [ -f "build/app/outputs/flutter-apk/app-arm64-v8a-release.apk" ]; then
        ARM64_SIZE=$(du -h "build/app/outputs/flutter-apk/app-arm64-v8a-release.apk" | cut -f1)
        echo "📱 app-arm64-v8a-release.apk ($ARM64_SIZE) - للأجهزة الحديثة"
    fi
    
    if [ -f "build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk" ]; then
        ARM32_SIZE=$(du -h "build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk" | cut -f1)
        echo "📱 app-armeabi-v7a-release.apk ($ARM32_SIZE) - للأجهزة القديمة"
    fi
    
    echo ""
    print_info "طريقة التثبيت:"
    echo "1. انسخ ملف APK إلى هاتفك"
    echo "2. فعل 'مصادر غير معروفة' في الإعدادات"
    echo "3. اضغط على ملف APK لتثبيته"
    
    echo ""
    print_info "أو استخدم ADB:"
    echo "adb install build/app/outputs/flutter-apk/app-release.apk"
    
    echo ""
    print_success "بارك الله فيك! 🤲"
}

# الدالة الرئيسية
main() {
    echo ""
    print_info "بدء عملية بناء التطبيق..."
    echo ""
    
    check_flutter
    check_android_sdk
    check_java
    
    echo ""
    print_info "هل تريد تشغيل flutter doctor للفحص الشامل؟ (يُنصح به)"
    read -p "(y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        run_flutter_doctor
    fi
    
    echo ""
    clean_project
    install_dependencies
    echo ""
    build_apk
}

# التحقق من وجود pubspec.yaml
if [ ! -f "pubspec.yaml" ]; then
    print_error "لم يتم العثور على pubspec.yaml"
    print_info "تأكد من تشغيل السكريبت داخل مجلد التطبيق"
    exit 1
fi

# تشغيل الدالة الرئيسية
main

echo ""
print_success "انتهت العملية بنجاح! 🎉"
echo "جزاكم الله خيراً 🤲"