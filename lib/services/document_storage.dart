import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/scanned_document.dart';

class DocumentStorage {
  static const String _documentsFile = 'scanned_documents.json';

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _documentsListFile async {
    final path = await _localPath;
    return File('$path/$_documentsFile');
  }

  Future<List<ScannedDocument>> loadDocuments() async {
    try {
      final file = await _documentsListFile;
      if (!await file.exists()) {
        return [];
      }

      final contents = await file.readAsString();
      final List<dynamic> jsonData = json.decode(contents);
      return jsonData.map((json) => ScannedDocument.fromJson(json)).toList();
    } catch (e) {
      print('Error loading documents: $e');
      return [];
    }
  }

  Future<void> saveDocuments(List<ScannedDocument> documents) async {
    try {
      final file = await _documentsListFile;
      final jsonData = documents.map((doc) => doc.toJson()).toList();
      await file.writeAsString(json.encode(jsonData));
    } catch (e) {
      print('Error saving documents: $e');
      rethrow;
    }
  }

  Future<String> getDocumentsDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    final docsDir = Directory('${directory.path}/scanned_docs');
    if (!await docsDir.exists()) {
      await docsDir.create(recursive: true);
    }
    return docsDir.path;
  }

  Future<void> deleteDocument(ScannedDocument document) async {
    await document.deletePdf();
    await document.deleteImages();
  }
}
