abstract class BluetoothEvent {
  const BluetoothEvent();

  @override
  List<Object> get props => [];
}

class BluetoothConnect extends BluetoothEvent {}

class BluetoothCloseConnection extends BluetoothEvent {}
