import 'package:aqi_today/application/ultils/build_context_extension.dart';
import 'package:aqi_today/application/ultils/spacing.dart';
import 'package:aqi_today/data/model/chart/aqi_chart.dart';
import 'package:aqi_today/domain/bloc/home_cubit.dart';
import 'package:aqi_today/domain/model/home_state.dart';
import 'package:aqi_today/presentation/widgets/data_with_title.dart';
import 'package:aqi_today/src/colors/color_manager.dart';
import 'package:aqi_today/src/imgs/imgs_manager.dart';
import 'package:aqi_today/src/texts/string_manager.dart';
import 'package:aqi_today/src/value/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().initState(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQueryValues(context).width,
        height: MediaQueryValues(context).height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageApp.hcmBg), fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildHeaderBar(),
            SpacingApp.spacingVertical(PaddingApp.p32),
            Expanded(child: _buildBody())
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderBar() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
          horizontal: PaddingApp.p24, vertical: PaddingApp.p12),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(RadiusApp.r10),
              bottomRight: Radius.circular(RadiusApp.r10)),
          color: ColorApp.black.withOpacity(0.8)),
      child: Row(
        children: [
          Expanded(flex: 1, child: _renderMiniLogo()),
          _renderCity(),
          SpacingApp.spacingHorizontal(PaddingApp.p16),
          _renderLanguage(),
        ],
      ),
    );
  }

  Widget _renderMiniLogo() {
    return Container(
      alignment: Alignment.centerLeft,
      height: SizeApp.s75,
      child: Image.asset(
        ImageApp.logoApp,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _renderCity() {
    return Container(
      padding: const EdgeInsets.only(
          top: PaddingApp.p5, bottom: PaddingApp.p5, left: PaddingApp.p12),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: ColorApp.white))),
      child: Row(
        children: [
          Text(
            'Ho Chi Minh',
            style: TextStyle(
                fontSize: FontSizeApp.s16,
                color: ColorApp.white,
                fontWeight: FontWeight.w500),
          ),
          SpacingApp.spacingHorizontal(PaddingApp.p5),
          Icon(
            Icons.arrow_drop_down_sharp,
            color: ColorApp.white,
          )
        ],
      ),
    );
  }

  Widget _renderLanguage() {
    return Container(
      padding: const EdgeInsets.only(
          top: PaddingApp.p5, bottom: PaddingApp.p5, left: PaddingApp.p12),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: ColorApp.white))),
      child: Row(
        children: [
          Text(
            'ENGLISH',
            style: TextStyle(
                fontSize: FontSizeApp.s16,
                color: ColorApp.white,
                fontWeight: FontWeight.w700),
          ),
          SpacingApp.spacingHorizontal(PaddingApp.p5),
          Icon(
            Icons.arrow_drop_down_sharp,
            color: ColorApp.white,
          )
        ],
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Container(
        width: MediaQueryValues(context).width * 0.9,
        padding: const EdgeInsets.all(PaddingApp.p16),
        child: Column(
          children: [
            _buildAQIToday(),
            SpacingApp.spacingVertical(PaddingApp.p32),
            _buildAQILiveChart(),
            SpacingApp.spacingVertical(PaddingApp.p32),
            _buildPMLiveChart(),
            SpacingApp.spacingVertical(PaddingApp.p32),
            _buildAQIPredictChart(),
            SpacingApp.spacingVertical(PaddingApp.p32),
            _buildPMPredictChart(),
          ],
        ),
      ),
    );
  }

  Widget _buildAQIToday() {
    return Container(
      decoration: BoxDecoration(
        color: ColorApp.greySecondary.withOpacity(0.75),
        borderRadius: BorderRadius.circular(RadiusApp.r16),
      ),
      padding: const EdgeInsets.all(PaddingApp.p16),
      child: Row(
        children: [
          Expanded(
            child: _renderAQIDataToday(),
          ),
          SpacingApp.spacingHorizontal(PaddingApp.p32),
          _renderAQILottie(),
        ],
      ),
    );
  }

  Widget _renderAQIDataToday() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            border: Border.all(color: ColorApp.white),
            borderRadius: BorderRadius.circular(RadiusApp.r16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [_renderAQILive(), _renderAQIPredictToday()],
          ),
        ),
        SpacingApp.spacingVertical(PaddingApp.p32),
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            border: Border.all(color: ColorApp.white),
            borderRadius: BorderRadius.circular(RadiusApp.r16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: PaddingApp.p12, vertical: PaddingApp.p5),
                  decoration: BoxDecoration(
                      color: ColorApp.white,
                      borderRadius: BorderRadius.circular(RadiusApp.r16)),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.circle,
                        color: Colors.red,
                      ),
                      Text(
                        'LIVE',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _renderPM1(),
                  _renderPM10(),
                  _renderPM25(),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _renderAQILive() {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (pre, cur) => pre.aqiLive != cur.aqiLive,
      builder: (context, state) {
        return DataWithTitle(
            data: state.aqiLive.toString(),
            title: StringsApp.aQILive,
            dataStyle: TextStyle(
                fontFamily: 'Rubik',
                fontSize: FontSizeApp.s30,
                fontWeight: FontWeight.w700,
                color: ColorApp.white),
            titleStyle: TextStyle(
                fontFamily: 'Rubik',
                fontSize: FontSizeApp.s20,
                fontWeight: FontWeight.w400,
                color: ColorApp.white),
            padding: PaddingApp.p5);
      },
    );
  }

  Widget _renderAQIPredictToday() {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (pre, cur) => pre.aqiPredict != cur.aqiPredict,
      builder: (context, state) {
        return DataWithTitle(
            data: state.aqiPredict.toString(),
            title: StringsApp.aQIPredictToday,
            dataStyle: TextStyle(
                fontFamily: 'Rubik',
                fontSize: FontSizeApp.s30,
                fontWeight: FontWeight.w700,
                color: ColorApp.white),
            titleStyle: TextStyle(
                fontFamily: 'Rubik',
                fontSize: FontSizeApp.s20,
                fontWeight: FontWeight.w400,
                color: ColorApp.white),
            padding: PaddingApp.p5);
      },
    );
  }

  Widget _renderPM1() {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (pre, cur) => pre.pm1Live != cur.pm1Live,
      builder: (context, state) {
        return DataWithTitle(
            data: state.pm1Live.toString(),
            title: StringsApp.pm1,
            dataStyle: TextStyle(
                fontFamily: 'Rubik',
                fontSize: FontSizeApp.s30,
                fontWeight: FontWeight.w700,
                color: ColorApp.white),
            titleStyle: TextStyle(
                fontFamily: 'Rubik',
                fontSize: FontSizeApp.s20,
                fontWeight: FontWeight.w400,
                color: ColorApp.white),
            padding: PaddingApp.p5);
      },
    );
  }

  Widget _renderPM10() {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (pre, cur) => pre.pm10Live != cur.pm10Live,
      builder: (context, state) {
        return DataWithTitle(
            data: state.pm10Live.toString(),
            title: StringsApp.pm10,
            dataStyle: TextStyle(
                fontFamily: 'Rubik',
                fontSize: FontSizeApp.s30,
                fontWeight: FontWeight.w700,
                color: ColorApp.white),
            titleStyle: TextStyle(
                fontFamily: 'Rubik',
                fontSize: FontSizeApp.s20,
                fontWeight: FontWeight.w400,
                color: ColorApp.white),
            padding: PaddingApp.p5);
      },
    );
  }

  Widget _renderPM25() {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (pre, cur) => pre.pm25Live != cur.pm25Live,
      builder: (context, state) {
        return DataWithTitle(
            data: state.pm25Live.toString(),
            title: StringsApp.pm25,
            dataStyle: TextStyle(
                fontFamily: 'Rubik',
                fontSize: FontSizeApp.s30,
                fontWeight: FontWeight.w700,
                color: ColorApp.white),
            titleStyle: TextStyle(
                fontFamily: 'Rubik',
                fontSize: FontSizeApp.s20,
                fontWeight: FontWeight.w400,
                color: ColorApp.white),
            padding: PaddingApp.p5);
      },
    );
  }

  Widget _renderAQILottie() {
    return Lottie.asset(ImageApp.airQuality,
        width: SizeApp.s300,
        frameRate: FrameRate.max,
        options: LottieOptions());
  }

  Widget _buildAQILiveChart() {
    return Container(
      decoration: BoxDecoration(
        color: ColorApp.greySecondary.withOpacity(0.75),
        borderRadius: BorderRadius.circular(RadiusApp.r16),
      ),
      padding: const EdgeInsets.all(PaddingApp.p16),
      child: BlocSelector<HomeCubit, HomeState, List<AQIChart>>(
        selector: (state) {
          return context.read<HomeCubit>().getAQIHourDataChart();
        },
        builder: (context, state) {
          return SfCartesianChart(
              title: ChartTitle(
                  text: StringsApp.aQILiveChart,
                  textStyle: TextStyle(
                      fontFamily: 'Space',
                      fontSize: FontSizeApp.s30,
                      fontWeight: FontWeight.w700,
                      color: ColorApp.white)),
              borderColor: Colors.white,
              borderWidth: SizeApp.s3,
              palette: [ColorApp.greenButton],
              plotAreaBackgroundColor: ColorApp.white,
              enableAxisAnimation: true,
              legend: Legend(
                  isVisible: true,
                  position: LegendPosition.bottom,
                  textStyle: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: FontSizeApp.s16,
                      color: ColorApp.white)),
              primaryYAxis: NumericAxis(
                  labelStyle: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: FontSizeApp.s16,
                      color: ColorApp.white)),
              primaryXAxis: CategoryAxis(
                  labelStyle: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: FontSizeApp.s16,
                      color: ColorApp.white)),
              series: <ChartSeries>[
                // Renders line chart
                LineSeries<AQIChart, String>(
                    name: StringsApp.aQIToday,
                    dataSource: state,
                    dataLabelSettings: const DataLabelSettings(
                        labelPosition: ChartDataLabelPosition.outside,
                        isVisible: true),
                    xValueMapper: (AQIChart data, _) => data.hour,
                    yValueMapper: (AQIChart data, _) => data.value)
              ]);
        },
      ),
    );
  }

  Widget _buildPMLiveChart() {
    return Container(
      decoration: BoxDecoration(
        color: ColorApp.greySecondary.withOpacity(0.75),
        borderRadius: BorderRadius.circular(RadiusApp.r16),
      ),
      padding: const EdgeInsets.all(PaddingApp.p16),
      child: BlocBuilder<HomeCubit, HomeState>(
        // buildWhen: (pre, cur) =>
        //     pre.pm1HourData != cur.pm1HourData ||
        //     pre.pm10HourData != cur.pm10HourData ||
        //     pre.pm25HourData != cur.pm25HourData,
        builder: (context, state) {
          return SfCartesianChart(
              title: ChartTitle(
                  text: StringsApp.pmLiveChart,
                  textStyle: TextStyle(
                      fontFamily: 'Space',
                      fontSize: FontSizeApp.s30,
                      fontWeight: FontWeight.w700,
                      color: ColorApp.white)),
              borderColor: Colors.white,
              borderWidth: SizeApp.s3,
              palette: [
                ColorApp.redHeartRate,
                ColorApp.bluePrimary,
                ColorApp.greenButton
              ],
              tooltipBehavior:
                  TooltipBehavior(enable: true, canShowMarker: true),
              plotAreaBackgroundColor: ColorApp.white,
              enableAxisAnimation: true,
              legend: Legend(
                  isVisible: true,
                  position: LegendPosition.bottom,
                  textStyle: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: FontSizeApp.s16,
                      color: ColorApp.white)),
              primaryYAxis: NumericAxis(
                  labelStyle: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: FontSizeApp.s16,
                      color: ColorApp.white)),
              primaryXAxis: CategoryAxis(
                  labelStyle: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: FontSizeApp.s16,
                      color: ColorApp.white)),
              series: <ChartSeries>[
                LineSeries<AQIChart, String>(
                    name: StringsApp.pm1Today,
                    dataSource: context.read<HomeCubit>().getPM1HourDataChart(),
                    markerSettings: const MarkerSettings(isVisible: true),
                    xValueMapper: (AQIChart data, _) => data.hour,
                    yValueMapper: (AQIChart data, _) => data.value),
                LineSeries<AQIChart, String>(
                    name: StringsApp.pm10Today,
                    dataSource:
                        context.read<HomeCubit>().getPM10HourDataChart(),
                    markerSettings: const MarkerSettings(isVisible: true),
                    xValueMapper: (AQIChart data, _) => data.hour,
                    yValueMapper: (AQIChart data, _) => data.value),
                LineSeries<AQIChart, String>(
                    name: StringsApp.pm25Today,
                    dataSource:
                        context.read<HomeCubit>().getPM25HourDataChart(),
                    markerSettings: const MarkerSettings(isVisible: true),
                    xValueMapper: (AQIChart data, _) => data.hour,
                    yValueMapper: (AQIChart data, _) => data.value)
              ]);
        },
      ),
    );
  }

  Widget _buildAQIPredictChart() {
    return Container(
      decoration: BoxDecoration(
        color: ColorApp.greySecondary.withOpacity(0.75),
        borderRadius: BorderRadius.circular(RadiusApp.r16),
      ),
      padding: const EdgeInsets.all(PaddingApp.p16),
      child: BlocSelector<HomeCubit, HomeState, List<AQIChart>>(
        selector: (state) {
          return state.aqiPredictData;
        },
        builder: (context, state) {
          return SfCartesianChart(
              title: ChartTitle(
                  text: StringsApp.aQIPredictTodayChart,
                  textStyle: TextStyle(
                      fontFamily: 'Space',
                      fontSize: FontSizeApp.s30,
                      fontWeight: FontWeight.w700,
                      color: ColorApp.white)),
              // backgroundColor: ColorApp.white,
              borderColor: Colors.white,
              borderWidth: SizeApp.s3,
              palette: [ColorApp.greenButton],
              plotAreaBackgroundColor: ColorApp.white,
              enableAxisAnimation: true,
              legend: Legend(
                  isVisible: true,
                  position: LegendPosition.bottom,
                  textStyle: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: FontSizeApp.s16,
                      color: ColorApp.white)),
              primaryYAxis: NumericAxis(
                  labelStyle: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: FontSizeApp.s16,
                      color: ColorApp.white)),
              primaryXAxis: NumericAxis(
                  interval: 1,
                  labelStyle: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: FontSizeApp.s16,
                      color: ColorApp.white)),
              series: <ChartSeries>[
                // Renders line chart
                LineSeries<AQIChart, int>(
                    name: StringsApp.aQIPredictToday,
                    dataSource: state,
                    dataLabelSettings: const DataLabelSettings(
                        labelPosition: ChartDataLabelPosition.outside,
                        isVisible: true),
                    xValueMapper: (AQIChart data, _) => int.parse(data.hour),
                    yValueMapper: (AQIChart data, _) => data.value)
              ]);
        },
      ),
    );
  }

  Widget _buildPMPredictChart() {
    return Container(
      decoration: BoxDecoration(
        color: ColorApp.greySecondary.withOpacity(0.75),
        borderRadius: BorderRadius.circular(RadiusApp.r16),
      ),
      padding: const EdgeInsets.all(PaddingApp.p16),
      child: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (pre, cur) =>
            pre.pm10PredictData != cur.pm10PredictData ||
            pre.pm25PredictData != cur.pm25PredictData,
        builder: (context, state) {
          return SfCartesianChart(
              title: ChartTitle(
                  text: StringsApp.pMPredictTodayChart,
                  textStyle: TextStyle(
                      fontFamily: 'Space',
                      fontSize: FontSizeApp.s30,
                      fontWeight: FontWeight.w700,
                      color: ColorApp.white)),
              borderColor: Colors.white,
              borderWidth: SizeApp.s3,
              palette: [
                ColorApp.redHeartRate,
                ColorApp.bluePrimary,
                ColorApp.greenButton
              ],
              tooltipBehavior:
                  TooltipBehavior(enable: true, canShowMarker: true),
              plotAreaBackgroundColor: ColorApp.white,
              enableAxisAnimation: true,
              legend: Legend(
                  isVisible: true,
                  position: LegendPosition.bottom,
                  textStyle: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: FontSizeApp.s16,
                      color: ColorApp.white)),
              primaryYAxis: NumericAxis(
                  labelStyle: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: FontSizeApp.s16,
                      color: ColorApp.white)),
              primaryXAxis: NumericAxis(
                  interval: 1,
                  labelStyle: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: FontSizeApp.s16,
                      color: ColorApp.white)),
              series: <ChartSeries>[
                LineSeries<AQIChart, int>(
                    name: StringsApp.pm10Predict,
                    dataSource: state.pm10PredictData,
                    markerSettings: const MarkerSettings(isVisible: true),
                    xValueMapper: (AQIChart data, _) => int.parse(data.hour),
                    yValueMapper: (AQIChart data, _) => data.value),
                LineSeries<AQIChart, int>(
                    name: StringsApp.pm25Predict,
                    dataSource: state.pm25PredictData,
                    markerSettings: const MarkerSettings(isVisible: true),
                    xValueMapper: (AQIChart data, _) => int.parse(data.hour),
                    yValueMapper: (AQIChart data, _) => data.value)
              ]);
        },
      ),
    );
  }
}
