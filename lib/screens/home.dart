import 'dart:convert';
import 'package:edcrib/screens/help_desk.dart';
import 'package:edcrib/screens/settings.dart';
import 'package:edcrib/screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:provider/provider.dart';
import '../network/api.dart';
//import 'messenger.dart';
import '../web_container.dart';
import 'my_school.dart';

//import '../web_container.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user') as String);
    if (user != null) {
      setState(() {
        name = user['name'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // centerTitle: true,

          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          actions: [
            Row(
              children: [
                Text(
                  '${name}',
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 2.0),
                IconButton(
                  iconSize: 16.0,
                  icon: const Icon(Icons.power_settings_new),
                  onPressed: () {
                    logout();
                  },
                ),
              ],
            )
          ],
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
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Settings()));
                }),
                child: const Icon(Icons.settings),
              ),
              label: 'Settings',
            )
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 3,
            ),
            Container(
                height: 110,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          Colors.white.withOpacity(0.7), BlendMode.dstATop),
                      image: const AssetImage("images/vector_art6.jpg"),
                      fit: BoxFit.cover),
                ),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      color: Colors.white,
                      height: 80,
                      width: 80,
                      child: Image.asset(
                        'images/edcrib_logo.png',
                        height: 80,
                        width: 80,
                      ),
                    ),
                  ),
                )
                //Center(child: Image.asset('../images/edcrib_png1.png')),
                ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: CustomScrollView(
                primary: false,
                slivers: <Widget>[
                  SliverPadding(
                    padding: const EdgeInsets.all(15),
                    sliver: SliverGrid.count(
                      crossAxisSpacing: 7,
                      mainAxisSpacing: 7,
                      crossAxisCount: 3,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Material(
                              child: Ink(
                                width: 65,
                                height: 65,
                                decoration: const ShapeDecoration(
                                  //color: Colors.black,
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment
                                        .bottomRight, // 10% of the width, so there are ten blinds.
                                    colors: [
                                      Colors.purple,
                                      Colors.deepPurple
                                    ], // red to yellow
                                    tileMode: TileMode
                                        .repeated, // repeats the gradient over the canvas
                                  ),
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                ),
                                child: IconButton(
                                  color: Colors.white,
                                  icon: const Icon(
                                    Icons.school,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => const MySchool()));
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'My School',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Material(
                              child: Ink(
                                width: 65,
                                height: 65,
                                decoration: const ShapeDecoration(
                                  //color: Colors.black,
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment
                                        .bottomRight, // 10% of the width, so there are ten blinds.
                                    colors: [
                                      Colors.green,
                                      Color(0xff017205)
                                    ], // red to yellow
                                    tileMode: TileMode
                                        .repeated, // repeats the gradient over the canvas
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                ),
                                child: IconButton(
                                  color: Colors.white,
                                  icon: const Icon(
                                    Icons.messenger,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        content: const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(Icons.warning_amber),
                                            Text(
                                                'Coming soon ... This feature is currently under development and will be avliable in the next update')
                                          ],
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'OK'),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (_) => const ChatApp()));
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'Messenger',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Material(
                              child: Ink(
                                width: 65,
                                height: 65,
                                decoration: const ShapeDecoration(
                                  //color: Colors.black,
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment
                                        .bottomRight, // 10% of the width, so there are ten blinds.
                                    colors: [
                                      Colors.tealAccent,
                                      Colors.teal
                                    ], // red to yellow
                                    tileMode: TileMode
                                        .repeated, // repeats the gradient over the canvas
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                ),
                                child: IconButton(
                                  color: Colors.white,
                                  icon: const Icon(
                                    Icons.person,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        content: const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(Icons.warning_amber),
                                            Text(
                                                'Coming soon ... This feature is currently under development and will be avliable in the next update')
                                          ],
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'OK'),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (_) => const ChatApp()));
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'Teachers',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Material(
                              child: Ink(
                                width: 65,
                                height: 65,
                                decoration: const ShapeDecoration(
                                  //color: Colors.black,
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment
                                        .bottomRight, // 10% of the width, so there are ten blinds.
                                    colors: [
                                      Colors.red,
                                      Color(0xff980d03)
                                    ], // red to yellow
                                    tileMode: TileMode
                                        .repeated, // repeats the gradient over the canvas
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                ),
                                child: IconButton(
                                  color: Colors.white,
                                  icon: const Icon(
                                    Icons.apps,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        content: const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(Icons.warning_amber),
                                            Text(
                                                'Coming soon ... This feature is currently under development and will be avliable in the next update')
                                          ],
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'OK'),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (_) => const ChatApp()));
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'Apps',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Material(
                              child: Ink(
                                width: 65,
                                height: 65,
                                decoration: const ShapeDecoration(
                                  //color: Colors.black,
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment
                                        .bottomRight, // 10% of the width, so there are ten blinds.
                                    colors: [
                                      Colors.blue,
                                      Color(0xff02559a)
                                    ], // red to yellow
                                    tileMode: TileMode
                                        .repeated, // repeats the gradient over the canvas
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                ),
                                child: IconButton(
                                  color: Colors.white,
                                  icon: const Icon(
                                    Icons.computer,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        content: const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(Icons.warning_amber),
                                            Text(
                                                'Coming soon ... This feature is currently under development and will be avliable in the next update')
                                          ],
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'OK'),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );

                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (_) => const ChatApp()));
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'CBT',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Material(
                              child: Ink(
                                width: 65,
                                height: 65,
                                decoration: const ShapeDecoration(
                                  //color: Colors.black,
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment
                                        .bottomRight, // 10% of the width, so there are ten blinds.
                                    colors: [
                                      Color(0xffd900ff),
                                      Color(0xff7203a6)
                                    ], // red to yellow
                                    tileMode: TileMode
                                        .repeated, // repeats the gradient over the canvas
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                ),
                                child: IconButton(
                                  color: Colors.white,
                                  icon: const Icon(
                                    Icons.book,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        content: const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(Icons.warning_amber),
                                            Text(
                                                'Coming soon ... This feature is currently under development and will be avliable in the next update')
                                          ],
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'OK'),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );

                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (_) => const ChatApp()));
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'e-Learning',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Material(
                              child: Ink(
                                width: 65,
                                height: 65,
                                decoration: const ShapeDecoration(
                                  //color: Colors.black,
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment
                                        .bottomRight, // 10% of the width, so there are ten blinds.
                                    colors: [
                                      Color(0xff0396f8),
                                      Color(0xff022ce6)
                                    ], // red to yellow
                                    tileMode: TileMode
                                        .repeated, // repeats the gradient over the canvas
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                ),
                                child: IconButton(
                                  color: Colors.white,
                                  icon: const Icon(
                                    Icons.file_copy,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        content: const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(Icons.warning_amber),
                                            Text(
                                                'Coming soon ... This feature is currently under development and will be avliable in the next update')
                                          ],
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'OK'),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (_) => const ChatApp()));
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'Results',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Material(
                              child: Ink(
                                width: 65,
                                height: 65,
                                decoration: const ShapeDecoration(
                                  //color: Colors.black,
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment
                                        .bottomRight, // 10% of the width, so there are ten blinds.
                                    colors: [
                                      Color(0xff1b0020),
                                      Colors.black
                                    ], // red to yellow
                                    tileMode: TileMode
                                        .repeated, // repeats the gradient over the canvas
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                ),
                                child: IconButton(
                                  color: Colors.white,
                                  icon: const Icon(
                                    Icons.code,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        content: const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(Icons.warning_amber),
                                            Text(
                                                'Coming soon ... This feature is currently under development and will be avliable in the next update')
                                          ],
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'OK'),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (_) => const ChatApp()));
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'Coding',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Material(
                              child: Ink(
                                width: 65,
                                height: 65,
                                decoration: const ShapeDecoration(
                                  //color: Colors.black,
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment
                                        .bottomRight, // 10% of the width, so there are ten blinds.
                                    colors: [
                                      Color(0xffb7033f),
                                      Color(0xff84022d)
                                    ], // red to yellow
                                    tileMode: TileMode
                                        .repeated, // repeats the gradient over the canvas
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                ),
                                child: IconButton(
                                  color: Colors.white,
                                  icon: const Icon(
                                    Icons.question_mark,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HelpApp()));
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'Support',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 110,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const WebViewApp(
                                      url: 'https://results.neco.gov.ng',
                                      name: 'NECO Results Portal')));
                        },
                        child: Container(
                          width: 270,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment
                                  .bottomRight, // 10% of the width, so there are ten blinds.
                              colors: [
                                Color(0xff00852c),
                                Color(0xff077201)
                              ], // red to yellow
                              tileMode: TileMode
                                  .repeated, // repeats the gradient over the canvas
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 90,
                                width: 90,
                                child: Image.asset(
                                  'images/neco.png',
                                  height: 90,
                                  width: 90,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'NECO Portal',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const WebViewApp(
                                      url: 'https://www.waecdirect.org/',
                                      name:
                                          'WAECDIRECT ONLINE - Results Checker')));
                        },
                        child: Container(
                          width: 270,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment
                                  .bottomRight, // 10% of the width, so there are ten blinds.
                              colors: [
                                Color(0xff3538f9),
                                Color(0xff0205c9)
                              ], // red to yellow
                              tileMode: TileMode
                                  .repeated, // repeats the gradient over the canvas
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 90,
                                width: 90,
                                child: Image.asset(
                                  'images/waec.png',
                                  height: 90,
                                  width: 90,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'WAEC Direct',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const WebViewApp(
                                      url: 'https://jamb.gov.ng',
                                      name: 'UTME Portal')));
                        },
                        child: Container(
                          width: 270,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment
                                  .bottomRight, // 10% of the width, so there are ten blinds.
                              colors: [
                                Color(0xff8ef935),
                                Color(0xff02c98e)
                              ], // red to yellow
                              tileMode: TileMode
                                  .repeated, // repeats the gradient over the canvas
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 90,
                                width: 90,
                                child: Image.asset(
                                  'images/utme.png',
                                  height: 90,
                                  width: 90,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'UTME Portal',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const WebViewApp(
                                      url: 'https://bece.neco.gov.ng/',
                                      name:
                                          'Basic Education Certificate Examination')));
                        },
                        child: Container(
                          width: 270,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment
                                  .bottomRight, // 10% of the width, so there are ten blinds.
                              colors: [
                                Color(0xff02b4c4),
                                Color(0xff017e8a)
                              ], // red to yellow
                              tileMode: TileMode
                                  .repeated, // repeats the gradient over the canvas
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 90,
                                width: 90,
                                child: Image.asset(
                                  'images/neco.png',
                                  height: 90,
                                  width: 90,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'BECE Portal',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const WebViewApp(
                                      url: 'https://eworld.nabteb.gov.ng/',
                                      name: 'NABTEB eWorld')));
                        },
                        child: Container(
                          width: 270,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment
                                  .bottomRight, // 10% of the width, so there are ten blinds.
                              colors: [
                                Color(0xff04d79b),
                                Color(0xff03694c)
                              ], // red to yellow
                              tileMode: TileMode
                                  .repeated, // repeats the gradient over the canvas
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 90,
                                width: 90,
                                child: Image.asset(
                                  'images/nabted.webp',
                                  height: 90,
                                  width: 90,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'NABTEB',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //
            SizedBox(
              height: 7,
            )
          ],
        ));
  }

  void logout() async {
    var res = await Network().getData('/logout');
    var body = json.decode(res.body);
    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignIn()));
    }
  }
}
