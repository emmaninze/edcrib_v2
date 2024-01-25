//import 'package:edcrib/screens/err_page.dart';
import 'package:edcrib/screens/my_school.dart';
import 'package:flutter/material.dart';
import '../my_uyils.dart';
import '../network/api.dart';
import 'register.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
import 'package:http/http.dart' as http;

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  var email, password;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  static List<SchoolUrl> urls = <SchoolUrl>[];
  bool _secureText = true;
  String sUri = '';
  String sName = '';

  // static List<School> _userOptions = <School>[];

  get url => null;
  get name => null;

  Future fetchSchool() async {
    try {
      final response =
          await http.get(Uri.parse('https://lms.edcrib.com/edcrib_schools'));
      return json.decode(response.body);
    } catch ($e) {
      // print($e);
    }
  }

  static List<School> _userOptions = <School>[];

  static String _displayStringForOption(School option) => option.name;

  // final fieldText = TextEditingController();

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
    // _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    fetchSchool().then((value) {
      value.forEach((entry) {
        String url = entry['url'];
        String name = entry['name'];
        _userOptions.add(School(url: url, name: name));
      });
    });
    //
    print(_userOptions);

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
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('Select your school below to login'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          // Add padding around the search bar
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: RawAutocomplete<School>(
                            optionsBuilder:
                                (TextEditingValue textEditingValue) {
                              return _userOptions.where((School option) {
                                // Search based on User.toString, which includes both name and
                                // email, even though the display string is just the name.
                                return option.toString().contains(
                                    textEditingValue.text.toLowerCase());
                              });
                            },
                            displayStringForOption: _displayStringForOption,
                            fieldViewBuilder: (
                              BuildContext context,
                              TextEditingController textEditingController,
                              FocusNode focusNode,
                              VoidCallback onFieldSubmitted,
                            ) {
                              return TextField(
                                onTapOutside: (event) {
                                  final result = _userOptions.where((school) =>
                                      school.name ==
                                      textEditingController.text);
                                  if (result.length > 0) {
                                    setState(() {
                                      sUri = result.elementAt(0).url;
                                      sName = textEditingController.text;
                                      result.elementAt(0).name;
                                    });
                                  }
                                },
                                onSubmitted: (String value) async {
                                  final result = _userOptions
                                      .where((school) => school.name == value);
                                  if (result.length > 0) {
                                    setState(() {
                                      sUri = result.elementAt(0).url;
                                      sName = value;
                                      result.elementAt(0).name;
                                    });
                                  }
                                },
                                // controller: _searchController,
                                controller: textEditingController,
                                focusNode: focusNode,
                                decoration: InputDecoration(
                                  hintText: 'search...',
                                  // Add a clear button to the search bar
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.clear),
                                    onPressed: () =>
                                        textEditingController.clear(),
                                  ),
                                  // Add a search icon or button to the search bar
                                  prefixIcon: IconButton(
                                    icon: Icon(Icons.search),
                                    onPressed: () {
                                      // Perform the search here
                                      // final result = _userOptions.where(
                                      //     (school) =>
                                      //         school.name ==
                                      //         textEditingController.text);

                                      // if (result.length > 0) {
                                      //   // print(
                                      //   //     'You just selected ${result.elementAt(0).url}');
                                      //   setState(() {
                                      //     sUri = result.elementAt(0).url;
                                      //     sName = result.elementAt(0).name;
                                      //   });
                                      // }
                                    },
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),

                                // onSubmitted:
                                //     _setSchUrl(textEditingController.text),
                              );
                            },
                            optionsViewBuilder: (BuildContext context,
                                AutocompleteOnSelected<School> onSelected,
                                Iterable<School> options) {
                              return Align(
                                alignment: Alignment.topLeft,
                                child: Material(
                                  elevation: 4.0,
                                  child: SizedBox(
                                    height: 200.0,
                                    child: ListView.builder(
                                      padding: const EdgeInsets.all(8.0),
                                      itemCount: options.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final School option =
                                            options.elementAt(index);
                                        return GestureDetector(
                                          onTap: () {
                                            onSelected(option);
                                          },
                                          child: ListTile(
                                            title: Text(_displayStringForOption(
                                                option)),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                ),
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
                          "Login",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 18),
                        TextFormField(
                            //  cursorColor: Color(0xff17017c),
                            // keyboardType: TextInputType.text,
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
                            // cursorColor: Color(0xff17017c),
                            // keyboardType: TextInputType.text,
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
                        SizedBox(height: 40),
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(Colors.blue),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _login();
                            }
                          },
                          child: Container(
                              color: Colors.black,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(50, 15, 50, 15),
                                child: Text('Submit',
                                    style: TextStyle(color: Colors.white)),
                              )),
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
                    "Don't have an account? ",
                    style: TextStyle(
                      color: Colors.white,
                      // fontSize: 16,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => Register()));
                    },
                    child: Text(
                      'Register',
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

  void _login() async {
    setState(() {
      _isLoading = !_isLoading;
    });
    try {
      var data = {'email': email, 'password': password};
      var res = (sUri != '')
          ? await Network('$sUri/api').auth(data, '/login')
          : await Network().auth(data, '/login');
      var body = json.decode(res.body);
      if (body['success']) {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        if (localStorage.containsKey('urls')) {
          final List<SchoolUrl> urlStore =
              SchoolUrl.decode(localStorage.getString('urls') as String);
          // urls.add(urlStore as SchoolUrl);
          setState(() {
            urls = List<SchoolUrl>.from(urlStore);
          });
        }

        localStorage.setString('token', json.encode(body['token']));
        localStorage.setString('user', json.encode(body['user']));
        //localStorage.setString('sUri', json.encode(body['url']));
        if (sUri != '') {
          var elm = urls.where((elem) => elem.url == sUri);

          if (elm.isEmpty) {
            urls.add(SchoolUrl(url: sUri, name: sName));
          }

          final String encodedData = SchoolUrl.encode(urls);
          localStorage.setString('urls', encodedData);
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        // _showMsg(body['message']);
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Something went wrong'),
            content: const Text('Your login details are incorrect'),
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
      // print($e);
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Something went wrong'),
          content: Text('An error occured. Pls try again'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );

      //   // SingleChildScrollView(
      //   //   child: Expanded(
      //   //     child: IntrinsicHeight(
      //   //       child: Column(
      //   //         children: <Widget>[
      //   //           Container(
      //   //             // A fixed-height child.
      //   //             color: const Color(0xffeeee00), // Yellow
      //   //             height: 120.0,
      //   //             alignment: Alignment.center,
      //   //             child: Text('${$e}'),
      //   //           ),
      //   //         ],
      //   //       ),
      //   //     ),
      //   //   ),
      //   // );
    }

    setState(() {
      _isLoading = !_isLoading;
    });
  }
}
