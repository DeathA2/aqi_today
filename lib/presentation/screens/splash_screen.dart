import 'dart:async';

import 'package:aqi_today/application/ultils/spacing.dart';
import 'package:aqi_today/domain/bloc/home_cubit.dart';
import 'package:aqi_today/presentation/screens/main_screen.dart';
import 'package:aqi_today/src/colors/color_manager.dart';
import 'package:aqi_today/src/imgs/imgs_manager.dart';
import 'package:aqi_today/src/value/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  bool isError = false;
  _startDelay() async {
    _timer = Timer(const Duration(seconds: 1), _goNext);
  }

  _goNext() async {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => HomeCubit(),
                  child: const HomeScreen(),
                )));
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    _startDelay();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    _timer?.cancel();
  }

  BoxDecoration _renderGradientView() {
    return BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
          ColorApp.startGradient,
          ColorApp.centerGradient,
          ColorApp.endGradient,
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return _renderSplashScreen();
  }

  Widget _renderSplashScreen() {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: ColorApp.startGradient,
        elevation: ElevationApp.ev0,
        systemOverlayStyle: Theme.of(context).appBarTheme.systemOverlayStyle,
      ),
      body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: _renderGradientView(),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'TRƯỜNG ĐẠI HỌC SƯ PHẠM KỸ THUẬT',
                      style: TextStyle(
                          fontSize: FontSizeApp.s20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Alegreya",
                          color: Colors.black),
                    ),
                    const Text(
                      'KHOA ĐIỆN - ĐIỆN TỬ',
                      style: TextStyle(
                          fontSize: FontSizeApp.s20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Alegreya",
                          color: Colors.black),
                    ),
                    SpacingApp.spacingVertical(SizeApp.s20),
                    const Text(
                      'ĐỒ ÁN TỐT NGHIỆP',
                      style: TextStyle(
                          fontSize: FontSizeApp.s25,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Alegreya",
                          color: Colors.black),
                    ),
                    const Text(
                      'NGÀNH KỸ THUẬT Y SINH',
                      style: TextStyle(
                          fontSize: FontSizeApp.s20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Alegreya",
                          color: Colors.black),
                    ),
                    Image.asset(
                      ImageApp.logoYSinh,
                      color: Colors.white,
                      width: SizeApp.s150,
                    ),
                    SpacingApp.spacingVertical(SizeApp.s20),
                    Text(
                      'THIẾT KẾ VÀ THI CÔNG THIẾT BỊ ĐEO TAY PHÁT HIỆN TÉ NGÃ CHO NGƯỜI CAO TUỔI',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: FontSizeApp.s20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Alegreya",
                          color: Colors.red[900]),
                    ),
                    SpacingApp.spacingVertical(SizeApp.s36),
                    Row(
                      children: [
                        SpacingApp.spacingHorizontal(SizeApp.s20),
                        const Expanded(
                          child: Text(
                            'GVHD: Th.S Nguyễn Trường Duy',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: FontSizeApp.s16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    SpacingApp.spacingVertical(SizeApp.s16),
                    Row(
                      children: [
                        SpacingApp.spacingHorizontal(SizeApp.s20),
                        const Expanded(
                          child: Text(
                            'SVTH:',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: FontSizeApp.s16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    SpacingApp.spacingVertical(SizeApp.s16),
                    Row(
                      children: [
                        SpacingApp.spacingHorizontal(SizeApp.s20),
                        const Expanded(
                          child: Text(
                            'Võ Thị Phương Thảo - 19129050',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: FontSizeApp.s16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    SpacingApp.spacingVertical(SizeApp.s16),
                    Row(
                      children: [
                        SpacingApp.spacingHorizontal(SizeApp.s20),
                        const Expanded(
                          child: Text(
                            'Huỳnh Ngọc Trang Đài - 19129002',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: FontSizeApp.s16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 50,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: PaddingApp.p32),
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    ImageApp.logoApp,
                    color: Colors.white,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
