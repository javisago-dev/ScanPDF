# Scan PDF

Una aplicación Flutter para escanear documentos, generar PDFs y compartirlos fácilmente.

## Características

✨ **Escaneo de Documentos**
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

## Requisitos

- Flutter 3.0.0 o superior
- Dart 3.0.0 o superior
- Android 5.0 (API 21) o superior

## Instalación

1. Clona el repositorio o descarga el código
2. Navega al directorio del proyecto
3. Instala las dependencias:

```bash
flutter pub get
```

4. Ejecuta la aplicación:

```bash
flutter run
```

## Dependencias Principales

- **cunning_document_scanner**: Escaneo de documentos con detección de bordes
- **pdf**: Generación de archivos PDF
- **path_provider**: Manejo de rutas de archivos
- **share_plus**: Compartir archivos
- **permission_handler**: Gestión de permisos

## Estructura del Proyecto

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

## Uso

1. **Escanear un documento**: Toca el botón flotante "Escanear Documento"
2. **Tomar fotos**: La cámara se abrirá con detección automática de bordes
3. **Editar**: Puedes ajustar los bordes detectados antes de capturar
4. **Múltiples páginas**: Continúa escaneando hasta 10 páginas
5. **Ver documentos**: Los documentos aparecerán en la lista principal
6. **Compartir**: Toca un documento para generar el PDF y compartirlo
7. **Eliminar**: Usa el menú de tres puntos para eliminar documentos

## Permisos

La aplicación requiere los siguientes permisos:
- **Cámara**: Para escanear documentos
- **Almacenamiento**: Para guardar imágenes y PDFs (solo Android < 13)

## Compilar para Release

```bash
flutter build apk --release
```

o para un App Bundle:

```bash
flutter build appbundle --release
```

## Licencia

Este proyecto es de código abierto y está disponible bajo la licencia MIT.

## Soporte

Si encuentras algún problema o tienes sugerencias, por favor crea un issue en el repositorio.
