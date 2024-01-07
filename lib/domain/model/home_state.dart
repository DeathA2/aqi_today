import 'package:aqi_today/data/model/chart/aqi_chart.dart';

class HomeState {
  final int aqiLive;
  final int pm1Live;
  final int pm10Live;
  final int pm25Live;
  final Map<String, int> aqiHourData;
  final Map<String, double> pm1HourData;
  final Map<String, double> pm10HourData;
  final Map<String, double> pm25HourData;

  final int aqiPredict;
  final List<AQIChart> aqiPredictData;
  final List<AQIChart> pm1PredictData;
  final List<AQIChart> pm10PredictData;
  final List<AQIChart> pm25PredictData;

  HomeState({
    this.aqiLive = 0,
    this.pm1Live = 0,
    this.pm10Live = 0,
    this.pm25Live = 0,
    required this.aqiHourData,
    required this.pm1HourData,
    required this.pm10HourData,
    required this.pm25HourData,
    this.aqiPredict = 0,
    required this.aqiPredictData,
    required this.pm1PredictData,
    required this.pm10PredictData,
    required this.pm25PredictData,
  });

  HomeState copyWith({
    int? aqiLive,
    int? pm1Live,
    int? pm10Live,
    int? pm25Live,
    Map<String, int>? aqiHourData,
    Map<String, double>? pm1HourData,
    Map<String, double>? pm10HourData,
    Map<String, double>? pm25HourData,
    int? aqiPredict,
    List<AQIChart>? aqiPredictData,
    List<AQIChart>? pm1PredictData,
    List<AQIChart>? pm10PredictData,
    List<AQIChart>? pm25PredictData,
  }) =>
      HomeState(
          aqiLive: aqiLive ?? this.aqiLive,
          pm1Live: pm1Live ?? this.pm1Live,
          pm10Live: pm10Live ?? this.pm10Live,
          pm25Live: pm25Live ?? this.pm25Live,
          aqiHourData: aqiHourData ?? this.aqiHourData,
          pm1HourData: pm1HourData ?? this.pm1HourData,
          pm10HourData: pm10HourData ?? this.pm10HourData,
          pm25HourData: pm25HourData ?? this.pm25HourData,
          aqiPredict: aqiPredict ?? this.aqiPredict,
          aqiPredictData: aqiPredictData ?? this.aqiPredictData,
          pm1PredictData: pm1PredictData ?? this.pm1PredictData,
          pm10PredictData: pm10PredictData ?? this.pm10PredictData,
          pm25PredictData: pm25PredictData ?? this.pm25PredictData);
}
