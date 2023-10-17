import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:new_app/provider/check_network.dart';
import 'package:new_app/view/splash_screen.dart';
import 'package:new_app/view_model.dart/view_model.dart';
import 'package:new_app/widget/internet_error_widget.dart';
import 'package:provider/provider.dart';

void main() {
  Connectivity connectivity = Connectivity();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NewsViewModel()),
        ChangeNotifierProvider(create: (context) => CheckConnection())
      ],
      child: StreamBuilder<ConnectivityResult>(
        stream: connectivity.onConnectivityChanged,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
              final data = snapshot.data!;
              switch (data) {
                case ConnectivityResult.none:
                  return const MyApp2();
                default:
                  return const MyApp();
              }
            default:
              return const MyApp();
          }
        },
      )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SplashScreen());
  }
}

class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: InternetErrorWidget());
  }
}
