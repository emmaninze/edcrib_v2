import 'dart:convert';

import 'package:edcrib/screens/sign_in.dart';
import 'package:edcrib/user/profile.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/api.dart';
import 'home.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var userName;
  bool toggleValue = false;

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

  @override
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
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SettingsList(
          sections: [
            SettingsSection(
              title: Text('Settings'),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  leading: Icon(Icons.language),
                  title: Text('Language'),
                  value: Text('English'),
                ),
                SettingsTile.navigation(
                  leading: Icon(LineAwesomeIcons.user),
                  title: Text('Profile Settings'),
                  value: Text('edit profile'),
                  onPressed: (value) {
                    _getProfile();
                  },
                ),
                SettingsTile.switchTile(
                  onToggle: (value) {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        content: Text(
                            'This feature is temporarily disabled, but will be available in future updates'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                    // setState(() {
                    //   toggleValue = !toggleValue;
                    // });
                  },
                  initialValue: toggleValue,
                  leading: Icon(Icons.format_paint),
                  title: Text('System Theme'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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

  get _getProfile {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ProfileSettings()));
  }
}
