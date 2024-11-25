import 'package:dsoft_form_application/common/logger/app_logger.dart';

extension StringToDateTime on String {
  DateTime? toDateTime({String pattern = "yyyy-MM-dd HH:mm:ss"}) {
    try {
      return DateTime.parse(this);
    } catch (e) {
      AppLogger.instance.e("Error parsing date: $e");
      return null;
    }
  }
}
