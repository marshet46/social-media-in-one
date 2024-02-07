import 'package:internet_connection_checker/internet_connection_checker.dart';
class CheckInternet {
  Future<int> checkInternetConnection() async {
    try {
      final result = await InternetConnectionChecker().hasConnection;
      if (result) {
        return 1;
      } else {
        return 0;
      }
    } catch (error) {
      return 0;
    }
  }
}