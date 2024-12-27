extension RemoveBracket on String {
  removeBracket() => replaceAll('[', '').replaceAll(']', '');
}
