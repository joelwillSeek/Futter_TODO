class TODO {
  final String? _title;
  final String? _detail;
  final String? _date;

  TODO(this._title, this._detail, this._date);

  String get forPrint {
    return "Title: $_title, Description:$_detail, Date:$_date";
  }

  Map<String, Object?> get toMap {
    return {
      "title": title,
      "detail": detail,
      "date": date,
    };
  }

  String? get title {
    return _title;
  }

  String? get detail {
    return _detail;
  }

  String? get date {
    return _date;
  }
}
