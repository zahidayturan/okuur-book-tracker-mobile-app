class OkuurBookInfo {
  int? id;
  String name;
  String author;
  int pageCount;
  String imageLink;
  String type;
  String startingDate;
  String finishingDate;
  int currentPage;
  int readingTime;
  int status;
  String logIds;

  OkuurBookInfo({
    this.id,
    required this.name,
    required this.author,
    required this.pageCount,
    required this.imageLink,
    required this.type,
    required this.startingDate,
    required this.finishingDate,
    required this.currentPage,
    required this.readingTime,
    required this.status,
    required this.logIds,
  });

  factory OkuurBookInfo.fromJson(Map<String, dynamic> json) {
    return OkuurBookInfo(
      name: json['name'],
      author: json['author'],
      pageCount: json['pageCount'],
      imageLink: json['imageLink'],
      type: json['type'],
      startingDate: json['startingDate'],
      finishingDate: json['finishingDate'],
      currentPage: json['currentPage'],
      readingTime: json['readingTime'],
      status: json['status'],
      logIds: json['logIds'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'author': author,
      'pageCount': pageCount,
      'imageLink': imageLink,
      'type': type,
      'startingDate': startingDate,
      'finishingDate': finishingDate,
      'currentPage': currentPage,
      'readingTime': readingTime,
      'status': status,
      'logIds': logIds,
    };
  }
}