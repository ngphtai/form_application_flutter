// ignore_for_file: non_constant_identifier_names

part of 'constants.dart';

/// [LogEventsConstants] file contains the variables.
/// They can be used instead of default key of when adding parameters for
/// logging events
class LogEventsConstants {
  /// Label of type event parameter when log event
  static const typeEventParameterLogEvent = 'type_event';

  /// Label of code event parameter when log event
  static const codeEventParameterLogEvent = 'code_event';
}

class Type {
  static const String normal = "Normal";
  static const String api = "Api";
  static const String local = "Local";
}

class LogEvents {
  static List<String> tap_form_button = [
    "0x01",
    "tap_form_button",
    Type.normal
  ];
  static List<String> tap_filled_button = [
    "0x02",
    "tap_filled_button",
    Type.normal
  ];
  static List<String> api_get_form = ["0x03", "api_get_form", Type.api];
  static List<String> tap_fill_from_button = [
    "1x01",
    "tap_fill_from_button",
    Type.normal
  ];
  static List<String> tap_back_icon = ["tap_back_icon", Type.normal];
  static List<String> api_get_detail_form = [
    "1x04",
    "api_get_detail_form",
    Type.api
  ];
  static List<String> tap_text_field = ["2x01", "tap_text_field", Type.normal];
  static List<String> tap_checkbox = ["2x02", "tap_checkbox", Type.normal];
  static List<String> tap_rating = ["2x03", "tap_rating", Type.normal];
  static List<String> tap_time_picker = [
    "2x04",
    "tap_time_picker",
    Type.normal
  ];
  static List<String> tap_select_time_picker = [
    "2x05",
    "tap_select_time_picker",
    Type.normal
  ];
  static List<String> tap_cancel_time_picker = [
    "2x06",
    "tap_cancel_time_picker",
    Type.normal
  ];
  static List<String> tap_ok_time_picker = [
    "2x06",
    "tap_ok_time_picker",
    Type.normal
  ];
  static List<String> tap_date_picker = [
    "2x07",
    "tap_date_picker",
    Type.normal
  ];
  static List<String> tap_select_date_picker = [
    "2x08",
    "tap_select_date_picker",
    Type.normal
  ];
  static List<String> tap_cancel_date_picker = [
    "2x09",
    "tap_cancel_date_picker",
    Type.normal
  ];
  static List<String> tap_ok_date_picker = [
    "2x10",
    "tap_ok_date_picker",
    Type.normal
  ];
  static List<String> tap_radio_button = [
    "2x11",
    "tap_radio_button",
    Type.normal
  ];
  static List<String> tap_dropdown_button = [
    "2x12",
    "tap_dropdown_button",
    Type.normal
  ];
  static List<String> tap_select_dropdown = [
    "2x13",
    "tap_select_dropdown",
    Type.normal
  ];
  static List<String> tap_submit_button = [
    "2x14",
    "tap_submit_button",
    Type.normal
  ];
  static List<String> tap_cancel_fill_pop_up = [
    "2x15",
    "tap_cancel_fill_pop_up",
    Type.local
  ];
  static List<String> api_submit_google_sheet = [
    "2x16",
    "api_submit_google_sheet",
    Type.api
  ];
  static List<String> local_save_filled_form = [
    "2x17",
    "local_save_filled_form",
    Type.local
  ];
  static List<String> tap_back_icon_history = [
    "3x01",
    "tap_back_icon",
    Type.normal
  ];
  static List<String> tap_review_fill_form_button = [
    "3x02",
    "tap_review_fill_form_button",
    Type.normal
  ];
  static List<String> get_filled_form_local = [
    "3x06",
    "get_filled_form_local",
    Type.local
  ];
  static List<String> tap_review_form_button = [
    "4x01",
    "tap_review_form_button",
    Type.normal
  ];
  static List<String> tap_back_icon_review_detail = [
    "4x02",
    "tap_back_icon",
    Type.normal
  ];
  static List<String> local_get_detail_form = [
    "4x03",
    "local_get_detail_form",
    Type.local
  ];
  static List<String> tap_back_icon_review_filled = [
    "5x01",
    "tap_back_icon",
    Type.normal
  ];
  static List<String> local_get_filled_form_local = [
    "5x02",
    "local_get_filled_form_local",
    Type.local
  ];
  static List<String> tap_back_icon_success = [
    "6x01",
    "tap_back_icon",
    Type.normal
  ];
  static List<String> tap_back_icon_fail = [
    "6x03",
    "tap_back_icon",
    Type.normal
  ];
}
