class ItemModel {
  final String type;
  final String helpText;
  final String title;
  final int index;
  final int id;
  final bool? isRequired;
  final List<String>? choices;
  final int? upperBound;
  final String? rightLabel;
  final String? leftLabel;
  final int? lowerBound;
  final bool? includesYear;

  ItemModel(
      {required this.type,
      required this.helpText,
      required this.title,
      required this.index,
      required this.id,
      this.isRequired,
      this.choices,
      this.upperBound,
      this.rightLabel,
      this.leftLabel,
      this.lowerBound,
      this.includesYear});

  factory ItemModel.fromJSon(Map<String, dynamic> json) {
    return ItemModel(
        type: json['type'],
        helpText: json['helpText'],
        title: json['title'],
        index: json['index'],
        id: json['id'],
        isRequired: json['isRequired'],
        choices: json['choices'],
        upperBound: json['upperBound'],
        rightLabel: json['rightLabel'],
        leftLabel: json['leftLabel'],
        lowerBound: json['lowerBound'],
        includesYear: json['includesYear']);
  }
}
