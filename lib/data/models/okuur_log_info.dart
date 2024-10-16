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
}