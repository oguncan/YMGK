import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import '../widgets/drawer.dart';

class AnimatedMapControllerPage extends StatefulWidget {
  static const String route = 'map_controller_animated';

  @override
  AnimatedMapControllerPageState createState() {
    return AnimatedMapControllerPageState();
  }
}

class AnimatedMapControllerPageState extends State<AnimatedMapControllerPage>
    with TickerProviderStateMixin {
  // Note the addition of the TickerProviderStateMixin here. If you are getting an error like
  // 'The class 'TickerProviderStateMixin' can't be used as a mixin because it extends a class other than Object.'
  // in your IDE, you can probably fix it by adding an analysis_options.yaml file to your project
  // with the following content:
  //  analyzer:
  //    language:
  //      enableSuperMixins: true
  // See https://github.com/flutter/flutter/issues/14317#issuecomment-361085869
  // This project didn't require that change, so YMMV.

  static LatLng kandilli = LatLng(41.0746, 29.05899);
  static LatLng sile = LatLng(41.17046, 29.56336);
  static LatLng sultanbeyli = LatLng(40.98447, 29.26881);
  static LatLng uskudar = LatLng(41.02705, 29.02489);
  static LatLng sirinevler = LatLng(41.00245, 28.83866);
  static LatLng mecidiyekoy = LatLng(41.06596, 28.99446);

  MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final _latTween = Tween<double>(
        begin: mapController.center.latitude, end: destLocation.latitude);
    final _lngTween = Tween<double>(
        begin: mapController.center.longitude, end: destLocation.longitude);
    final _zoomTween = Tween<double>(begin: mapController.zoom, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider.
    var controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapController.move(
          LatLng(_latTween.evaluate(animation), _lngTween.evaluate(animation)),
          _zoomTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    var markers = <Marker>[
      Marker(
        width: 60.0,
        height: 60.0,
        point: kandilli,
        builder: (ctx) => Container(
          key: Key('blue'),
          child: Image(
            image: AssetImage('lib/assets/marker.png'),
          ),
        ),
      ),
      Marker(
        width: 60.0,
        height: 60.0,
        point: sultanbeyli,
        builder: (ctx) => Container(
          child: Image(
            image: AssetImage('lib/assets/marker.png'),
          ),
        ),
      ),
      Marker(
        width: 60.0,
        height: 60.0,
        point: sile,
        builder: (ctx) => Container(
          key: Key('purple'),
          child: Image(
            image: AssetImage('lib/assets/marker.png'),
          ),
        ),
      ),
      Marker(
        width: 60.0,
        height: 60.0,
        point: uskudar,
        builder: (ctx) => Container(
          key: Key('purple'),
          child: Image(
            image: AssetImage('lib/assets/marker.png'),
          ),
        ),
      ),
      Marker(
        width: 60.0,
        height: 60.0,
        point: mecidiyekoy,
        builder: (ctx) => Container(
          key: Key('purple'),
          child: Image(
            image: AssetImage('lib/assets/marker.png'),
          ),
        ),
      ),
      Marker(
        width: 60.0,
        height: 60.0,
        point: sirinevler,
        builder: (ctx) => Container(
          key: Key('purple'),
          child: Image(
            image: AssetImage('lib/assets/marker.png'),
          ),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('İstanbul Bölgesi'),
      ),
      drawer: buildDrawer(context, AnimatedMapControllerPage.route),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Wrap(
              spacing: 8.0, // gap between adjacent chips
              runSpacing: 4.0, // gap between lines
              direction: Axis.horizontal,
              children: <Widget>[
                MaterialButton(
                  child: Text('Kandilli'),
                  onPressed: () {
                    _animatedMapMove(kandilli, 10.0);
                  },
                ),
                MaterialButton(
                  child: Text('Şile'),
                  onPressed: () {
                    _animatedMapMove(sile, 10.0);
                  },
                ),
                MaterialButton(
                  child: Text('Sultanbeyli'),
                  onPressed: () {
                    _animatedMapMove(sultanbeyli, 10.0);
                  },
                ),
                MaterialButton(
                  child: Text('Mecidiyeköy'),
                  onPressed: () {
                    _animatedMapMove(mecidiyekoy, 10.0);
                  },
                ),
                MaterialButton(
                  child: Text('Şirinevler'),
                  onPressed: () {
                    _animatedMapMove(sirinevler, 10.0);
                  },
                ),
                MaterialButton(
                  child: Text('Üsküdar'),
                  onPressed: () {
                    _animatedMapMove(uskudar, 10.0);
                  },
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  MaterialButton(
                    child: Text('Sıfırla'),
                    onPressed: () {
                      var bounds = LatLngBounds();
                      bounds.extend(sultanbeyli);
                      bounds.extend(sile);
                      bounds.extend(kandilli);
                      bounds.extend(uskudar);
                      bounds.extend(mecidiyekoy);
                      bounds.extend(sirinevler);
                      mapController.fitBounds(
                        bounds,
                        options: FitBoundsOptions(
                          padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Flexible(
              child: FlutterMap(
                mapController: mapController,
                options: MapOptions(
                    center: LatLng(51.5, -0.09),
                    zoom: 5.0,
                    maxZoom: 10.0,
                    minZoom: 3.0),
                layers: [
                  TileLayerOptions(
                      urlTemplate:
                          'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: ['a', 'b', 'c']),
                  MarkerLayerOptions(markers: markers)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
