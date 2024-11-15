extension StringToDateTime on String {
  DateTime? toDateTime({String pattern = "yyyy-MM-dd HH:mm:ss"}) {
    try {
      return DateTime.parse(this);
    } catch (e) {
      print("Error parsing date: $e");
      return null;
    }
  }
}
