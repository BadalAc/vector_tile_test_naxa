import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';

class CachedTileProvider extends TileProvider {
  const CachedTileProvider();
  @override
  ImageProvider getImage(Coords<num> coords, TileLayerOptions options) {
    return CachedNetworkImageProvider(getTileUrl(coords, options));
  }
}

VectorTileProvider cachingTileProvider(String urlTemplate) {
  return MemoryCacheVectorTileProvider(
      delegate: NetworkVectorTileProvider(
          urlTemplate: urlTemplate,
          // this is the maximum zoom of the provider, not the
          // maximum of the map. vector tiles are rendered
          // to larger sizes to support higher zoom levels
          // httpHeaders: {"Token": "189673bdfe377d113195df2e23c6cf730bcf90e9"},
          maximumZoom: 14),
      maxSizeBytes: 1024 * 1024 * 2);
}
