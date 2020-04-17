import 'package:flutter/material.dart';
import '../pages/animated_map_controller.dart';

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
        ListTile(
          title: const Text('Hava Kalitesi İndeks Haritası'),
          selected: currentRoute == AnimatedMapControllerPage.route,
          onTap: () {
            Navigator.pushReplacementNamed(
                context, AnimatedMapControllerPage.route);
          },
        ),
      ],
    ),
  );
}
