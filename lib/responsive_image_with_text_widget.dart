import 'package:flutter/material.dart';


class ResponsiveImageTextWidget extends StatelessWidget {
  final String imageUrl;
  final String text;

  ResponsiveImageTextWidget({required this.imageUrl, required this.text});


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imageUrl,
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.width * 0.6,
            // You can use other Image properties for customization
          ),
          SizedBox(height: 20),
          Text(
            text,
            style: TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
