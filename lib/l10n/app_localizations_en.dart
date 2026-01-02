// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'PDF Scanner for Students';

  @override
  String get scanDocument => 'Scan Document';

  @override
  String get myDocuments => 'My Documents';

  @override
  String get noDocuments => 'No documents yet';

  @override
  String get scanFirstDocument => 'Scan your first document';

  @override
  String get document => 'Document';

  @override
  String get pages => 'pages';

  @override
  String get share => 'Share';

  @override
  String get delete => 'Delete';

  @override
  String get deleteDocument => 'Delete Document';

  @override
  String get deleteConfirmation =>
      'Are you sure you want to delete this document?';

  @override
  String get cancel => 'Cancel';

  @override
  String get generatingPdf => 'Generating PDF...';

  @override
  String get pdfGenerated => 'PDF generated successfully';

  @override
  String get errorGeneratingPdf => 'Error generating PDF';

  @override
  String get errorScanning => 'Error scanning document';

  @override
  String get permissionDenied => 'Camera permission denied';

  @override
  String get grantPermission => 'Grant Permission';

  @override
  String get cameraPermissionRequired =>
      'Camera permission is required to scan documents';
}
