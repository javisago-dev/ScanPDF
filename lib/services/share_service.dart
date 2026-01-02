import 'dart:io';
import 'package:share_plus/share_plus.dart';

class ShareService {
  Future<void> sharePdf(String pdfPath, String documentName) async {
    try {
      final file = File(pdfPath);
      if (!await file.exists()) {
        throw Exception('PDF file not found');
      }

      // Compartir usando el selector nativo de Android
      await Share.shareXFiles(
        [XFile(pdfPath)],
        subject: documentName,
        text: 'Sharing scanned document: $documentName',
      );
    } catch (e) {
      print('Error sharing PDF: $e');
      rethrow;
    }
  }
}
