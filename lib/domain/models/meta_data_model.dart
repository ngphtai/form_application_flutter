class MetaDataModel {
  final String id;
  final bool isFilled;
  final String title;
  final String imageURLDescription;
  final String description;
  final String publishedUrl;
  final List<String> editorEmails;
  final int count;
  final String confirmationMessage;
  final String customClosedFormMessage;
  MetaDataModel({
    required this.id,
    required this.isFilled,
    required this.title,
    required this.imageURLDescription,
    required this.description,
    required this.publishedUrl,
    required this.editorEmails,
    required this.count,
    required this.confirmationMessage,
    required this.customClosedFormMessage,
  });

  factory MetaDataModel.fromJson(Map<String, dynamic> json) {
    return MetaDataModel(
        id: json['id'],
        isFilled: json['isFilled'],
        title: json['title'],
        imageURLDescription: json['imageURLDescription'],
        description: json['description'],
        publishedUrl: json['publishedUrl'],
        editorEmails: json['editorEmails'],
        count: json['count'],
        confirmationMessage: json['confirmationMessage'],
        customClosedFormMessage: json['customClosedFormMessage']);
  }
}
