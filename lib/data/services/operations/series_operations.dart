import 'package:okuur/core/utils/firestore_series_helper.dart';
import 'package:okuur/core/utils/get_storage_helper.dart';
import 'package:okuur/data/models/okuur_series_info.dart';
import 'package:okuur/data/services/series_service.dart';

class SeriesOperations implements SeriesService {

  @override
  Future<void> insertSeriesInfo(OkuurSeriesInfo seriesInfo) async {
    String? uid = OkuurLocalStorage().getActiveUserUid();
    await FirestoreSeriesOperation().addSeriesInfoToFirestore(uid!, seriesInfo);
  }

  @override
  Future<void> deleteSeriesInfo(String seriesId) async {
    String? uid = OkuurLocalStorage().getActiveUserUid();
    await FirestoreSeriesOperation().deleteSeriesInfo(uid!, seriesId);
  }

  @override
  Future<void> updateSeriesInfo(OkuurSeriesInfo seriesInfo) async {
    String? uid = OkuurLocalStorage().getActiveUserUid();
    await FirestoreSeriesOperation().updateSeriesInfo(uid!, seriesInfo);
  }
}