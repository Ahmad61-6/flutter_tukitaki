import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

enum NetworkStatus { connected, disconnected }

abstract interface class ConnectionChecker {
  Future<bool> get isConnected;

  Stream<InternetStatus> get onNetworkStatusChanged;
}

class ConnectionCheckerImpl implements ConnectionChecker {
  final InternetConnection internetConnection;

  ConnectionCheckerImpl(this.internetConnection);

  @override
  Future<bool> get isConnected async =>
      await internetConnection.hasInternetAccess;

  @override
  Stream<InternetStatus> get onNetworkStatusChanged =>
      internetConnection.onStatusChange;
}
