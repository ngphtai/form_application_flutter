extension UrlConverter on String {
  String toUrl(Map<String, dynamic> params) {
    String url = this;
    if (params.isNotEmpty) {
      url += "?";
      url += params.entries
          .map((entry) =>
              "${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value.toString())}")
          .join("&");
    }
    return url;
  }
}
