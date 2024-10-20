## OSM_FLUTTER_HOOKS
![pub](https://img.shields.io/badge/pub-v1.4.1-blue) 

## Features

*  predefined hooks to manage osm map

## Getting started

you should already have osm_flutter package if you want to use flutter_hooks to manage state of your widgets (like osm) use this package

## Usage

add this line in you pubspec

```yaml
 dependencies:
        osm_flutter_hooks: #latest
```

## example with osm map

```dart

class SimpleOSM extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useMapController(initMapWithUserPosition: const UserTrackingOption());
    useMapIsReady(
      controller: controller,
      mapIsReady: () async {
        await controller.setZoom(zoomLevel: 15);
      },
    );
    useMapListener(
        controller: controller,
        onSingleTap: (p) async {
          await controller.addMarker(p);
        });
    return OSMFlutter(
      controller: controller,
    );
  }
}


```


