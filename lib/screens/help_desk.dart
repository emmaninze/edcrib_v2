import 'dart:convert';
import 'package:edcrib/network/api.dart';
import 'package:edcrib/screens/home.dart';
import 'package:edcrib/screens/settings.dart';
import 'package:edcrib/screens/sign_in.dart';
import 'package:flutter/material.dart';
//import 'package:open_whatsapp/open_whatsapp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

class HelpApp extends StatefulWidget {
  HelpApp({Key? key}) : super(key: key);

  @override
  State<HelpApp> createState() => _HelpAppState();
}

class _HelpAppState extends State<HelpApp> {
  var userName;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user') as String);

    setState(() {
      userName = user['name'];
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          actions: [
            Row(
              children: [
                Text(
                  userName,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                SizedBox(width: 2.0),
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
            ),
          ],
        ),
        body: Center(
            child: Container(
          height: 150,
          child: Column(
            children: [
              Text('Get Quick Help?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          launch(
                              'https://api.whatsapp.com/send/?text=Hi&phone=2349078070049&type=custom_url&app_absent=0');

                          //_launchWhatsapp();
                          // FlutterOpenWhatsapp.sendSingleMessage(
                          //     "2349078070049", "Hi");
                        },
                        child: Icon(
                          LineAwesomeIcons.what_s_app,
                          size: 50,
                        ),
                      ),
                      Text('WhatsApp')
                    ],
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          launch("tel://2349078070049");
                        },
                        child: Icon(
                          LineAwesomeIcons.phone,
                          size: 50,
                        ),
                      ),
                      Text('Call')
                    ],
                  )
                ],
              ),
            ],
          ),
        )));
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

  _launchWhatsapp() async {
    var phone = '+2349078070049';
    var message = Uri.parse('Hi');
    var url = 'https://api.whatsapp.com/send?phone=$phone&&text=$message';
    if (Platform.isAndroid) {
      // add the [https]
      url = 'https://wa.me/$phone/?text=$message'; // new line
    }
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            content: Text('ould not launch $url'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          content: Text('$e'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
