import 'package:flutter/material.dart';
import 'package:uberclone/pages/DriverPanel.dart';
import 'package:uberclone/pages/Home.dart';
import 'package:uberclone/pages/PassengerPanel.dart';
import 'package:uberclone/pages/Signup.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => Home(),
        );
      case "/signup":
        return MaterialPageRoute(
          builder: (_) => Signup(),
        );
      case "/driver-panel":
        return MaterialPageRoute(
          builder: (_) => DriverPanel(),
        );
      case "/passenger-panel":
        return MaterialPageRoute(
          builder: (_) => PassengerPanel(),
        );
      default:
        return _routeError();
    }
  }

  static Route<dynamic> _routeError() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Tela não encontrada!"),
        ),
        body: Center(
          child: Text("Tela não encontrada!"),
        ),
      );
    });
  }
}
