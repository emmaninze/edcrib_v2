import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/api.dart';
import '../screens/home.dart';
import '../screens/settings.dart';
import '../screens/sign_in.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _oldPassword = TextEditingController();
  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _email = TextEditingController();

  bool showPassword = true;
  var userName;
  var user;
  String fullname = '';
  String email = '';
  String old_password = '';
  String password = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    setState(() {
      user = jsonDecode(localStorage.getString('user') as String);
      userName = user['name'];
      // fullname = user['name'];
      // email = user['email'];
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
        padding: const EdgeInsets.all(20.0),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              const Text(
                "Profile Settings",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 35,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          buildTextField("Full Name", fullname, _fullname,
                              '${user['name']}', false),
                          const SizedBox(
                            height: 10,
                          ),
                          buildTextField("E-mail", email, _email,
                              '${user['email']}', false),
                          const SizedBox(
                            height: 10,
                          ),
                          buildTextField("Old Password", old_password,
                              _oldPassword, "********", true),
                          const SizedBox(
                            height: 10,
                          ),
                          buildTextField("New Password", password, _password,
                              "********", true),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              elevation: 5.0,
                              padding: const EdgeInsets.fromLTRB(
                                  45.0, 20.0, 45.0, 20.0),
                              backgroundColor: Colors.grey,
                              textStyle: const TextStyle(
                                  fontSize: 16, color: Colors.black),
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                            },
                            child: const Text('Cancel')),
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            elevation: 5.0,
                            padding: const EdgeInsets.fromLTRB(
                                45.0, 20.0, 45.0, 20.0),
                            backgroundColor: Color(0xff000000),
                            textStyle: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          ),
                          onPressed: () {
                            setState(() {
                              old_password = _oldPassword.text;

                              fullname = _fullname.text;

                              email = _email.text;

                              password = _password.text;
                            });

                            _update();
                          },
                          child: const Text('Update'),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText,
      String formVal,
      TextEditingController formController,
      String placeholder,
      bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextFormField(
        controller: formController,
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: showPassword
                        ? const Icon(
                            Icons.remove_red_eye,
                            color: Colors.grey,
                          )
                        : const Icon(
                            LineAwesomeIcons.eye_slash,
                            color: Colors.grey,
                          ),
                  )
                : null,
            contentPadding: const EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Color(0xff5f5f5f),
            )),
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

  void _update() async {
    try {
      var data = {
        'name': fullname,
        'email': email,
        'password': password,
        'old_password': old_password,
        'userid': user['id']
      };

      var res = await Network().post(data, '/update');
      var body = json.decode(res.body);
      if (body['success']) {
        // SharedPreferences localStorage = await SharedPreferences.getInstance();
        // localStorage.setString('token', json.encode(body['token']));
        // localStorage.setString('user', json.encode(body['user']));
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => HomePage()),
        // );
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            content: Text('${body["message"]}'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                ),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            content: Text('${body["message"]}'),
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
          content: Text('Error - Profile Update failed'),
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
