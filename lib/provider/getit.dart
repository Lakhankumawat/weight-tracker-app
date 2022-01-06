import 'package:weight_tracker/service/navigation_service.dart';
import 'package:get_it/get_it.dart';
import 'package:weight_tracker/view/auth_screen_view_model.dart';
import 'package:weight_tracker/view/details_screen_view_model.dart';
import 'package:weight_tracker/view/home_screen_view_model.dart';
import 'package:weight_tracker/view/user_profile_view_model.dart';

GetIt getIt = GetIt.instance;
void setupLocator() {
  getIt.registerLazySingleton(() => NavigationService());
  getIt.registerFactory(() => DetailsScreenViewModel());
  getIt.registerFactory(() => HomeScreenViewModel());
  getIt.registerFactory(() => UserProfileViewModel());
  getIt.registerFactory(() => AuthScreenViewModel());
}
