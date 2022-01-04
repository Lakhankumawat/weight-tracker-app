import 'package:weight_tracker/service/navigation_service.dart';
import 'package:get_it/get_it.dart';
import 'package:weight_tracker/view/home_screen_viewmodel.dart';

GetIt getIt = GetIt.instance;
void setupLocator() {
  getIt.registerLazySingleton(() => NavigationService());
  getIt.registerFactory(() => HomeScreenViewModel());
}
