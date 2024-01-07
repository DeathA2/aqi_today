import 'package:aqi_today/application/di.dart';
import 'package:aqi_today/domain/bloc/home_cubit.dart';
import 'package:aqi_today/presentation/screens/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:aqi_today/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDsXhXTM5Vcq-Zl13m_Mke65x_4aTkSfZE",
        authDomain: "aqproject-62f54.firebaseapp.com",
        databaseURL: "https://aqproject-62f54-default-rtdb.firebaseio.com",
        projectId: "aqproject-62f54",
        storageBucket: "aqproject-62f54.appspot.com",
        messagingSenderId: "480496315879",
        appId: "1:480496315879:web:5d5c65a7496f8f24472142",
        measurementId: "G-FRRXQY8ZF7"),
  );

  initModule();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: 'Mulish'),
        debugShowCheckedModeBanner: false,
        title: 'AQI Today',
        home: BlocProvider(
          create: (context) => HomeCubit(),
          child: const HomeScreen(),
        ));
  }
}
