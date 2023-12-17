// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:aqi_today/data/model/chart/aqi_chart.dart';
import 'package:aqi_today/domain/model/home_state.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : super(HomeState(
            aqiHourData: {},
            pm1HourData: {},
            pm10HourData: {},
            pm25HourData: {},
            aqiPredictData: [],
            pm1PredictData: [],
            pm10PredictData: [],
            pm25PredictData: []));

  StreamSubscription? _aqiLiveSubscription;
  StreamSubscription? _aqiPredictSubscription;
  StreamSubscription? _pm1LiveSubscription;
  StreamSubscription? _pm10LiveSubscription;
  StreamSubscription? _pm25LiveSubscription;

  Future<void> initState(BuildContext context) async {
    liveDataStream();
    liveChartDataStream();
  }

  @override
  Future<void> close() {
    // _aqiLiveSubscription?.cancel();
    // _aqiPredictSubscription?.cancel();
    // _pm1LiveSubscription?.cancel();
    // _pm10LiveSubscription?.cancel();
    // _pm25LiveSubscription?.cancel();

    return super.close();
  }

  void liveDataStream() {
    final aqiLive = FirebaseDatabase.instance.ref('hour_val/AQI');
    final pm1Live = FirebaseDatabase.instance.ref('value/pm1');
    final pm10Live = FirebaseDatabase.instance.ref('value/pm10');
    final pm25Live = FirebaseDatabase.instance.ref('value/pm25');
    final aqiPredict = FirebaseDatabase.instance.ref('AQI_predict_today/AQI');
    _aqiLiveSubscription = aqiLive.onValue.listen((event) {
      final data = event.snapshot.value;
      setAQILive(int.parse(data.toString()));
    });
    _aqiPredictSubscription = aqiPredict.onValue.listen((event) {
      final data = event.snapshot.value;
      setAQIPredict(int.parse(data.toString()));
    });
    _pm1LiveSubscription = pm1Live.onValue.listen((event) {
      final data = event.snapshot.value;
      setPm1(int.parse(data.toString()));
    });
    _pm10LiveSubscription = pm10Live.onValue.listen((event) {
      final data = event.snapshot.value;
      setPm10(int.parse(data.toString()));
    });
    _pm25LiveSubscription = pm25Live.onValue.listen((event) {
      final data = event.snapshot.value;
      setPm25(int.parse(data.toString()));
    });
  }

  void liveChartDataStream() {
    final aqiHourData = FirebaseDatabase.instance.ref('hour_val/AQI');
    final pm1HourtData = FirebaseDatabase.instance.ref('hour_val/pm1');
    final pm10HourtData = FirebaseDatabase.instance.ref('hour_val/pm10');
    final pm25HourtData = FirebaseDatabase.instance.ref('hour_val/pm25');
    final aqiPrerdictData = FirebaseDatabase.instance.ref('predict/AQI');
    final pm10PrerdictData = FirebaseDatabase.instance.ref('predict/pm10');
    final pm25PrerdictData = FirebaseDatabase.instance.ref('predict/pm25');

    aqiHourData.onValue.listen((event) {
      final listData = state.aqiHourData;
      listData.addAll({DateTime.now() : event.snapshot.value as int});
      setAQIHourDataChart(listData);
    });

    pm1HourtData.onValue.listen((event) {
      final listData = state.pm1HourData;
      listData.addAll({DateTime.now() : event.snapshot.value as double});
      setPM1HourDataChart(listData);
    });

    pm10HourtData.onValue.listen((event) {
      final listData = state.pm10HourData;
      listData.addAll({DateTime.now() : event.snapshot.value as double});
      setPM10HourDataChart(listData);
    });

    pm25HourtData.onValue.listen((event) {
      final listData = state.pm25HourData;
      listData.addAll({DateTime.now() : event.snapshot.value as double});
      setPM25HourDataChart(listData);
    });

    aqiPrerdictData.onValue.listen((event) {
      final listData = List.filled(24, 0);
      for (final hour in event.snapshot.children) {
        int _hour = int.parse(hour.key!.split('_').last);
        listData[_hour] = hour.value as int;
      }
      setAQIPredictDataChart(listData);
    });

    pm10PrerdictData.onValue.listen((event) {
      final listData = List.filled(24, 0.0);
      for (final hour in event.snapshot.children) {
        int _hour = int.parse(hour.key!.split('_').last);
        listData[_hour] = hour.value as double;
      }
      setPM10PredictDataChart(listData);
    });

    pm25PrerdictData.onValue.listen((event) {
      final listData = List.filled(24, 0.0);
      for (final hour in event.snapshot.children) {
        int _hour = int.parse(hour.key!.split('_').last);
        listData[_hour] = hour.value as double;
      }
      setPM25PredictDataChart(listData);
    });
  }

  void setAQIHourDataChart(Map<DateTime, int> data) {
    emit(state.copyWith(aqiHourData: data));
  }

  void setPM1HourDataChart(Map<DateTime, double> data) {
    emit(state.copyWith(pm1HourData: data));
  }

  void setPM10HourDataChart(Map<DateTime, double> data) {
    emit(state.copyWith(pm10HourData: data));
  }

  void setPM25HourDataChart(Map<DateTime, double> data) {
    emit(state.copyWith(pm25HourData: data));
  }

  List<AQIChart> getAQIHourDataChart(){
    List<AQIChart> _listDataChart = [];
    final _data = state.aqiHourData;
    _data.forEach((key, value){
      _listDataChart.add(AQIChart(key.hour == 0 ? DateFormat('d/M').format(key) : key.hour.toString(), value as double));
    });
    if (_listDataChart.length > 24){
      return _listDataChart.getRange(_listDataChart.length - 24, _listDataChart.length).toList();
    } else if(_listDataChart.length < 24){
      List<AQIChart> _emptyList = List.filled(24 - _listDataChart.length, AQIChart('NaN', 0));
      return _emptyList.followedBy(_listDataChart).toList();
    }
    return _listDataChart;
  }

  List<AQIChart> getPM1HourDataChart(){
    List<AQIChart> _listDataChart = [];
    final _data = state.pm1HourData;
    _data.forEach((key, value){
      _listDataChart.add(AQIChart(key.hour == 0 ? DateFormat('d/M').format(key) : key.hour.toString(), value));
    });
    if (_listDataChart.length > 24){
      return _listDataChart.getRange(_listDataChart.length - 24, _listDataChart.length).toList();
    } else if(_listDataChart.length < 24){
      List<AQIChart> _emptyList = List.filled(24 - _listDataChart.length, AQIChart('NaN', 0));
      return _emptyList.followedBy(_listDataChart).toList();
    }
    return _listDataChart;
  }

  List<AQIChart> getPM10HourDataChart(){
    List<AQIChart> _listDataChart = [];
    final _data = state.pm10HourData;
    _data.forEach((key, value){
      _listDataChart.add(AQIChart(key.hour == 0 ? DateFormat('d/M').format(key) : key.hour.toString(), value));
    });
    if (_listDataChart.length > 24){
      return _listDataChart.getRange(_listDataChart.length - 24, _listDataChart.length).toList();
    } else if(_listDataChart.length < 24){
      List<AQIChart> _emptyList = List.filled(24 - _listDataChart.length, AQIChart('NaN', 0));
      return _emptyList.followedBy(_listDataChart).toList();
    }
    return _listDataChart;
  }

  List<AQIChart> getPM25HourDataChart(){
    List<AQIChart> _listDataChart = [];
    final _data = state.pm25HourData;
    _data.forEach((key, value){
      _listDataChart.add(AQIChart(key.hour == 0 ? DateFormat('d/M').format(key) : key.hour.toString(), value));
    });
    if (_listDataChart.length > 24){
      return _listDataChart.getRange(_listDataChart.length - 24, _listDataChart.length).toList();
    } else if(_listDataChart.length < 24){
      List<AQIChart> _emptyList = List.filled(24 - _listDataChart.length, AQIChart('NaN', 0));
      return _emptyList.followedBy(_listDataChart).toList();
    }
    return _listDataChart;
  }

  void setAQIPredictDataChart(List<int> data) {
    List<AQIChart> _listDataChart = [];
    int _index = 0;
    for (final child in data) {
      _listDataChart.add(AQIChart(_index.toString(), child.toDouble()));
      _index++;
    }
    emit(state.copyWith(aqiPredictData: _listDataChart));
  }

  void setPM1PredictDataChart(List<int> data) {
    List<AQIChart> _listDataChart = [];
    int _index = 0;
    for (final child in data) {
      _listDataChart.add(AQIChart(_index.toString(), child.toDouble()));
      _index++;
    }
    emit(state.copyWith(pm1PredictData: _listDataChart));
  }

  void setPM10PredictDataChart(List<double> data) {
    List<AQIChart> _listDataChart = [];
    int _index = 0;
    for (final child in data) {
      _listDataChart.add(AQIChart(_index.toString(), child.toDouble()));
      _index++;
    }
    emit(state.copyWith(pm10PredictData: _listDataChart));
  }

  void setPM25PredictDataChart(List<double> data) {
    List<AQIChart> _listDataChart = [];
    int _index = 0;
    for (final child in data) {
      _listDataChart.add(AQIChart(_index.toString(), child.toDouble()));
      _index++;
    }
    emit(state.copyWith(pm25PredictData: _listDataChart));
  }

  void setAQILive(int data) {
    emit(state.copyWith(aqiLive: data));
  }

  void setAQIPredict(int data) {
    emit(state.copyWith(aqiPredict: data));
  }

  void setPm1(int data) {
    emit(state.copyWith(pm1Live: data));
  }

  void setPm10(int data) {
    emit(state.copyWith(pm10Live: data));
  }

  void setPm25(int data) {
    emit(state.copyWith(pm25Live: data));
  }
}
