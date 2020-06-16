import 'package:flutter/material.dart';
import '../widgets/drawer.dart';
import '../models/aqiJson.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:intl/date_symbol_data_custom.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../stringExpressions.dart';
import './chartPage.dart';
import '../widgets/myHeader.dart';

class DetailPage extends StatefulWidget {
  final String cityName;
  static const String route = 'detail_page';
  DetailPage({Key key, this.cityName}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String listCityUrl;
  String listCityName;
  Future<AqiJson> city;
  bool pressButton = false;
  var matter = [];
  var matterValue = [];
  int valueOfString;
  final controller = ScrollController();
  double offset = 0;
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(onScroll);
    listCityUrl = map[widget.cityName];
    listCityName = widget.cityName;

    city = getAQI(listCityUrl, listCityName);

    // values = getTicket();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  Future<AqiJson> getAQI(String url, String name) async {
    debugPrint(url);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      // debugPrint(response.body);
      return AqiJson.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      body: SingleChildScrollView(
        child: FutureBuilder<AqiJson>(
          future: city,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              matterValues(snapshot);
              return Column(
                children: <Widget>[
                  MyHeader(
                    image: "lib/assets/coronadr.svg",
                    textTop: "Zararlı maddelerin grafikleri..",
                    textBottom: "için menü tuşuna basın..",
                    offset: offset,
                  ),
                  showDate(snapshot),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: detailAQI(snapshot)),
                    ),
                  ),
                  showMatterAndValues(snapshot),
                  showSuggestions(snapshot),
                  SizedBox(
                    height: 10,
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text("Hata meydana geldi");
            }

            // By default, show a loading spinner.
            return Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(50),
              child: Center(child: CircularProgressIndicator()));
          },
        ),
      ),

      //drawer: buildDrawer(context, DetailPage.route),
    );
  }

  Widget showDate(snapshot) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(8, 8),
            blurRadius: 16,
            color: Colors.black,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Icon(Icons.date_range),
          Column(
            children: <Widget>[
              Text(
                snapshot.data.data.city.name.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                snapshot.data.data.time.s.toString().split('.')[0],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget showSuggestions(snapshot) {
    if (snapshot.data.data.aqi >= 0 && snapshot.data.data.aqi <= 50) {
      return Container(
        height: 220,
        child: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) {
              return ListTile(
                leading: iconList[index],
                title: Text(stringSuggestions[0][index]),
              );
            }),
      );
    } else if (snapshot.data.data.aqi >= 51 && snapshot.data.data.aqi <= 100) {
      {
        return Container(
          height: 220,
          child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: iconList[index],
                  title: Text(stringSuggestions[0][index]),
                );
              }),
        );
      }
    } else if (snapshot.data.data.aqi >= 101 && snapshot.data.data.aqi <= 150) {
      return Container(
        height: 220,
        child: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) {
              return ListTile(
                leading: iconList[index],
                title: Text(stringSuggestions[0][index]),
              );
            }),
      );
    } else if (snapshot.data.data.aqi >= 151 && snapshot.data.data.aqi <= 200) {
      return Container(
        height: 220,
        child: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) {
              return ListTile(
                leading: iconList[index],
                title: Text(stringSuggestions[0][index]),
              );
            }),
      );
    } else if (snapshot.data.data.aqi >= 201 && snapshot.data.data.aqi <= 300) {
      return Container(
        height: 220,
        child: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) {
              return ListTile(
                leading: iconList[index],
                title: Text(stringSuggestions[0][index]),
              );
            }),
      );
    } else {
      return Container(
        height: 220,
        child: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) {
              return ListTile(
                leading: iconList[index],
                title: Text(stringSuggestions[0][index]),
              );
            }),
      );
    }
  }

  Widget showMatterAndValues(snapshot) {
    return Container(
      height: 60,
      margin: EdgeInsets.only(right: 8.0),
      child: Scrollbar(
        child: ListView.builder(
            padding: EdgeInsets.all(10),
            scrollDirection: Axis.horizontal,
            itemCount: matter.length,
            itemBuilder: (context, index) {
              return Row(
                children: <Widget>[
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 50),
                    child: FlatButton(
                        color: Color(0xFF11249F),
                        onPressed: () {
                          setState(() {
                            pressButton = !pressButton;
                          });
                        },
                        child: pressButton
                            ? Text(
                                matterValue[index].toString().toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            : Text(
                                matter[index].toString().toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                ],
              );
            }),
      ),
    );
  }

  void matterValues(snapshot) {
    matter = [];
    matterValue = [];
    for (final name in snapshot.data.data.iaqi.keys) {
      // print(name);
      final value = snapshot.data.data.iaqi[name].v;
      if (name.toString() == 'co' ||
          name.toString() == 'no2' ||
          name.toString() == 'o3' ||
          name.toString() == 'pm10' ||
          name.toString() == 'pm25' ||
          name.toString() == 'so2') {
        // print('MERHABA');
        matter.add(name);
        matterValue.add(value);
      }
      // print('$name,$value'); // prints entries like "AED,3.672940"
    }
  }

  List<Widget> detailAQI(var snapshot) {
    if (snapshot.data.data.aqi >= 0 && snapshot.data.data.aqi <= 50)
      return [
        Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            SvgPicture.asset('lib/assets/good.svg'),
            Positioned(
              left: 100,
              top: 40,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: Text(snapshot.data.data.aqi.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 24)),
              ),
            ),
            Positioned(
              top: 50,
              right: 130,
              child: Text(
                'İyi' + ' | ' + snapshot.data.data.dominentpol.toUpperCase(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        )
      ];
    else if (snapshot.data.data.aqi >= 51 && snapshot.data.data.aqi <= 100) {
      return [
        Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            SvgPicture.asset('lib/assets/medium.svg'),
            Positioned(
              left: 100,
              top: 40,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orange.shade200,
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: Text(snapshot.data.data.aqi.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 24)),
              ),
            ),
            Positioned(
              top: 50,
              right: 130,
              child: Text(
                'Orta' + ' | ' + snapshot.data.data.dominentpol.toUpperCase(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        )
      ];
    } else if (snapshot.data.data.aqi >= 101 && snapshot.data.data.aqi <= 150)
      return [
        Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            SvgPicture.asset('lib/assets/sensitive.svg'),
            Positioned(
              left: 100,
              top: 40,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orange.shade500,
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: Text(snapshot.data.data.aqi.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 24)),
              ),
            ),
            Positioned(
              top: 50,
              right: 130,
              child: Text(
                'Hassas' + ' | ' + snapshot.data.data.dominentpol.toUpperCase(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        )
      ];
    else if (snapshot.data.data.aqi >= 151 && snapshot.data.data.aqi <= 200)
      return [
        Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            SvgPicture.asset('lib/assets/sensitive.svg'),
            Positioned(
              left: 100,
              top: 40,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: Text(snapshot.data.data.aqi.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 24)),
              ),
            ),
            Positioned(
              top: 50,
              right: 130,
              child: Text(
                'Sağlıksız' +
                    ' | ' +
                    snapshot.data.data.dominentpol.toUpperCase(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        )
      ];
    else if (snapshot.data.data.aqi >= 201 && snapshot.data.data.aqi <= 300)
      return [
        Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            SvgPicture.asset('lib/assets/bad.svg'),
            Positioned(
              left: 100,
              top: 40,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.pink.shade400,
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: Text(snapshot.data.data.aqi.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 24)),
              ),
            ),
            Positioned(
              top: 50,
              right: 130,
              child: Text(
                'Kötü' + ' | ' + snapshot.data.data.dominentpol.toUpperCase(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        )
      ];
    else
      return [
        Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            SvgPicture.asset('lib/assets/dangerous.svg'),
            Positioned(
              left: 100,
              top: 40,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.brown.shade400,
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: Text(snapshot.data.data.aqi.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 24)),
              ),
            ),
            Positioned(
              top: 50,
              right: 130,
              child: Text(
                'Tehlikeli' +
                    ' | ' +
                    snapshot.data.data.dominentpol.toUpperCase(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        )
      ];
  }
}

/*
Container(
                  height: 60,
                  child: Scrollbar(
                    child: ListView(
                      padding: EdgeInsets.all(8),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: false,
                      children: <Widget>[
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 50),
                          child: FlatButton(
                              color: Colors.blueAccent,
                              onPressed: () {
                                setState(() {
                                  pressButton = !pressButton;
                                });
                              },
                              child: pressButton
                                  ? Text(
                                      matterValue[0].toString().toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(
                                      matter[0].toString().toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(width: 8),
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 50),
                          child: FlatButton(
                              color: Colors.blueAccent,
                              onPressed: () {
                                setState(() {
                                  pressButton = !pressButton;
                                });
                              },
                              child: pressButton
                                  ? Text(
                                      matterValue[1].toString().toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(
                                      matter[1].toString().toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 50),
                          child: FlatButton(
                              color: Colors.blueAccent,
                              onPressed: () {
                                setState(() {
                                  pressButton = !pressButton;
                                });
                              },
                              child: pressButton
                                  ? Text(
                                      matterValue[2].toString().toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(
                                      matter[2].toString().toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 50),
                          child: FlatButton(
                              color: Colors.blueAccent,
                              onPressed: () {
                                setState(() {
                                  pressButton = !pressButton;
                                });
                              },
                              child: pressButton
                                  ? Text(
                                      matterValue[3].toString().toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(
                                      matter[3].toString().toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 50),
                          child: FlatButton(
                              color: Colors.blueAccent,
                              onPressed: () {
                                setState(() {
                                  pressButton = !pressButton;
                                });
                              },
                              child: pressButton
                                  ? Text(
                                      matterValue[4].toString().toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(
                                      matter[4].toString().toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 50),
                          child: FlatButton(
                              color: Colors.blueAccent,
                              onPressed: () {
                                setState(() {
                                  pressButton = !pressButton;
                                });
                              },
                              child: pressButton
                                  ? Text(
                                      matterValue[5].toString().toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(
                                      matter[5].toString().toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 50),
                          child: FlatButton(
                              color: Colors.blueAccent,
                              onPressed: () {
                                setState(() {
                                  pressButton = !pressButton;
                                });
                              },
                              child: pressButton
                                  ? Text(
                                      matterValue[6].toString().toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(
                                      matter[6].toString().toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 50),
                          child: FlatButton(
                              color: Colors.blueAccent,
                              onPressed: () {
                                setState(() {
                                  pressButton = !pressButton;
                                });
                              },
                              child: pressButton
                                  ? Text(
                                      matterValue[7].toString().toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(
                                      matter[7].toString().toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                */
