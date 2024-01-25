import 'package:edcrib/screens/my_school.dart';
import 'package:flutter/material.dart';
import '../screens/home.dart';
import '../screens/sign_in.dart';
import '../network/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _secureText = true;
  String username = '', email = '', password = '', role = '';
  List<String> roles = ['teacher', 'parent', 'student'];

  //static List<School> _userOptions = <School>[];

  get url => null;
  get name => null;

  Future fetchSchool() async {
    final response =
        await http.get(Uri.parse('https://lms.edcrib.com/edcrib_schools'));

    return json.decode(response.body);
  }

  static String _displayStringForOption(School option) => option.name;
  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  _showMsg(msg) {
    Navigator.of(context, rootNavigator: true).pop('dialog');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: Duration(seconds: 2),
      ),
    );
    // final snackBar = SnackBar(
    //   content: Text(msg),
    // );
    //_scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xff151515),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 28, vertical: 30),
          child: Column(
            children: [
              Container(
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Colors.white.withOpacity(0.4), BlendMode.dstATop),
                        image: const AssetImage("images/vector_art6.jpg"),
                        fit: BoxFit.cover),
                  ),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        color: Colors.white,
                        height: 70,
                        width: 70,
                        child: Image.asset(
                          'images/edcrib_logo.png',
                          height: 70,
                          width: 70,
                        ),
                      ),
                    ),
                  )
                  //Center(child: Image.asset('../images/edcrib_png1.png')),
                  ),
              SizedBox(
                height: 10,
              ),
              Card(
                elevation: 4.0,
                color: Colors.white,
                margin: EdgeInsets.only(top: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Register",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 18),
                        TextFormField(
                            cursorColor: Colors.blue,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: "Full Name",
                            ),
                            validator: (nameValue) {
                              if (nameValue!.isEmpty) {
                                return 'Please enter your full name';
                              }
                              username = nameValue;
                              return null;
                            }),
                        SizedBox(height: 12),
                        TextFormField(
                            cursorColor: Colors.blue,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: "Email",
                            ),
                            validator: (emailValue) {
                              if (emailValue!.isEmpty) {
                                return 'Please enter your email';
                              }
                              email = emailValue;
                              return null;
                            }),
                        SizedBox(height: 12),
                        TextFormField(
                            cursorColor: Colors.blue,
                            keyboardType: TextInputType.text,
                            obscureText: _secureText,
                            decoration: InputDecoration(
                              hintText: "Password",
                              suffixIcon: IconButton(
                                onPressed: showHide,
                                icon: Icon(_secureText
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                            ),
                            validator: (passwordValue) {
                              if (passwordValue!.isEmpty) {
                                return 'Please enter your password';
                              }
                              password = passwordValue;
                              return null;
                            }),
                        SizedBox(height: 24),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            DropdownMenu<String>(
                              label: Text(
                                'I am a',
                                style:
                                    TextStyle(fontSize: 21, color: Colors.grey),
                              ),
                              //width: MediaQuery.of(context).size.width,
                              initialSelection: roles.first,
                              onSelected: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  role = value!;
                                });
                              },
                              dropdownMenuEntries: roles
                                  .map<DropdownMenuEntry<String>>(
                                      (String value) {
                                return DropdownMenuEntry<String>(
                                    value: value, label: value);
                              }).toList(),
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _register();
                            }
                          },
                          child: Container(
                            color: Colors.black,
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(50, 15, 50, 15),
                              child: Text(
                                'Submit',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => SignIn()));
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 16.0,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _register() async {
    try {
      setState(() {
        _isLoading = !_isLoading;
      });
      var data = {
        'name': username,
        'email': email,
        'password': password,
        'role': role,
      };

      var res = await Network().post(data, '/register');
      var body = json.decode(res.body);
      if (body['success']) {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString('token', json.encode(body['token']));
        localStorage.setString('user', json.encode(body['user']));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Registration Failed'),
            content: Text('${body["message"]}'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );

        // if (body['message']['name'] != null) {
        //   _showMsg(body['message']['name'][0].toString());
        // } else if (body['message']['email'] != null) {
        //   _showMsg(body['message']['email'][0].toString());
        // } else if (body['message']['password'] != null) {
        //   _showMsg(body['message']['password'][0].toString());
        // }
      }

      setState(() {
        _isLoading = !_isLoading;
      });
    } catch (e) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          content: Text('Error - Registration failed'),
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
