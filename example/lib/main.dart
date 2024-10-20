import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:osm_flutter_hooks/osm_flutter_hooks.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'OSM Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
        child: SimpleOSM(),
      ),
    );
  }
}

class SimpleOSM extends HookWidget {
  const SimpleOSM({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useMapController(
      userTrackingOption: const UserTrackingOption(
        enableTracking: true,
        unFollowUser: true,
      ),
    );
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
      osmOption: OSMOption(
        zoomOption: const ZoomOption(
          initZoom: 10,
        ),
        userLocationMarker: UserLocationMaker(
          personMarker: const MarkerIcon(
            icon: Icon(
              Icons.person,
              size: 48,
              color: Colors.red,
            ),
          ),
          directionArrowMarker: const MarkerIcon(
            icon: Icon(Icons.person),
          ),
        ),
      ),
    );
  }
}
