import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> checkInternetConnection() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    return false; // No internet connection
  } else {
    return true; // Internet connection available
  }
}
