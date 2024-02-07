import 'package:flutter/material.dart';
import 'package:social/webview.dart';
import 'drawer.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> socialMediaPlatforms = [
{
  'name': 'Facebook',
  'description': 'Connect with friends and the world around you on Facebook.',
  'link': 'https://www.facebook.com/'
},
{
  'name': 'TikTok',
  'description': 'Get funny videos on TikTok.',
  'link': 'https://www.tiktok.com/'
},
{
  'name': 'Twitter',
  'description': 'See what\'s happening in the world right now. Join Twitter today.',
  'link': 'https://twitter.com/'
},
{
  'name': 'Instagram',
  'description': 'Capture and share the world\'s moments on Instagram.',
  'link': 'https://www.instagram.com/'
},
{
  'name': 'LinkedIn',
  'description': 'Build and engage with your professional network on LinkedIn.',
  'link': 'https://www.linkedin.com/'
},
{
  'name': 'Pinterest',
  'description': 'Discover recipes, home ideas, style inspiration, and other ideas to try on Pinterest.',
  'link': 'https://www.pinterest.com/'
},
{
  'name': 'Snapchat',
  'description': 'Share your moments with friends and family on Snapchat.',
  'link': 'https://www.snapchat.com/'
},
{
  'name': 'Tumblr',
  'description': 'Express yourself, discover yourself on Tumblr.',
  'link': 'https://www.tumblr.com/'
},
{
  'name': 'Reddit',
  'description': 'Discover the best of the internet on Reddit.',
  'link': 'https://www.reddit.com/'
},
{
  'name': 'WhatsApp',
  'description': 'Simple. Reliable. Secure messaging on WhatsApp.',
  'link': 'https://www.whatsapp.com/'
},
{
  'name': 'YouTube',
  'description': 'Enjoy the videos and music you love, upload original content, and share it all with friends, family, and the world on YouTube.',
  'link': 'https://www.youtube.com/'
},
{
  'name': 'Flickr',
  'description': 'Share your photos with the world on Flickr.',
  'link': 'https://www.flickr.com/'
},
{
  'name': 'Vimeo',
  'description': 'Join the world’s leading professional video platform and grow your business with easy-to-use, high-quality video creation, hosting, and marketing tools.',
  'link': 'https://vimeo.com/'
},
{
  'name': 'Pinterest',
  'description': 'Discover and save creative ideas on Pinterest.',
  'link': 'https://www.pinterest.com/'
},
{
  'name': 'Medium',
  'description': 'Where good ideas find you. Read and write on Medium.',
  'link': 'https://medium.com/'
},
{
  'name': 'Mix',
  'description': 'Discover, collect, and share what you love on Mix.',
  'link': 'https://mix.com/'
},
{
  'name': 'We Heart It',
  'description': 'Get lost in what you love on We Heart It.',
  'link': 'https://weheartit.com/'
},
{
  'name': 'DeviantArt',
  'description': 'The largest online art gallery and community on DeviantArt.',
  'link': 'https://www.deviantart.com/'
},
{
  'name': 'Goodreads',
  'description': 'Find and read more books you’ll love on Goodreads.',
  'link': 'https://www.goodreads.com/'
},
// Add more as needed

      // Add more social media platforms here
    ];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Social Media Platforms'),
        ),
        drawer: MyDrawer(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: socialMediaPlatforms.map((platform) {
                return SocialMediaCard(platformData: platform);
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class SocialMediaCard extends StatelessWidget {
  final Map<String, dynamic> platformData;

  SocialMediaCard({required this.platformData});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      elevation: 2.0,
      color: Color.fromARGB(255, 106, 21, 217),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        onTap: () => onPlatformCardPressed(context, platformData),
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                platformData['name'],
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                platformData['description'],
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onPlatformCardPressed(BuildContext context, Map<String, dynamic> platformData) {
  
   // Handle platform card press, e.g., open the link in a WebView
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WebviewTwo(url: platformData['link'])),
    );
  }
}
