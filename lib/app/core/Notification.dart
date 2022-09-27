class NotificationModel {
  NotificationModel({
    this.title,
    this.body,
    this.dataTitle,
    this.dataBody,
  });

  String? title;
  String? body;
  String? dataTitle;
  String? dataBody;

  NotificationModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['message'];
  }
}
