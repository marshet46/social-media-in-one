import 'dart:io';

import './checkinternet.dart';
import './responsive_image_with_text_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebviewTwo extends StatefulWidget {
  final String url;
  WebviewTwo({Key? key, required this.url}) : super(key: key);

  @override
  _WebviewTwoState createState() => _WebviewTwoState();
}

class _WebviewTwoState extends State<WebviewTwo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? _webViewController;
  late PullToRefreshController pullToRefreshController;
  final urlController = TextEditingController();
  double progress = 0;
  String url = '';
  bool _isConnected = true;
  int checkInt = 1;
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final oneSignalAppId = '32ef0435-91cb-4b7c-8627-49f5b5eb47bc';
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      javaScriptEnabled: true,
      useShouldOverrideUrlLoading: true,
      useOnDownloadStart: true,
      allowFileAccessFromFileURLs: true,
      mediaPlaybackRequiresUserGesture: false,
    ),
    android: AndroidInAppWebViewOptions(
      initialScale: 100,
      allowFileAccess: true,
      useShouldInterceptRequest: true,
      useHybridComposition: true,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
    ),
  );

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(color: Colors.blue),
      onRefresh: () async {
        if (Platform.isAndroid) {
          _webViewController?.reload();
        } else if (Platform.isIOS) {
          _webViewController?.loadUrl(
              urlRequest: URLRequest(url: await _webViewController?.getUrl()));
        }
      },
    );

    Future<int> a = CheckInternet().checkInternetConnection();
    a.then((value) {
      if (value == 0) {
        setState(() {
          checkInt = 0;
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Center(
          child: ResponsiveImageTextWidget(
            imageUrl: 'assets/nointernet.gif',
            text: "No internet connection!.",
          ),
        )));
      } else {
        setState(() {
          checkInt = 1;
        });
      }
    });
  }

  Future<void> _checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup(
          'https://system.abyssiniasoftware.com/hospital');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          _isConnected = true;
        });
      }
    } on SocketException catch (_) {
      setState(() {
        _isConnected = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height / 3;
    double screenWidth = size.width;

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  WillPopScope(
                    onWillPop: () async {
                      if (_webViewController != null &&
                          await _webViewController!.canGoBack()) {
                        _webViewController!.goBack();
                        return false;
                      } else {
                        return true;
                      }
                    },
                    child: checkInt == 1
                        ? InAppWebView(
                            key: webViewKey,
                            initialUrlRequest: URLRequest(
                              url: Uri.parse(widget.url),
                              headers: {},
                            ),
                            // on load error handling
                            onLoadError: (InAppWebViewController controller,
                                Uri? url, int code, String message) {
                              if (message
                                      .contains("net::ERR_NAME_NOT_RESOLVED") ||
                                  message.contains(
                                      "net::ERR_CONNECTION_TIMED_OUT") ||
                                  message.contains(
                                      "net::ERR_SSL_PROTOCOL_ERROR") ||
                                  message.contains(
                                      "net::ERR_INTERNET_DISCONNECTED")) {
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(16.0),
                                      decoration: const BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(16.0),
                                          topRight: Radius.circular(16.0),
                                        ),
                                      ),
                                      child: Center(
                                        child: ResponsiveImageTextWidget(
                                          imageUrl: 'assets/nointernet.gif',
                                          text:
                                              "You have no active internet connection. Please turn on data or connect to Wi-Fi!.",
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16.0),
                                    const SizedBox(height: 16.0),
                                    ElevatedButton(
                                      child: const Text(
                                        'Retry',
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => WebviewTwo(
                                                url:
                                                    'https://system.abyssiniasoftware.com/hospital'),
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 23.0),
                                  ],
                                );
                              } else {
                                // if error not handled above
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(16.0),
                                      decoration: const BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(16.0),
                                          topRight: Radius.circular(16.0),
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'You have no active internet connection. Please turn on data or connect to Wi-Fi',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16.0),
                                    const Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Text(
                                        'You have no active internet connection. Please turn on data or connect to Wi-Fi',
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                    ),
                                    const SizedBox(height: 16.0),
                                    ElevatedButton(
                                      child: const Text(
                                        'Retry',
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => WebviewTwo(
                                                url:
                                                    'https://system.abyssiniasoftware.com/hospital'),
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 16.0),
                                  ],
                                );
                                // end the error
                              }
                            }, // "https://unsplash.com/photos/odxB5oIG_iA"
                            initialOptions: options,
                            pullToRefreshController: pullToRefreshController,
                            onDownloadStart: (controller, url) async {
                              // downloading a file in a webview application
                            },
                            onWebViewCreated: (controller) {
                              _webViewController = controller;
                            },
                            onLoadStart: (controller, url) {
                              setState(() {
                                this.url = url.toString();
                                urlController.text = this.url;
                              });
                            },
                            androidOnPermissionRequest:
                                (controller, origin, resources) async {
                              return PermissionRequestResponse(
                                  resources: resources,
                                  action:
                                      PermissionRequestResponseAction.GRANT);
                            },
                            onLoadStop: (controller, url) async {
                              pullToRefreshController.endRefreshing();
                              setState(() {
                                this.url = url.toString();
                                urlController.text = this.url;
                              });
                            },

                            onProgressChanged: (controller, progress) {
                              if (progress == 100) {
                                pullToRefreshController.endRefreshing();
                              }
                              setState(() {
                                this.progress = progress / 100;
                                urlController.text = this.url;
                              });
                            },
                            onUpdateVisitedHistory:
                                (controller, url, androidIsReload) {
                              setState(() {
                                this.url = url.toString();
                                urlController.text = this.url;
                              });
                            },
                            onConsoleMessage: (controller, consoleMessage) {
                              print(consoleMessage);
                            },
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16.0),
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 5, 177, 62),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16.0),
                                    topRight: Radius.circular(16.0),
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    'You have no active internet connection. ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  'You have no active internet connection. ',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              ElevatedButton(
                                child: const Text(
                                  'Retry',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WebviewTwo(
                                          url:
                                              'https://system.abyssiniasoftware.com/hospital'),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 4.0),
                              const SizedBox(height: 16.0),
                              const SizedBox(height: 23.0),
                            ],
                          ),
                    // end error handling
                  ),
                  progress < 1.0
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 10.0, // Adjust the height as needed
                              child: LinearProgressIndicator(
                                value: progress,
                                backgroundColor: Colors.white,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  Color.fromARGB(255, 235, 5, 81),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.center,
                                child: Image.asset(
                                  'assets/loader.gif',
                                  height: screenHeight / 2,
                                  width: screenWidth,
                                ),
                              ),
                            ),
                          ],
                        )
                      : const Center(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyDrawer1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: const Text('view our website'),
            onTap: () {
              // Handle the click on item 1
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('contact on telegram'),
            onTap: () {
              // Handle the click on item 2
              Navigator.pop(context);
            },
          ),
           ListTile(
            title: const Text('call 0951050364'),
            onTap: () {
              // Handle the click on item 2
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
