import 'dart:io';
import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import '../models/scanned_document.dart';

class ScannerService {
  Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  Future<ScannedDocument?> scanDocument() async {
    try {
      // Solicitar permiso de cámara
      if (!await requestCameraPermission()) {
        throw Exception('Camera permission denied');
      }

      // Escanear documento con la librería
      final pictures = await CunningDocumentScanner.getPictures(
        noOfPages: 10, // Máximo 10 páginas
        isGalleryImportAllowed: false,
      );

      if (pictures == null || pictures.isEmpty) {
        return null;
      }

      // Crear directorio para guardar las imágenes
      final appDir = await getApplicationDocumentsDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final docDir = Directory('${appDir.path}/scanned_docs/doc_$timestamp');
      await docDir.create(recursive: true);

      // Copiar las imágenes escaneadas al directorio de la app
      final List<String> savedPaths = [];
      for (int i = 0; i < pictures.length; i++) {
        final sourcePath = pictures[i];
        final fileName = 'page_${i + 1}.jpg';
        final destinationPath = '${docDir.path}/$fileName';
        
        final sourceFile = File(sourcePath);
        await sourceFile.copy(destinationPath);
        savedPaths.add(destinationPath);
      }

      // Crear el documento escaneado
      final document = ScannedDocument(
        id: timestamp.toString(),
        name: 'Document ${DateTime.now().toString().split('.')[0]}',
        imagePaths: savedPaths,
        createdAt: DateTime.now(),
      );

      return document;
    } catch (e) {
      print('Error scanning document: $e');
      rethrow;
    }
  }
}
