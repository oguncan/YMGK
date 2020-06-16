import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_example/pages/detailPage.dart';
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
  static LatLng umraniye = LatLng(41.02442, 29.09973);
  static LatLng basaksehir = LatLng(41.09552, 28.78986);
  static LatLng esenyurt = LatLng(41.02028, 28.66955);
  static LatLng sultangazi = LatLng(41.10197, 28.87202);
  static LatLng kagithane = LatLng(41.09233, 28.97478);
  static LatLng silivri = LatLng(41.07318, 28.25554);

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
          child: Column(
            children: <Widget>[
              Text('Kandilli', style: TextStyle(fontWeight: FontWeight.bold)),
              Expanded(
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailPage(cityName: 'Kandilli')),
                    );
                  },
                  child: Image(
                    image: AssetImage('lib/assets/marker.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Marker(
        width: 60.0,
        height: 60.0,
        point: sultanbeyli,
        builder: (ctx) => Container(
          child: Column(
            children: <Widget>[
              Text(
                'Sultanbeyli',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.7),
              ),
              Expanded(
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailPage(cityName: 'Sultanbeyli')),
                    );
                  },
                  padding: EdgeInsets.all(0),
                  child: Image(
                    image: AssetImage('lib/assets/marker.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Marker(
        width: 60.0,
        height: 60.0,
        point: sile,
        builder: (ctx) => Container(
          key: Key('purple'),
          child: Column(
            children: <Widget>[
              Text(
                'Şile',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.7),
              ),
              Expanded(
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailPage(cityName: 'Şile')),
                    );
                  },
                  padding: EdgeInsets.all(0),
                  child: Image(
                    image: AssetImage('lib/assets/marker.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Marker(
        width: 60.0,
        height: 60.0,
        point: uskudar,
        builder: (ctx) => Container(
          key: Key('purple'),
          child: Column(
            children: <Widget>[
              Text(
                'Üsküdar',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.7),
              ),
              Expanded(
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailPage(cityName: 'Üsküdar')),
                    );
                  },
                  child: Image(
                    image: AssetImage('lib/assets/marker.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Marker(
        width: 60.0,
        height: 60.0,
        point: sirinevler,
        builder: (ctx) => Container(
          key: Key('purple'),
          child: Column(
            children: <Widget>[
              Text(
                'Şirinevler',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.7),
              ),
              Expanded(
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailPage(cityName: 'Şirinevler')),
                    );
                  },
                  padding: EdgeInsets.all(0),
                  child: Image(
                    image: AssetImage('lib/assets/marker.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Marker(
        width: 60.0,
        height: 60.0,
        point: mecidiyekoy,
        builder: (ctx) => Container(
          key: Key('purple'),
          child: Column(
            children: <Widget>[
              Text(
                'Mecidiyeköy',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.5),
              ),
              Expanded(
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailPage(cityName: 'Mecidiyeköy')),
                    );
                  },
                  padding: EdgeInsets.all(0),
                  child: Image(
                    image: AssetImage('lib/assets/marker.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Marker(
        width: 60.0,
        height: 60.0,
        point: umraniye,
        builder: (ctx) => Container(
          key: Key('purple'),
          child: Column(
            children: <Widget>[
              Text(
                'Ümraniye',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.7),
              ),
              Expanded(
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailPage(cityName: 'Ümraniye')),
                    );
                  },
                  padding: EdgeInsets.all(0),
                  child: Image(
                    image: AssetImage('lib/assets/marker.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Marker(
        width: 60.0,
        height: 60.0,
        point: basaksehir,
        builder: (ctx) => Container(
          key: Key('purple'),
          child: Column(
            children: <Widget>[
              Text(
                'Başakşehir',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.7),
              ),
              Expanded(
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailPage(cityName: 'Başakşehir')),
                    );
                  },
                  padding: EdgeInsets.all(0),
                  child: Image(
                    image: AssetImage('lib/assets/marker.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Marker(
        width: 60.0,
        height: 60.0,
        point: esenyurt,
        builder: (ctx) => Container(
          key: Key('purple'),
          child: Column(
            children: <Widget>[
              Text(
                'Esenyurt',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.7),
              ),
              Expanded(
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailPage(cityName: 'Esenyurt')),
                    );
                  },
                  child: Image(
                    image: AssetImage('lib/assets/marker.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Marker(
        width: 60.0,
        height: 60.0,
        point: sultangazi,
        builder: (ctx) => Container(
          key: Key('purple'),
          child: Column(
            children: <Widget>[
              Text(
                'Sultangazi',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.7),
              ),
              Expanded(
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailPage(cityName: 'Sultangazi')),
                    );
                  },
                  padding: EdgeInsets.all(0),
                  child: Image(
                    image: AssetImage('lib/assets/marker.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Marker(
        width: 60.0,
        height: 60.0,
        point: kagithane,
        builder: (ctx) => Container(
          key: Key('purple'),
          child: Column(
            children: <Widget>[
              Text(
                'Kağıthane',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.7),
              ),
              Expanded(
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailPage(cityName: 'Kağıthane')),
                    );
                  },
                  padding: EdgeInsets.all(0),
                  child: Image(
                    image: AssetImage('lib/assets/marker.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Marker(
        width: 60.0,
        height: 60.0,
        point: silivri,
        builder: (ctx) => Container(
          key: Key('purple'),
          child: Column(
            children: <Widget>[
              Text(
                'Silivri',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.7),
              ),
              Expanded(
                child: FlatButton(
                  padding: EdgeInsets.all(0.0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailPage(cityName: 'Silivri')),
                    );
                  },
                  child: Image(
                    image: AssetImage('lib/assets/marker.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ];

    return Scaffold(
      // backgroundColor: Colors.blue.shade200,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade200,
        elevation: 0,
        title: Text('Harita',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.black)),
      ),
      drawer: buildDrawer(context, AnimatedMapControllerPage.route),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('İstanbul Bölgesindeki İlçeler Listesi',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
              height: 60,
              width: double.infinity,
              child: Scrollbar(
                child: ListView(
                  shrinkWrap: false,
                  padding: EdgeInsets.all(8.0),
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.orange,
                      child: Text('Kandilli'),
                      onPressed: () {
                        _animatedMapMove(kandilli, 10.0);
                      },
                    ),
                    SizedBox(
                      child: Container(width: 10),
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.orange,
                      child: Text('Şile'),
                      onPressed: () {
                        _animatedMapMove(sile, 10.0);
                      },
                    ),
                    SizedBox(
                      child: Container(width: 10),
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.orange,
                      child: Text('Sultanbeyli'),
                      onPressed: () {
                        _animatedMapMove(sultanbeyli, 10.0);
                      },
                    ),
                    SizedBox(
                      child: Container(width: 10),
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.orange,
                      child: Text('Mecidiyeköy'),
                      onPressed: () {
                        _animatedMapMove(mecidiyekoy, 10.0);
                      },
                    ),
                    SizedBox(
                      child: Container(width: 10),
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.orange,
                      child: Text('Şirinevler'),
                      onPressed: () {
                        _animatedMapMove(sirinevler, 10.0);
                      },
                    ),
                    SizedBox(
                      child: Container(width: 10),
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.orange,
                      child: Text('Üsküdar'),
                      onPressed: () {
                        _animatedMapMove(uskudar, 10.0);
                      },
                    ),
                    SizedBox(
                      child: Container(width: 10),
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.orange,
                      child: Text('Ümraniye'),
                      onPressed: () {
                        _animatedMapMove(umraniye, 10.0);
                      },
                    ),
                    SizedBox(
                      child: Container(width: 10),
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.orange,
                      child: Text('Başakşehir'),
                      onPressed: () {
                        _animatedMapMove(basaksehir, 10.0);
                      },
                    ),
                    SizedBox(
                      child: Container(width: 10),
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.orange,
                      child: Text('Esenyurt'),
                      onPressed: () {
                        _animatedMapMove(esenyurt, 10.0);
                      },
                    ),
                    SizedBox(
                      child: Container(width: 10),
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.orange,
                      child: Text('Sultangazi'),
                      onPressed: () {
                        _animatedMapMove(sultangazi, 10.0);
                      },
                    ),
                    SizedBox(
                      child: Container(width: 10),
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.orange,
                      child: Text('Kağıthane'),
                      onPressed: () {
                        _animatedMapMove(kagithane, 10.0);
                      },
                    ),
                    SizedBox(
                      child: Container(width: 10),
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.orange,
                      child: Text('Silivri'),
                      onPressed: () {
                        _animatedMapMove(silivri, 10.0);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 1.0, bottom: 1.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    color: Colors.red,
                    child:
                        Text('Sıfırla', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      var bounds = LatLngBounds();
                      bounds.extend(sultanbeyli);
                      bounds.extend(sile);
                      bounds.extend(kandilli);
                      bounds.extend(uskudar);
                      bounds.extend(mecidiyekoy);
                      bounds.extend(sirinevler);
                      bounds.extend(umraniye);
                      bounds.extend(basaksehir);
                      bounds.extend(sultangazi);
                      bounds.extend(silivri);
                      bounds.extend(kagithane);
                      bounds.extend(esenyurt);
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
                    center: LatLng(41.02442, 29.09973),
                    zoom: 9.0,
                    maxZoom: 20.0,
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
