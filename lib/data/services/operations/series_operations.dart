import 'package:okuur/core/utils/firestore_series_helper.dart';
import 'package:okuur/core/utils/get_storage_helper.dart';
import 'package:okuur/data/models/okuur_series_info.dart';
import 'package:okuur/data/services/series_service.dart';
import 'package:okuur/ui/utils/date_formatter.dart';

class SeriesOperations implements SeriesService {

  @override
  Future<void> newSeriesInfo(String logReadingDate) async {
    DateTime logDate = OkuurDateFormatter.stringToDateTime(logReadingDate);
    DateTime currentDate = DateTime.now();
    DateTime currentDayOnly = DateTime(currentDate.year, currentDate.month, currentDate.day);
    DateTime logDayOnly = DateTime(logDate.year, logDate.month, logDate.day);
    bool isCurrentDay = currentDayOnly.isAtSameMomentAs(logDayOnly);

    if(isCurrentDay){
      OkuurSeriesInfo? activeSeriesInfo = await getActiveSeriesInfo();
      if(activeSeriesInfo != null && activeSeriesInfo.active){
        // Aktif seri var
        DateTime seriesFinishingDate = OkuurDateFormatter.stringToDateTime(activeSeriesInfo.finishingDate);

        if(currentDayOnly.isAtSameMomentAs(seriesFinishingDate) == false && currentDayOnly.difference(seriesFinishingDate).inDays <= 1){
          // bugün ve serinin son tarihi aynı gün değilse ve arada 1 günlük fark yoksa
          // Seri güncelleme
          activeSeriesInfo.dayCount += 1;
          activeSeriesInfo.finishingDate = logDayOnly.toString();
          await updateSeriesInfo(activeSeriesInfo);
        } else if(currentDayOnly.isAfter(seriesFinishingDate)){
          // bugün ve serinin son tarihi arasında 1 günden fazla fark varsa
          // Eski seriyi kapat, yeni seri aç
          activeSeriesInfo.active = false;
          await updateSeriesInfo(activeSeriesInfo);

          OkuurSeriesInfo newSeriesInfo = OkuurSeriesInfo(
              active: true,
              dayCount: 1,
              startingDate: currentDayOnly.toString(),
              finishingDate: currentDayOnly.toString());
          await insertSeriesInfo(newSeriesInfo);
        }
      } else {
        // Aktif seri yok, yeni seri aç
        OkuurSeriesInfo newSeriesInfo = OkuurSeriesInfo(
            active: true,
            dayCount: 1,
            startingDate: currentDayOnly.toString(),
            finishingDate: currentDayOnly.toString());
        await insertSeriesInfo(newSeriesInfo);
      }
    }
  }


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

  @override
  Future<OkuurSeriesInfo?> getActiveSeriesInfo() async {
    String? uid = OkuurLocalStorage().getActiveUserUid();
    return await FirestoreSeriesOperation().getActiveSeriesInfo(uid!);
  }

  @override
  Future<Map<String, dynamic>> getSeriesInfoForMonth(DateTime startingDate, DateTime finishedDate) async {
    String? uid = OkuurLocalStorage().getActiveUserUid();
    return await FirestoreSeriesOperation().getAllSeriesInfo(uid!,startingDate,finishedDate);
  }

  @override
  Future<Map<String,dynamic>> getBestAndActiveSeriesInfo()async{
    String? uid = OkuurLocalStorage().getActiveUserUid();
    return await FirestoreSeriesOperation().getBestAndActiveSeries(uid!);
  }
}