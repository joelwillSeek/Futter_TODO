class TODO {
  int _id = 0;
  final String? _title;
  final String? _detail;
  final DateTime? _date;

  TODO(this._title, this._detail, this._date);

  String get forPrint {
    return "ID: $_id, Title: $_title, Description:$_detail, Date:$_date";
  }

  Map<String, Object?> get toMap {
    return {
      "id": getID,
      "title": title,
      "detail": detail,
      "date": date,
    };
  }

  String? get title {
    return _title;
  }

  int get getID {
    return _id;
  }

  set setID(int value) {
    _id = value;
  }

  String? get detail {
    return _detail;
  }

  DateTime? get date {
    return _date;
  }
}
