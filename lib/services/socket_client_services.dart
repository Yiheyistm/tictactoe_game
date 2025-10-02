// ignore_for_file: library_prefixes

import 'dart:developer' as developer show log;

import 'package:get_ip_address/get_ip_address.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClientServices {
  final String _url =
      'http://192.168.50.121:3000'; // Replace with your server URL
  // final String _url = 'http://localhost:3000'; // Replace with your server URL
  // final String _url = 'http://<your-server-ip>:3000'; // Replace with your server URL
  static final SocketClientServices _instance =
      SocketClientServices._internal();
  IO.Socket? socket;

  SocketClientServices._internal() {
    socket = IO.io(_url, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket?.onConnect((_) {
      developer.log('Connected');
    });

    socket?.onConnectError((data) {
      developer.log('Connect Error: $data');
    });

    socket?.onError((data) {
      developer.log('Error: $data');
    });

    socket?.onDisconnect((_) {
      developer.log('Disconnected');
    });

    socket?.connect();
  }
  static SocketClientServices get instance {
    return _instance;
  }

  Future<String> _getIp() async {
    try {
      var ipAddress = IpAddress(type: RequestType.json);

      dynamic data = await ipAddress.getIpAddress();
      return data['ip'];
    } on IpAddressException catch (exception) {
      developer.log(exception.message);
    }
    return '';
  }

  void dispose() {
    socket?.dispose();
    socket?.disconnect();
  }
}
