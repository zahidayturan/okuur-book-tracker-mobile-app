import 'dart:async';
import 'package:okuur/data/models/okuur_series_info.dart';

abstract class SeriesService {

  Future<void> newSeriesInfo(String logReadingDate);

  Future<void> insertSeriesInfo(OkuurSeriesInfo seriesInfo);

  Future<void> deleteSeriesInfo(String seriesId);

  Future<void> updateSeriesInfo(OkuurSeriesInfo seriesInfo);

  Future<OkuurSeriesInfo?> getActiveSeriesInfo();

  Future<Map<String, dynamic>> getSeriesInfoForMonth(DateTime startingDate, DateTime finishedDate);
}