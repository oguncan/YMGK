import 'package:flutter/material.dart';
import '../pages/animated_map_controller.dart';
import '../pages/detailPage.dart';

Drawer buildDrawer(BuildContext context, String currentRoute) {
  return Drawer(
    
    child: ListView(
      children: <Widget>[
        const DrawerHeader(
          decoration: BoxDecoration(color: Colors.green),
          child: Center(
            child: Text('Sağlığın İçin'),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(width: 1),
              borderRadius: BorderRadius.circular(8)),
          child: ListTile(
            title: const Text(
              'Hava Kalitesi İndeks Haritası',
              textAlign: TextAlign.center,
            ),
            selected: currentRoute == AnimatedMapControllerPage.route,
            onTap: () {
              Navigator.pushNamed(context, AnimatedMapControllerPage.route);
            },
          ),
        ),
      ],
    ),
  );
}
