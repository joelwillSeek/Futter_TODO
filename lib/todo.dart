class TODO {
  final int? id;
  final String? title;
  final String? detail;
  final DateTime? date;

  TODO(this.title, this.detail, this.date, this.id);

  String get forPrint {
    return "ID: $id, Title: $title, Description:$detail, Date:$date";
  }

  Map<String, Object?> get toMap {
    return {
      "id": id,
      "title": title,
      "detail": detail,
      "date": date,
    };
  }
}
