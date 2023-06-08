import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:osm_flutter_hooks/src/osm_hook.dart';

/// [useMapIsReady]
///
/// the function will call [MapIsReadyHook]
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

/// [useMapController]
///
/// the function will call [MapControllerHook] to initialize [MapController]
/// return [MapController] that will passe  to [OSMFlutter]
MapController useMapController({
  UserTrackingOption? userTrackingOption,
  GeoPoint? initPosition,
  BoundingBox? areaLimit = const BoundingBox.world(),
  CustomTile? tile,
}) {
  assert((userTrackingOption != null) ^ (initPosition != null));
  return use(
    MapControllerHook(
      userTrackingOption: userTrackingOption,
      initPosition: initPosition,
      areaLimit: areaLimit,
      tile: tile,
    ),
  );
}

/// [useMapListener]
///
/// this hook to provide map callbacks for get single tap or,region changed,etc..
void useMapListener({
  required MapController controller,
  Function(GeoPoint)? onSingleTap,
  Function(GeoPoint)? onLongTap,
  Function(Region)? onRegionChanged,
  Function(RoadInfo)? onRoadTap,
}) {
  return use(
    MapListenerHook(
      controller: controller,
      onSingleTap: onSingleTap,
      onLongTap: onLongTap,
      onRegionChanged: onRegionChanged,
      onRoadTap: onRoadTap,
    ),
  );
}
