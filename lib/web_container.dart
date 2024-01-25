import '../screens/home.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewApp extends StatefulWidget {
  final String? url;
  final String? name;
  const WebViewApp({Key? key, @required this.url, @required this.name})
      : super(key: key);
  // const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;
  //late final String url;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse('${widget.url}'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.name}'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey[700],
        selectedItemColor: Colors.black,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const HomePage()));
                },
                child: const Icon(Icons.dashboard)),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: (() {
                // Navigator.push(
                //     context, MaterialPageRoute(builder: (_) => MySchool()));
              }),
              child: const Icon(Icons.settings),
            ),
            label: 'Settings',
          ),
        ],
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}

// class WebViewContainer extends StatefulWidget {
//   final url;
//   WebViewContainer(this.url);
//   @override
//   createState() => _WebViewContainerState(this.url);
// }
// class _WebViewContainerState extends State<WebViewContainer> {
//   var _url;
//   final _key = UniqueKey();
//   _WebViewContainerState(this._url);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//         centerTitle: true,
//         title: const Text(
//           'Shool Portal',
//           style: TextStyle(
//             fontSize: 16,
//             color: Color.fromARGB(219, 255, 255, 255),
//           ),
//         ),
//         backgroundColor: Colors.black,
//       ),
//         body: Column(
//           children: [
//             Expanded(
//                 child: WebView(
//                     key: _key,
//                     javascriptMode: JavascriptMode.unrestricted,
//                     initialUrl: _url))
//           ],
//         ));
//   }
// }
