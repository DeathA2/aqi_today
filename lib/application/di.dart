import 'package:get_it/get_it.dart';

GetIt instance = GetIt.instance;
void initModule() async {
  _initSingleTon();
}

void _initSingleTon() {
  // instance.registerLazySingleton<UserDriftRepo>(
  //     () => UserDriftRepoImpl(instance()));

  // //table

  // instance.registerLazySingleton<UserData>(() => UserData());
}
