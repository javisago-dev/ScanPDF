# Comandos útiles para Scan PDF

## Instalación inicial
```powershell
# Instalar dependencias
flutter pub get
```

## Desarrollo
```powershell
# Ejecutar en modo debug
flutter run

# Ejecutar en un dispositivo específico
flutter devices
flutter run -d <device_id>

# Hot reload está disponible automáticamente durante el desarrollo
# Presiona 'r' para hot reload
# Presiona 'R' para hot restart
```

## Análisis y limpieza
```powershell
# Analizar código
flutter analyze

# Limpiar proyecto
flutter clean

# Formatear código
flutter format lib/
```

## Compilación
```powershell
# Compilar APK de release
flutter build apk --release

# Compilar APK de debug
flutter build apk --debug

# Compilar App Bundle (recomendado para Google Play)
flutter build appbundle --release

# Compilar APK split por ABI (genera APKs más pequeños)
flutter build apk --split-per-abi
```

## Testing
```powershell
# Ejecutar tests
flutter test

# Ejecutar tests con cobertura
flutter test --coverage
```

## Localización
```powershell
# Si necesitas regenerar archivos de localización
# (Los archivos ya están creados manualmente en lib/l10n/)
flutter gen-l10n
```

## Información del proyecto
```powershell
# Ver información de Flutter
flutter doctor

# Ver dispositivos conectados
flutter devices

# Ver paquetes desactualizados
flutter pub outdated
```

## Depuración
```powershell
# Ejecutar con logging detallado
flutter run -v

# Inspeccionar el widget tree
# Presiona 'w' durante la ejecución
```

## Notas importantes

1. **Primera ejecución**: La primera vez que ejecutes `flutter run` puede tardar varios minutos mientras se compila todo.

2. **Permisos**: Asegúrate de que el dispositivo Android tenga los permisos de cámara habilitados.

3. **Versión mínima**: La aplicación requiere Android 5.0 (API 21) o superior.

4. **Dispositivo físico recomendado**: Para probar la funcionalidad de escaneo de documentos, es mejor usar un dispositivo físico en lugar de un emulador.

5. **Hot Reload**: Aprovecha el hot reload durante el desarrollo. Solo presiona 'r' en la terminal donde está corriendo la app.

## Solución de problemas comunes

### Error: "Waiting for another flutter command to release the startup lock"
```powershell
# Eliminar el archivo de bloqueo
Remove-Item -Path "$env:APPDATA\..\Local\Temp\flutter_tools_lock"
```

### Error de Gradle
```powershell
cd android
.\gradlew clean
cd ..
flutter clean
flutter pub get
```

### Problemas con dependencias
```powershell
flutter clean
flutter pub get
flutter pub upgrade
```
