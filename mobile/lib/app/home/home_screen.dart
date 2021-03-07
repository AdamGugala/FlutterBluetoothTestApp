import 'package:bluetooth_test_app/bloc/bluetooth_bloc.dart';
import 'package:bluetooth_test_app/bloc/bluetooth_event.dart';
import 'package:bluetooth_test_app/bloc/bluetooth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: BlocBuilder<BluetoothBloc, BluetoothState>(
        builder: (context, state) {
          return Center(
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                      child: ElevatedButton(
                    child: Text('Disconnect'),
                    onPressed: () {
                      context
                          .read<BluetoothBloc>()
                          .add(BluetoothCloseConnection());
                    },
                  )),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
