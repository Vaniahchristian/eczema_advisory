import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class WebSocketService {
  late IO.Socket socket;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  Function(dynamic)? onMessageReceived;
  Function(dynamic)? onNotificationReceived;
  Function(dynamic)? onStatusChange;

  Future<void> connect() async {
    final token = await _storage.read(key: 'auth_token');
    
    socket = IO.io('http://localhost:3001', // Update with your WebSocket URL
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .setExtraHeaders({'Authorization': 'Bearer $token'})
            .build());

    socket.onConnect((_) {
      print('WebSocket Connected');
    });

    socket.onDisconnect((_) {
      print('WebSocket Disconnected');
    });

    socket.on('message', (data) {
      if (onMessageReceived != null) {
        onMessageReceived!(data);
      }
    });

    socket.on('notification', (data) {
      if (onNotificationReceived != null) {
        onNotificationReceived!(data);
      }
    });

    socket.on('status_change', (data) {
      if (onStatusChange != null) {
        onStatusChange!(data);
      }
    });
  }

  void sendMessage(Map<String, dynamic> message) {
    socket.emit('message', message);
  }

  void joinRoom(String roomId) {
    socket.emit('join_room', {'roomId': roomId});
  }

  void leaveRoom(String roomId) {
    socket.emit('leave_room', {'roomId': roomId});
  }

  void updateStatus(String status) {
    socket.emit('status_update', {'status': status});
  }

  void disconnect() {
    socket.disconnect();
  }

  bool get isConnected => socket.connected;
}
