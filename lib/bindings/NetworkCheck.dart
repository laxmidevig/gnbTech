import 'package:connectivity/connectivity.dart';
import 'String.dart';

checkConnectionStatus() async {
  var connectionResult = await Connectivity().checkConnectivity();
  if (connectionResult == ConnectivityResult.mobile ||
      connectionResult == ConnectivityResult.wifi) {
    return '$connected';
  } else {
    return '$notConnected';
  }
}


