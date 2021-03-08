import 'package:bloc/bloc.dart';
import 'package:flutter_blue/flutter_blue.dart';

import 'bluetooth_event.dart';
import 'bluetooth_state.dart';

class BluetoothConnectionBloc
    extends Bloc<BluetoothConnectionEvent, BluetoothConnectionState> {
  BluetoothConnectionBloc() : super(BluetoothDisconnected());

  FlutterBlue flutterBlue;
  List<Map<String, dynamic>> searchResults = []; //TO CHANGE

  @override
  Stream<BluetoothConnectionState> mapEventToState(
      BluetoothConnectionEvent event) async* {
    if (event is BluetoothConnect) {
      yield* _mapBluetoothConnectToState(event);
    } else if (event is BluetoothStartSearching) {
      yield* _mapBluetoothStartSearchingToState(event);
    } else if (event is BluetoothCloseConnection) {
      searchResults = [];
      flutterBlue = null;
      yield BluetoothDisconnected();
    }
  }

  Stream<BluetoothConnectionState> _mapBluetoothStartSearchingToState(
      BluetoothStartSearching event) async* {
    yield BluetoothSearching();

    flutterBlue = FlutterBlue.instance;

    Future<dynamic> scanning = flutterBlue.startScan(
      scanMode: ScanMode.balanced,
      timeout: Duration(seconds: 20),
    );

    var subscription = flutterBlue.scanResults.listen((results) {
      // searchResults.addAll(results.where((result) => result.advertisementData.connectable));
      for (ScanResult r in results) {
        if (!r.advertisementData.connectable) continue;

        bool wasDetected =
            searchResults.indexWhere((el) => el['id'] == r.device.id.id) != -1;
        if (wasDetected) continue;

        searchResults.add({'id': r.device.id.id, 'result': r});

        print('${r.device.name} found! rssi: ${r.rssi}');
      }
      // searchResults
      //  = results;
    });
    await scanning;
    if (searchResults.isNotEmpty) {
      yield BluetoothSearched(searchResults: searchResults);
    } else {
      yield BluetoothDisconnected();
    }
  }

  Stream<BluetoothConnectionState> _mapBluetoothConnectToState(
      BluetoothConnect event) async* {
    yield BluetoothConnected();
  }
}
