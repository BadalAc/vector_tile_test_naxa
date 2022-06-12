import 'package:get/get.dart';
import 'package:vector_tile_test_naxa/map.dart';

class Routes {
  Routes._();

  static const String mapPage = '/mapPage';

  static final routes = [
    GetPage(name: mapPage, page: () => const MapPage()),
  ];
}
