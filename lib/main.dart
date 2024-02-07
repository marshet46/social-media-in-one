import './intro.dart';
import './webview.dart';
import 'package:flutter/material.dart';

import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
import 'splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  await OneSignal.shared.setAppId("140e43b6-ca07-4606-b70a-5a284a23f6af");

  OneSignal.shared.setNotificationOpenedHandler(
    (OSNotificationOpenedResult result) async {
      String notificationTitle = result.notification.title ?? "Default Title";
      String notificationMessage =
          result.notification.body ?? "Default Notification Text";
      // Store the notification locally
      await storeNotification(notificationTitle, notificationMessage);
      runApp(
        MaterialApp(
          navigatorObservers: [
            MyNavigatorObserver(), // Add the observer
          ],
          home: NotificationScreen(),
        ),
      );
    },
  );

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstLaunch = prefs.getBool('seen') ?? false;

  runApp(
    MyApp(isFirstLaunch: isFirstLaunch),
  );
}

// Function to store notification locally
Future<void> storeNotification(String title, String message) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> notifications = prefs.getStringList('notifications') ?? [];
  String notificationText = "$title: $message";
  notifications.insert(
      0, notificationText); // Insert at the beginning of the list
  prefs.setStringList('notifications', notifications);
}

class MyApp extends StatelessWidget {
  final bool isFirstLaunch;

  MyApp({required this.isFirstLaunch});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'myapp', home: Splashscreen());
  }
}

class MyNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // Check if the current route is NotificationScreen
    if (route is MaterialPageRoute && route.builder is NotificationScreen) {
      // Perform any additional actions when NotificationScreen is pushed
    }
  }
}

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: getNotifications(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<String> notifications = snapshot.data ?? [];
          return Scaffold(
            appBar: AppBar(
              title: Text('Notifications'),
            ),
            body: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                String notification = notifications[index];

                List<String> parts = notification.split(':');
                String title =
                    parts.length > 0 ? parts[0].trim() : "Default Title";
                String message =
                    parts.length > 1 ? parts[1].trim() : "Default Message";

                return Card(
                  elevation: 3.0,
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          message,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    contentPadding: EdgeInsets.all(16.0),
                  ),
                );
              },
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('Notifications'),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  // Function to get stored notifications
  Future<List<String>> getNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('notifications') ?? [];
  }
}
