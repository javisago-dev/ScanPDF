import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import '../models/scanned_document.dart';

class PdfService {
  Future<String> generatePdf(ScannedDocument document) async {
    try {
      final pdf = pw.Document();

      // Cargar cada imagen y agregarla como una página
      for (final imagePath in document.imagePaths) {
        final imageFile = File(imagePath);
        final imageBytes = await imageFile.readAsBytes();
        final image = pw.MemoryImage(imageBytes);

        pdf.addPage(
          pw.Page(
            pageFormat: PdfPageFormat.a4,
            build: (pw.Context context) {
              return pw.Center(
                child: pw.Image(image, fit: pw.BoxFit.contain),
              );
            },
          ),
        );
      }

      // Guardar el PDF
      final appDir = await getApplicationDocumentsDirectory();
      final pdfDir = Directory('${appDir.path}/scanned_docs/pdfs');
      await pdfDir.create(recursive: true);

      final pdfPath = '${pdfDir.path}/${document.id}.pdf';
      final pdfFile = File(pdfPath);
      await pdfFile.writeAsBytes(await pdf.save());

      return pdfPath;
    } catch (e) {
      print('Error generating PDF: $e');
      rethrow;
    }
  }

  Future<void> deletePdf(String pdfPath) async {
    try {
      final file = File(pdfPath);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      print('Error deleting PDF: $e');
    }
  }
}
