class OkuurLogInfo {
  String? id;
  String bookId;
  int numberOfPages;
  int timeRead;
  String readingDate;
  String finishingTime;

  OkuurLogInfo({
    this.id,
    required this.bookId,
    required this.numberOfPages,
    required this.timeRead,
    required this.readingDate,
    required this.finishingTime,
  });

  factory OkuurLogInfo.fromJson(Map<String, dynamic> json) {
    return OkuurLogInfo(
      id: json['id'],
      bookId: json['bookId'],
      numberOfPages: json['numberOfPages'],
      timeRead: json['timeRead'],
      readingDate: json['readingDate'],
      finishingTime: json['finishingTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookId': bookId,
      'numberOfPages': numberOfPages,
      'timeRead': timeRead,
      'readingDate': readingDate,
      'finishingTime': finishingTime,
    };
  }

  OkuurLogInfo copyWith({
    String? id,
    String? bookId,
    int? numberOfPages,
    int? timeRead,
    String? readingDate,
    String? finishingTime,
  }) {
    return OkuurLogInfo(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      numberOfPages: numberOfPages ?? this.numberOfPages,
      timeRead: timeRead ?? this.timeRead,
      readingDate: readingDate ?? this.readingDate,
      finishingTime: finishingTime ?? this.finishingTime,
    );
  }
}
