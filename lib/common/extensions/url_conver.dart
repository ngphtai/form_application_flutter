extension UrlConverter on String {
  String toUrl(Map<String, dynamic> params) {
    String url = this;
    if (params.isNotEmpty) {
      url += "?";
      url += params.entries
          .map((entry) => "${entry.key}=${entry.value}")
          .join("&");
    }
    return url;
  }
}
