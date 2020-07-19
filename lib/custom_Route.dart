import 'package:flutter/material.dart';
import 'package:flutterapp/main.dart';
import 'package:flutterapp/payment.dart';
import 'package:flutterapp/product.dart';


class CustomRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => ProductPage());
      case '/details':
        return MaterialPageRoute(builder: (_) => MyHomePage(content: args,));
      case '/payment':
        return MaterialPageRoute(builder: (_) => Payment(price: args,));
      default:
        errorRoute();
    }
    return errorRoute();
  }

  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        body: Text(" This Page don't Exist pls go back ",style: TextStyle(
              fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold),
        ),
      );
    });
  }
}