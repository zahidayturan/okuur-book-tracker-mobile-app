import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/data/models/okuur_log_info.dart';

class OkuurHomeLogInfo {

  OkuurBookInfo bookInfo;
  OkuurLogInfo okuurLogInfo;

  OkuurHomeLogInfo({
    required this.bookInfo,
    required this.okuurLogInfo,
  });
}