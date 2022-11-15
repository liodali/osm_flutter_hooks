import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:osm_flutter_hooks/src/osm_hook.dart';

void useMapIsReady({
  required MapController controller,
  required Function() mapIsReady,
}) {
  return use(
    MapIsReadyHook(
      mapIsReady: mapIsReady,
      controller: controller,
    ),
  );
}

MapController useMapController({
  bool initMapWithUserPosition = true,
  GeoPoint? initPosition,
  BoundingBox? areaLimit = const BoundingBox.world(),
}) {
  return use(
    MapControllerHook(
      initMapWithUserPosition: initMapWithUserPosition,
      initPosition: initPosition,
      areaLimit: areaLimit,
    ),
  );
}
