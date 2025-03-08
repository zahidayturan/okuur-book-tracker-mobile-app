import 'package:okuur/data/models/okuur_book_info.dart';
import 'package:okuur/data/models/okuur_log_info.dart';

class OkuurBookAndLogInfo {

  OkuurBookInfo bookInfo;
  OkuurLogInfo okuurLogInfo;

  OkuurBookAndLogInfo({
    required this.bookInfo,
    required this.okuurLogInfo,
  });
}