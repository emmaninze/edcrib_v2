import 'dart:convert';

import 'package:edcrib/screens/home.dart';
import 'package:edcrib/screens/settings.dart';
import 'package:edcrib/screens/sign_in.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../my_uyils.dart';
import '../network/api.dart';
import '../web_container.dart';
//import '../web_container.dart';
// import 'home.dart';

class MySchool extends StatefulWidget {
  const MySchool({super.key});

  @override
  State<MySchool> createState() => _MySchoolState();
}

class _MySchoolState extends State<MySchool> {
  static List<School> _userOptions = <School>[];
  static List<Logo> _logos = <Logo>[];
  Future fetchSchool() async {
    final response =
        await http.get(Uri.parse('https://lms.edcrib.com/edcrib_schools'));
    return json.decode(response.body);
  }

  static String _displayStringForOption(School option) => option.name;
  // final fieldText = TextEditingController();
  String userName = '';

  static List<SchoolUrl> _userItems = <SchoolUrl>[];

  @override
  void initState() {
    super.initState();
    _loadUserData();
    //_value = getLogo('${_userItems[index].url}/get_logo_url');
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user') as String);
    final List<SchoolUrl> urls =
        SchoolUrl.decode(localStorage.getString('urls') as String);
    if (user != null) {
      setState(() {
        userName = user['name'];
        _userItems =
            (urls == []) ? [] : List<SchoolUrl>.from(urls.toSet().toList());
      });
    }

    try {
      var counter = 1;
      List<Logo> _tempList = <Logo>[];
      _userItems.forEach((element) {
        getLogo('${element.url}/get_logo_url').then((value) {
          _tempList.add(Logo(logo: '${element.url}/${value['logo']}'));

          if (counter++ == _userItems.length) {
            setState(() {
              _logos = List.from(_tempList);
            });
          }
        });
      });
    } catch (e) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Something went wrong'),
          content: const Text('An error occured'),
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

  @override
  Widget build(BuildContext context) {
    fetchSchool().then((value) {
      value.forEach((entry) {
        String sUrl = entry['url'];
        String sName = entry['name'];
        _userOptions.add(School(url: sUrl, name: sName));
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const HomePage()));
          },
          child: Icon(
            Icons.home,
            // style: TextStyle(
            //   fontSize: 16,
            //   color: Color.fromARGB(219, 255, 255, 255),
            // ),
          ),
        ),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
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
          )
        ],
      ),
      body: Container(
          color: Color.fromARGB(255, 223, 223, 223),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('Select your school below to continue'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            // Add padding around the search bar
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
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
                                        final result = _userOptions.where(
                                            (school) =>
                                                school.name ==
                                                textEditingController.text);
                                        // debugPrint(
                                        //     'You just selected ${result.elementAt(0).url}');

                                        if (result.length > 0) {
                                          try {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        WebViewApp(
                                                            url: result
                                                                .elementAt(0)
                                                                .url,
                                                            name: result
                                                                .elementAt(0)
                                                                .name)));
                                          } catch (e) {
                                            print(
                                                'Something went wrong. Please try again');
                                            return;
                                          }
                                        }
                                      },
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                );
                                // return TextFormField(
                                //   controller: textEditingController,
                                //   focusNode: focusNode,
                                //   onFieldSubmitted: (String value) {
                                //     onFieldSubmitted();
                                //   },
                                // );
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
                                              title: Text(
                                                  _displayStringForOption(
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
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    child: ListView.builder(
                      itemCount: _userItems.length,
                      // prototypeItem: ListTile(
                      //   title: Text(_userItems[index]['name']),
                      // ),
                      itemBuilder: (context, index) {
                        var logo = _logos.where((e) =>
                            '$e'.split('.')[0] ==
                            _userItems[index].url.split('.')[0]);

                        return Card(
                          elevation: 8.0,
                          margin: new EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 6.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(64, 75, 96, .9)),
                            child: Dismissible(
                              key: Key('$index'),
                              onDismissed: (direction) async {
                                setState(() {
                                  _userItems.removeAt(index);
                                });
                                String encodedData =
                                    SchoolUrl.encode(_userItems);
                                SharedPreferences localStorage =
                                    await SharedPreferences.getInstance();
                                localStorage.setString('urls', encodedData);
                                final List<SchoolUrl> urls = SchoolUrl.decode(
                                    localStorage.getString('urls') as String);
                                setState(() {
                                  _userItems = urls;
                                });
                              },
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => WebViewApp(
                                              url: _userItems[index].url,
                                              name: _userItems[index].name)));
                                },
                                child: ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 10.0),
                                    leading: Container(
                                        color: Colors.white,
                                        height: 50,
                                        width: 50,
                                        child: Image.network(
                                          '${logo.elementAt(0)}',
                                          scale: 0.2,
                                        )),
                                    title: Text(
                                      _userItems[index].name,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                    subtitle: Row(
                                      children: <Widget>[
                                        Icon(Icons.linear_scale,
                                            color: Colors.yellowAccent),
                                        // Text(
                                        //     _userItems[index].url +
                                        //         '/uploads/logo_' +
                                        //         (_userItems[index]
                                        //                 .url
                                        //                 .split('//')[1])
                                        //             .split('.')[0] +
                                        //         '.jpeg',
                                        //     style: TextStyle(color: Colors.white))
                                      ],
                                    ),
                                    trailing: Icon(Icons.keyboard_arrow_right,
                                        color: Colors.white, size: 30.0)),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          )),
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
}

class School {
  School({
    required this.url,
    required this.name,
  });

  late final String url;
  late final String name;

  School.fromJson(Map<String, dynamic> json) {
    url = json['url']!;
    name = json['name']!;
  }

  @override
  String toString() {
    return '$name, $url';
  }
}

class Logo {
  String logo;

  Logo({
    required this.logo,
  });

  factory Logo.fromJson(Map<String, dynamic> json) => Logo(
        logo: json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "logo": logo,
      };

  @override
  String toString() {
    return logo;
  }
}

Future getLogo(curPath) async {
  final response = await http.get(Uri.parse(curPath));
  return json.decode(response.body);
  // final imgPath = Logo.fromJson(json.decode(response.body));
}
