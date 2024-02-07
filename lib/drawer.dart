
import 'package:flutter/material.dart';

import 'package:social/home.dart';
import 'package:url_launcher/url_launcher.dart';


import 'main.dart';

class MyDrawer extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
       UserAccountsDrawerHeader(
  accountName: Container(
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('abyssinia software'), // Your user's name
        Text('abyssiniasoftware1@gmail.com'), // Your user's email
      ],
    ),
  ),
  decoration: const BoxDecoration(
    color: Colors.green, // Set the background color to green
  ),
  currentAccountPicture: const CircleAvatar(
    backgroundColor: Colors.green,
    child: Icon(Icons.person), // Sample user icon
  ), accountEmail: null,
),

          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>Home()
                ),
              );
            },
          ),
         
       
           ListTile(
            leading: const Icon(Icons.notification_add_rounded),
            title: const Text('Notifications'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationScreen(),
                ),
              );
            },
          ),
        
        
          const Divider(),
          ListTile(
            leading: const Icon(Icons.telegram),
            title: const Text('contact us on telegram'),
            onTap: () {
              launchTelegram();
            },
          ),
          // ListTile(
          //   leading: const Icon(Icons.share_sharp),
          //   title: const Text('መተግበሪያዉን ያጋሩ'),
          //   onTap: () {
          //     shareApp();
          //   },
          // ),
          // ListTile(
          //   leading: const Icon(Icons.telegram_rounded),
          //   title: const Text('መተግበሪያዉን በቴሌግራም ያጋሩ'),
          //   onTap: () {
          //     shareAppTelegram(
          //         'https://play.google.com/store/apps/details?id=com.kidist.maryam');
          //   },
          // ),
       
        ],
      ),
    );
  }

  void launchTelegram() async {
    final url = 'https://t.me/abyssiniasoftware';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
