import 'package:bloc/bloc.dart';

import 'bluetooth_event.dart';
import 'bluetooth_state.dart';

class BluetoothBloc extends Bloc<BluetoothEvent, BluetoothState> {
  BluetoothBloc() : super(BluetoothReadyToConnect());

  @override
  Stream<BluetoothState> mapEventToState(BluetoothEvent event) async* {
    if (event is BluetoothConnect) {
      yield BluetoothConnected();
    } else if (event is BluetoothCloseConnection) {
      yield BluetoothDisconnected();
    }
  }
}
