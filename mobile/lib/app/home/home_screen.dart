import 'package:bluetooth_test_app/bloc/bluetooth_bloc.dart';
import 'package:bluetooth_test_app/bloc/bluetooth_event.dart';
import 'package:bluetooth_test_app/bloc/bluetooth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bluetooth_event.dart';
import '../../bloc/bluetooth_state.dart';

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
      body: BlocBuilder<BluetoothConnectionBloc, BluetoothConnectionState>(
        builder: (context, state) {
          if (state is BluetoothSearching) {
            return Center(child: CircularProgressIndicator());
          } else if (state is BluetoothSearched) {
            return Container(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ...state.searchResults.map((el) {
                        String text = el['result'].device.name != ""
                            ? el['result'].device.name
                            : el['result'].device.id.id;
                        return InkWell(
                          onTap: () {
                            context
                                .read<BluetoothConnectionBloc>()
                                .add(BluetoothConnect(device: el['result']));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 18.0),
                            child: Text(text),
                          ),
                        );
                      }).toList()
                    ],
                  ),
                ));
          } else
            return Center(
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: (state is BluetoothDisconnected)
                          ? ElevatedButton(
                              child: Text('Search for devices'),
                              onPressed: () {
                                context
                                    .read<BluetoothConnectionBloc>()
                                    .add(BluetoothStartSearching());
                              },
                            )
                          : ElevatedButton(
                              child: Text('Disconnect'),
                              onPressed: () {
                                context
                                    .read<BluetoothConnectionBloc>()
                                    .add(BluetoothCloseConnection());
                              },
                            ),
                    ),
                  ),
                ],
              ),
            );
        },
      ),
    );
  }
}
