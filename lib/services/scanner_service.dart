import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import '../models/scanned_document.dart';

class ScannerService {
  Future<ScannedDocument?> scanDocument() async {
    try {
      List<String> pictures = await CunningDocumentScanner.getPictures() ?? [];
      
      if (pictures.isEmpty) {
        return null;
      }

      final document = ScannedDocument(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: 'Document ${DateTime.now().toString().split('.')[0]}',
        imagePaths: pictures,
        createdAt: DateTime.now(),
      );

      return document;
    } catch (e) {
      print('Error scanning document: $e');
      rethrow;
    }
  }
}
