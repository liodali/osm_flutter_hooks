## OSM_FLUTTER_HOOKS
![pub](https://img.shields.io/badge/pub-v1.1.0-blue) 

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
    final controller = useMapController(initMapWithUserPosition: true);
    useMapIsReady(
      controller: controller,
      mapIsReady: () async {
        await controller.setZoom(zoomLevel: 15);
      },
    );
    return OSMFlutter(
      controller: controller,
      markerOption: MarkerOption(
        defaultMarker: MarkerIcon(
          icon: Icon(
            Icons.person_pin_circle,
            color: Colors.blue,
            size: 56,
          ),
        ),
      ),
      trackMyPosition: false,
    );
  }
}


```


