import 'package:dsoft_form_application/common/logger/app_logger.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseAnalyticsService {
  late FirebaseAnalytics analytics;

  FirebaseAnalyticsService._(this.analytics);

  static final FirebaseAnalyticsService _instance =
      FirebaseAnalyticsService._(FirebaseAnalytics.instance);

  factory FirebaseAnalyticsService() {
    return _instance;
  }

  Future<void> log(List<String> list, Map<String, Object>? parameter) async {
    try {
      await analytics.logEvent(
          name: list[1],
          parameters: {"code": list[0], "type": list[2], ...?parameter});
    } catch (e) {
      // Handle error
      AppLogger.instance.e('Error logging event: $e');
    }
  }
}
