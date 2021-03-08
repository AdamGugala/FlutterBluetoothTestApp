import 'package:flutter/cupertino.dart';
import 'package:flutter_blue/flutter_blue.dart';

abstract class BluetoothConnectionState {
  @override
  List<Object> get props => [];
}

class BluetoothConnected extends BluetoothConnectionState {}

class BluetoothDisconnected extends BluetoothConnectionState {}

class BluetoothSearching extends BluetoothConnectionState {}

class BluetoothSearched extends BluetoothConnectionState {
  final List<Map<String, dynamic>> searchResults;

  BluetoothSearched({@required this.searchResults});
}
