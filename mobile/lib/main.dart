import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/home/home_screen.dart';
import 'bloc/bluetooth_bloc.dart';
import 'bloc/bluetooth_state.dart';
import 'bloc/bluetooth_event.dart';

import 'config/config.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BluetoothBloc(),
      child: AppView(),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Config.navigatorKey,
      title: "WebviewApp",
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return BlocListener<BluetoothBloc, BluetoothState>(
          listener: (listenerContext, state) {
            if (state is BluetoothDisconnected) {
              print('Bluetooth disconnected');
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Bluetooth disconnected"),
                duration: Duration(seconds: 10),
              ));
            }
          },
          child: child,
        );
      },
      routes: {
        '/': (context) => HomeScreen(),
      },
    );
  }
}
