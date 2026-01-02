# 📱 Scan PDF

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?logo=dart)](https://dart.dev)
[![Android](https://img.shields.io/badge/Android-5.0+-3DDC84?logo=android)](https://www.android.com)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

Una aplicación Flutter para escanear documentos, generar PDFs y compartirlos fácilmente.

![Scan PDF Demo](https://via.placeholder.com/800x400?text=Scan+PDF+App)

## ✨ Características

📷 **Escaneo de Documentos**
- Escaneo con detección automática de bordes
- Edición y recorte de imágenes antes de generar PDF
- Soporte para múltiples páginas (hasta 10 páginas por documento)

📄 **Generación de PDF**
- Conversión automática de imágenes escaneadas a PDF
- PDFs optimizados en formato A4
- Almacenamiento local seguro

📤 **Compartir**
- Selector nativo de Android para compartir
- Compatible con todas las apps de compartir (WhatsApp, Email, Drive, etc.)

🌐 **Multiidioma**
- Soporte para Español e Inglés
- Detección automática del idioma del sistema

🎨 **Diseño Moderno**
- Material Design 3
- Modo claro y oscuro automático
- Interfaz intuitiva y fácil de usar

## 📸 Capturas de Pantalla

> _Las capturas de pantalla se agregarán próximamente_

## 🚀 Inicio Rápido

### Requisitos Previos

- Flutter 3.0.0 o superior
- Dart 3.0.0 o superior
- Android 5.0 (API 21) o superior

### Instalación

1. **Clona el repositorio**
   ```bash
   git clone https://github.com/javisago-dev/ScanPDF.git
   cd ScanPDF
   ```

2. **Instala las dependencias**
   ```bash
   flutter pub get
   ```

3. **Conecta tu dispositivo Android o inicia un emulador**
   ```bash
   flutter devices
   ```

4. **Ejecuta la aplicación**
   ```bash
   flutter run
   ```

### Compilar APK

```bash
# APK de debug
flutter build apk --debug

# APK de release
flutter build apk --release

# App Bundle para Google Play
flutter build appbundle --release
```

## 📦 Dependencias Principales

- **cunning_document_scanner**: Escaneo de documentos con detección de bordes
- **pdf**: Generación de archivos PDF
- **path_provider**: Manejo de rutas de archivos
- **share_plus**: Compartir archivos
- **permission_handler**: Gestión de permisos

## 📁 Estructura del Proyecto

```
lib/
├── main.dart                 # Punto de entrada
├── models/
│   └── scanned_document.dart # Modelo de datos
├── screens/
│   └── home_screen.dart      # Pantalla principal
├── services/
│   ├── document_storage.dart # Almacenamiento
│   ├── scanner_service.dart  # Servicio de escaneo
│   ├── pdf_service.dart      # Generación de PDF
│   └── share_service.dart    # Compartir documentos
└── l10n/
    ├── app_en.arb           # Traducciones inglés
    └── app_es.arb           # Traducciones español
```

## 🎯 Uso

1. **Escanear un documento**: Toca el botón flotante "Escanear Documento"
2. **Tomar fotos**: La cámara se abrirá con detección automática de bordes
3. **Editar**: Puedes ajustar los bordes detectados antes de capturar
4. **Múltiples páginas**: Continúa escaneando hasta 10 páginas
5. **Ver documentos**: Los documentos aparecerán en la lista principal
6. **Compartir**: Toca un documento para generar el PDF y compartirlo
7. **Eliminar**: Usa el menú de tres puntos para eliminar documentos

## 🔐 Permisos

La aplicación requiere los siguientes permisos:
- **Cámara**: Para escanear documentos
- **Almacenamiento**: Para guardar imágenes y PDFs

## 📚 Documentación Adicional

- [GUIA_COMPLETA.md](GUIA_COMPLETA.md) - Documentación exhaustiva del proyecto
- [COMANDOS.md](COMANDOS.md) - Lista de comandos útiles de Flutter
- [PERSONALIZACION.md](PERSONALIZACION.md) - Guía para personalizar la app

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Por favor:
1. Haz fork del proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📄 Licencia

Este proyecto es de código abierto y está disponible bajo la licencia MIT.

## 👨‍💻 Autor

**javisago-dev**
- GitHub: [@javisago-dev](https://github.com/javisago-dev)

## ⭐ Agradecimientos

- Flutter Team por el increíble framework
- Comunidad de Flutter por los paquetes utilizados

---

**¡Dale una ⭐ si este proyecto te fue útil!**
