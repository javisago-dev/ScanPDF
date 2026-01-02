import 'dart:io';

class ScannedDocument {
  final String id;
  String name;  // Cambiado de final a mutable
  final List<String> imagePaths;
  final DateTime createdAt;
  String? pdfPath;

  ScannedDocument({
    required this.id,
    required this.name,
    required this.imagePaths,
    required this.createdAt,
    this.pdfPath,
  });

  int get pageCount => imagePaths.length;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'imagePaths': imagePaths,
        'createdAt': createdAt.toIso8601String(),
        'pdfPath': pdfPath,
      };

  factory ScannedDocument.fromJson(Map<String, dynamic> json) {
    return ScannedDocument(
      id: json['id'] as String,
      name: json['name'] as String,
      imagePaths: List<String>.from(json['imagePaths'] as List),
      createdAt: DateTime.parse(json['createdAt'] as String),
      pdfPath: json['pdfPath'] as String?,
    );
  }

  Future<void> deletePdf() async {
    if (pdfPath != null) {
      final file = File(pdfPath!);
      if (await file.exists()) {
        await file.delete();
      }
      pdfPath = null;
    }
  }

  Future<void> deleteImages() async {
    for (final path in imagePaths) {
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
      }
    }
  }
}
