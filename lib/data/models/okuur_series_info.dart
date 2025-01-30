class OkuurSeriesInfo {
  String? id;
  bool active;
  int dayCount;
  String startingDate;
  String finishingDate;

  OkuurSeriesInfo({
    this.id,
    required this.active,
    required this.dayCount,
    required this.startingDate,
    required this.finishingDate,
  });

  factory OkuurSeriesInfo.fromJson(Map<String, dynamic> json) {
    return OkuurSeriesInfo(
      id: json['id'],
      active: json['active'],
      dayCount: json['dayCount'],
      startingDate: json['startingDate'],
      finishingDate: json['finishingDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'active': active,
      'dayCount': dayCount,
      'startingDate': startingDate,
      'finishingDate': finishingDate,
    };
  }
}