import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

/// [MapControllerHook]
///
/// this controller hook is to illustrate statefull widget for hooks
/// where the [MapController] will be initialized
class MapControllerHook extends Hook<MapController> {
  final UserTrackingOption? userTrackingOption;
  final GeoPoint? initPosition;
  final BoundingBox? areaLimit;
  final CustomTile? tile;
  const MapControllerHook({
    this.userTrackingOption,
    this.initPosition,
    this.areaLimit,
    this.tile,
  });

  @override
  HookState<MapController, Hook<MapController>> createState() =>
      _MapControllerHookState();
}

class _MapControllerHookState
    extends HookState<MapController, MapControllerHook> {
  late MapController _controller;

  @override
  void initHook() {
    super.initHook();
    if (hook.tile == null) {
      _controller = MapController(
        initMapWithUserPosition: hook.userTrackingOption,
        initPosition: hook.initPosition,
        areaLimit: hook.areaLimit,
      );
    } else if (hook.tile != null) {
      _controller = MapController.customLayer(
        initMapWithUserPosition: hook.userTrackingOption,
        initPosition: hook.initPosition,
        areaLimit: hook.areaLimit,
        customTile: hook.tile!,
      );
    }
  }

  @override
  MapController build(BuildContext context) {
    return _controller;
  }

  @override
  void dispose() {
    _controller.dispose();
  }
}

typedef MapIsReady = Function();

/// [MapIsReadyHook]
///
/// this hook is to replace MapIsReady for hook state
/// where you can put your logic after the map is ready to use
class MapIsReadyHook extends Hook<MapIsReady> {
  final MapIsReady mapIsReady;
  final MapController controller;
  const MapIsReadyHook({
    required this.mapIsReady,
    required this.controller,
  });

  @override
  HookState<MapIsReady, Hook<MapIsReady>> createState() =>
      _MapIsReadyHookState();
}

class _MapIsReadyHookState extends HookState<MapIsReady, MapIsReadyHook>
    with OSMMixinObserver {
  late MapController _controller;

  @override
  void initHook() {
    super.initHook();
    _controller = hook.controller;
    _controller.addObserver(this);
  }

  @override
  MapIsReady build(BuildContext context) {
    return hook.mapIsReady;
  }

  @override
  Future<void> mapIsReady(bool isReady) async {
    if (isReady) {
      hook.mapIsReady();
    }
  }
}

/// [MapListenerHook]
///
/// this controller hook is to illustrate statefull widget for hooks
/// where the [MapController] will be initialized
class MapListenerHook extends Hook<void> {
  final MapController controller;
  final Function(GeoPoint)? onSingleTap;
  final Function(GeoPoint)? onLongTap;
  final Function(Region)? onRegionChanged;
  final Function(RoadInfo)? onRoadTap;
  const MapListenerHook({
    required this.controller,
    this.onSingleTap,
    this.onLongTap,
    this.onRegionChanged,
    this.onRoadTap,
  });

  @override
  HookState<void, Hook<void>> createState() => _MapListenerHookState();
}

class _MapListenerHookState extends HookState<void, MapListenerHook>
    with OSMMixinObserver {
  @override
  void initHook() {
    super.initHook();
    hook.controller.addObserver(this);
  }

  @override
  void build(BuildContext context) {}

  @override
  void dispose() {
    hook.controller.removeObserver(this);
  }

  @override
  Future<void> mapIsReady(bool isReady) async {}

  @override
  void onSingleTap(GeoPoint position) async {
    super.onSingleTap(position);
    if (hook.onSingleTap != null) {
      await hook.onSingleTap!(position);
    }
  }

  @override
  void onLongTap(GeoPoint position) {
    super.onLongTap(position);
    if (hook.onLongTap != null) {
      hook.onLongTap!(position);
    }
  }

  @override
  void onRegionChanged(Region region) {
    super.onRegionChanged(region);
    if (hook.onRegionChanged != null) {
      hook.onRegionChanged!(region);
    }
  }

  @override
  void onRoadTap(RoadInfo road) {
    super.onRoadTap(road);
    if (hook.onRoadTap != null) {
      hook.onRoadTap!(road);
    }
  }
}
