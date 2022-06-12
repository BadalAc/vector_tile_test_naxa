import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';
import 'package:vector_tile_renderer/vector_tile_renderer.dart';
import 'package:vector_tile_test_naxa/support_func.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with TickerProviderStateMixin {
  MapController? _mapController;
  LatLng? currentPos;
  bool mapSwitch = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size(0.0, 0.0),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            systemOverlayStyle: const SystemUiOverlayStyle(
              // Status bar color
              statusBarColor: Colors.transparent,

              // Status bar brightness (optional)
              statusBarIconBrightness:
                  Brightness.dark, // For Android (dark icons)
              statusBarBrightness: Brightness.light, // For iOS (dark icons)
            ),
          ),
        ),
        body: Stack(
          children: [
            FlutterMap(options: _prepareMapOptions(), layers: _prepareLayers()),
          ],
        ));
  }

  _prepareLayers() {
    return [
      TileLayerOptions(
        opacity: 0.4,
        urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
        // "https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png",
        subdomains: ['a', 'b', 'c'],
        tileProvider: const CachedTileProvider(),
      ),
      // TileLayerOptions(
      //   wmsOptions: WMSTileLayerOptions(
      //     baseUrl: 'https://{s}.s2maps-tiles.eu/wms/?',
      //     layers: ['s2cloudless-2018_3857'],
      //   ),
      //   subdomains: ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'],
      // ),

      VectorTileLayerOptions(
          theme: _mapTheme(context),
          tileProviders: TileProviders(
              {'openmaptiles': cachingTileProvider(_urlTemplate())})),
    ];
  }

  _prepareMapOptions() {
    return MapOptions(
      bounds: LatLngBounds(LatLng(27.722751417796996, 85.43670828954485),
          LatLng(27.685363789111744, 85.427781897647)),
      slideOnBoundaries: true,
      screenSize: MediaQuery.of(context).size,
      onPositionChanged: (MapPosition position, hasGesture) {
        if (kDebugMode) {
          print(position.zoom);
        }
      },
      interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
      onMapCreated: (c) {
        _mapController = c;
      },
      center: LatLng(27.7033, 85.4324),
      zoom: 12,
      minZoom: 3,
      maxZoom: 14,
      plugins: [
        VectorMapTilesPlugin(),
      ],
    );
  }

  _mapTheme(BuildContext context) {
    // maps are rendered using themes
    // to provide a dark theme do something like this:
    // if (MediaQuery.of(context).platformBrightness == Brightness.dark) return myDarkTheme();
    return ProvidedThemes.lightTheme();
  }

  String _urlTemplate() {
    // Stadia Maps source https://docs.stadiamaps.com/vector/
    return
        // with TOken
        // "https://changu-stag.naxa.com.np/api/v1/metric_addressing/layer_vectortile/{z}/{x}/{y}/?layer_id=1089";
// without

//hard coded
        // 'https://pccmis.karnali.gov.np/api/v1/layer_vectortile/11/1490/851/?layer=municipality&pro_code=6';

        // 'https://changu-stag.naxa.com.np/api/v1/maps/layer_vectortile/{z}/{x}/{y}/?layer_id=1089';
        // Mapbox source https://docs.mapbox.com/api/maps/vector-tiles/#example-request-retrieve-vector-tiles
        // return 'https://api.mapbox.com/v4/mapbox.mapbox-streets-v8/{z}/{x}/{y}.mvt?access_token=$mapBoxToken';

        "https://api.maptiler.com/tiles/ch-swisstopo-lbm/{z}/{x}/{y}.pbf?key=yVXqeQeRSeuQqtFoouno";
    //stadia
    // 'https://api.maptiler.com/tiles/countries/{z}/{x}/{y}.pbf?key=yVXqeQeRSeuQqtFoouno';
    // 'https://tiles.stadiamaps.com/data/openmaptiles/{z}/{x}/{y}.pbf?api_key=$mapBoxToken';
  }
}

const mapBoxToken = 'dac4b7ea-8217-4a5d-9f26-46a77eaa1c57';
// 'pk.eyJ1IjoibmlybWFsOTkiLCJhIjoiY2wxbTVidzJoMGhqbzNjczk3cjRnZjNkOCJ9.Ds-iUVKZ0cm3bh9vGi5JXw';
// 'sk.eyJ1IjoibmlybWFsOTkiLCJhIjoiY2wxbTVlZnZ5MGM4ajNkcGdlcjJ4a2xhNCJ9.HItKPO1HytBeiNu6M-Gnog';

