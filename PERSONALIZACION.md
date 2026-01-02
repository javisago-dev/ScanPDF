# Personalización de la Aplicación

## Cambiar el nombre de la aplicación

### Android
Edita `android/app/src/main/AndroidManifest.xml`:
```xml
<application
    android:label="Tu Nombre Aquí"
    ...
```

### iOS (si se agrega soporte)
Edita `ios/Runner/Info.plist`:
```xml
<key>CFBundleName</key>
<string>Tu Nombre Aquí</string>
```

## Cambiar el ícono de la aplicación

### Opción 1: Usar flutter_launcher_icons (Recomendado)

1. Agrega el paquete al `pubspec.yaml`:
```yaml
dev_dependencies:
  flutter_launcher_icons: ^0.13.1

flutter_launcher_icons:
  android: true
  ios: false
  image_path: "assets/icon/app_icon.png"
  adaptive_icon_background: "#FFFFFF"
  adaptive_icon_foreground: "assets/icon/app_icon_foreground.png"
```

2. Coloca tu ícono (1024x1024 px) en `assets/icon/app_icon.png`

3. Ejecuta:
```powershell
flutter pub get
flutter pub run flutter_launcher_icons
```

### Opción 2: Manual

Reemplaza los archivos en:
- `android/app/src/main/res/mipmap-hdpi/ic_launcher.png` (72x72)
- `android/app/src/main/res/mipmap-mdpi/ic_launcher.png` (48x48)
- `android/app/src/main/res/mipmap-xhdpi/ic_launcher.png` (96x96)
- `android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png` (144x144)
- `android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png` (192x192)

## Cambiar el package name (ID de la aplicación)

### Android

1. Edita `android/app/build.gradle`:
```gradle
defaultConfig {
    applicationId "com.tuempresa.tuapp"
    ...
}
```

2. Edita `android/app/src/main/AndroidManifest.xml`:
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.tuempresa.tuapp">
```

3. Renombra el directorio de paquetes:
```
android/app/src/main/kotlin/com/scanpdf/scan_pdf/ 
→ android/app/src/main/kotlin/com/tuempresa/tuapp/
```

4. Edita `MainActivity.kt` con el nuevo paquete:
```kotlin
package com.tuempresa.tuapp
```

## Cambiar los colores del tema

Edita `lib/main.dart`:
```dart
theme: ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue, // Cambia este color
    brightness: Brightness.light,
  ),
  ...
)
```

## Agregar una splash screen

1. Agrega el paquete:
```yaml
dependencies:
  flutter_native_splash: ^2.3.10
```

2. Configura en `pubspec.yaml`:
```yaml
flutter_native_splash:
  color: "#FFFFFF"
  image: assets/splash/splash_logo.png
  android: true
  ios: false
```

3. Ejecuta:
```powershell
flutter pub get
flutter pub run flutter_native_splash:create
```

## Configurar firma para release (Android)

1. Crea un keystore:
```powershell
keytool -genkey -v -keystore c:\Users\TuUsuario\upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

2. Crea `android/key.properties`:
```properties
storePassword=tu_store_password
keyPassword=tu_key_password
keyAlias=upload
storeFile=c:/Users/TuUsuario/upload-keystore.jks
```

3. Edita `android/app/build.gradle`:
```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    ...
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    }
}
```

## Agregar más idiomas

1. Crea un nuevo archivo ARB en `lib/l10n/`:
```
lib/l10n/app_fr.arb  (para francés)
lib/l10n/app_de.arb  (para alemán)
etc.
```

2. Copia el contenido de `app_en.arb` y traduce los valores.

3. Crea el archivo de localización correspondiente:
```
lib/l10n/app_localizations_fr.dart
```

4. Actualiza `lib/l10n/app_localizations.dart` para incluir el nuevo idioma.

5. Agrega el locale a `lib/main.dart`:
```dart
supportedLocales: const [
  Locale('en', ''),
  Locale('es', ''),
  Locale('fr', ''), // Nuevo
],
```
