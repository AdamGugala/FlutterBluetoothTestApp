abstract class BluetoothState {
  @override
  List<Object> get props => [];
}

class BluetoothReadyToConnect extends BluetoothState {}

class BluetoothConnected extends BluetoothState {}

class BluetoothDisconnected extends BluetoothState {}
