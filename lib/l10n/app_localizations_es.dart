// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Escanear PDF';

  @override
  String get scanDocument => 'Escanear Documento';

  @override
  String get myDocuments => 'Mis Documentos';

  @override
  String get noDocuments => 'Aún no hay documentos';

  @override
  String get scanFirstDocument => 'Escanea tu primer documento';

  @override
  String get document => 'Documento';

  @override
  String get pages => 'páginas';

  @override
  String get share => 'Compartir';

  @override
  String get delete => 'Eliminar';

  @override
  String get deleteDocument => 'Eliminar Documento';

  @override
  String get deleteConfirmation =>
      '¿Estás seguro de que quieres eliminar este documento?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get generatingPdf => 'Generando PDF...';

  @override
  String get pdfGenerated => 'PDF generado exitosamente';

  @override
  String get errorGeneratingPdf => 'Error al generar PDF';

  @override
  String get errorScanning => 'Error al escanear documento';

  @override
  String get permissionDenied => 'Permiso de cámara denegado';

  @override
  String get grantPermission => 'Otorgar Permiso';

  @override
  String get cameraPermissionRequired =>
      'Se requiere permiso de cámara para escanear documentos';
}
