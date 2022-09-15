import 'package:carpooling_beta/app/Auth/presentation/bindings/login_binding.dart';
import 'package:carpooling_beta/app/Auth/presentation/screens/login_view.dart';
import 'package:carpooling_beta/app/Auth/presentation/bindings/register_binding.dart';
import 'package:carpooling_beta/app/Home/presentation/bindings/home_binding.dart';
import 'package:carpooling_beta/app/Home/presentation/bindings/map_binding.dart';
import 'package:carpooling_beta/app/Auth/presentation/screens/register_view.dart';
import 'package:carpooling_beta/app/Home/presentation/screens/home_view.dart';
import 'package:carpooling_beta/app/Home/presentation/screens/map_view.dart';
import 'package:carpooling_beta/app/Profile/presentation/bindings/profile_binding.dart';
import 'package:carpooling_beta/app/Profile/presentation/bindings/car_binding.dart';
import 'package:carpooling_beta/app/Profile/presentation/screens/profile_view.dart';
import 'package:carpooling_beta/app/Profile/presentation/screens/car_view.dart';
import 'package:get/get.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const String INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.CAR,
      page: () => const CarView(),
      binding: CarBinding(),
    ),
    GetPage(
      name: _Paths.MAP,
      page: () => const MapView(),
      binding: MapBinding(),
    ),
  ];
}
