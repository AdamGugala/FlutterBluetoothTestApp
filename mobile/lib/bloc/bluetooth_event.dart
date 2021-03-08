import 'package:flutter/cupertino.dart';
import 'package:flutter_blue/flutter_blue.dart';

abstract class BluetoothConnectionEvent {
  const BluetoothConnectionEvent();

  @override
  List<Object> get props => [];
}

class BluetoothConnect extends BluetoothConnectionEvent {
  final ScanResult device;

  BluetoothConnect({@required this.device});
}

class BluetoothStartSearching extends BluetoothConnectionEvent {}

class BluetoothCloseConnection extends BluetoothConnectionEvent {}
