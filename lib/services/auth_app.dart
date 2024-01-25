import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/error.dart';
import '../screens/home.dart';
import '../onboarding_screen.dart';

class CheckAuth extends StatefulWidget {
  const CheckAuth({super.key});

  @override
  // _CheckAuthState createState() => _CheckAuthState();
  State<CheckAuth> createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool isAuth = false;

  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
  }

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if (token != null) {
      if (mounted) {
        setState(() {
          isAuth = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isAuth) {
      return HomePage();
    } else {
      return MaterialApp(
          title: 'Introduction screen',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: const Color.fromARGB(255, 240, 13, 21),
            primarySwatch: Colors.red,
          ),
          home: OnBoardingPage());
    }
  }
}

// import 'package:flutter/cupertino.dart';
// import 'dart:convert';
// import 'dart:developer';

// import 'package:dio/dio.dart' as di;
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import '../helper/dio.dart';
// import '../models/error.dart';
// import '../models/user.dart';
// import 'package:platform_device_id/platform_device_id.dart';

class AuthProvider extends ChangeNotifier {
  // bool _authenticated = false;
  //User? _user;
  ValidationError? _validationError;
  ValidationError? get validationError => _validationError;
  // User? get user => _user;
  // final storage = FlutterSecureStorage();
  // bool get authenticated => _authenticated;
  bool _obscureText = false;

  bool get obscureText => _obscureText;

  // Future register({credential}) async {
  //   String deviceId = await getDeviceId();
  //   try {
  //     di.Response res = await dio('https://lms.edcib.com').post('user/register',
  //         data: json.encode(credential..addAll({'deviceId': deviceId})));
  //     String token = await res.data['token'];
  //     await attempt(token);
  //     await storeToken(token);
  //   } on di.DioError catch (e) {
  //     if (e.response?.statusCode == 422) {
  //       _validationError = ValidationError.fromJson(e.response!.data['errors']);
  //       notifyListeners();
  //     }
  //   }
  // }

  // Future login({required Map credential}) async {
  //   String deviceId = await getDeviceId();
  //   try {
  //     di.Response response = await dio('https://lms.edcib.com').post(
  //         'auth/token',
  //         data: json.encode(credential..addAll({'deviceId': deviceId})));
  //     String token = await response.data['token'];
  //     await attempt(token);
  //     await storeToken(token);
  //   } on di.DioError catch (e) {
  //     if (e.response?.statusCode == 422) {
  //       _validationError = ValidationError.fromJson(e.response!.data['errors']);
  //       notifyListeners();
  //     }
  //   }
  // }

  // Future attempt(String? token) async {
  //   try {
  //     di.Response res = await dio('https://lms.edcib.com').get(
  //       'auth/user',
  //       options: di.Options(
  //         headers: {
  //           'Authorization': 'Bearer $token',
  //         },
  //       ),
  //     );

  //     _user = User.fromJson(res.data);

  //     _authenticated = true;
  //   } catch (e) {
  //     log('error log ${e.toString()}');
  //     _authenticated = false;
  //   }
  //   notifyListeners();
  // }

  // Future getDeviceId() async {
  //   String? deviceId = await PlatformDeviceId.getDeviceId;
  //   return deviceId;
  // }

  // Future storeToken(String token) async {
  //   await storage.write(key: 'auth', value: token);
  // }

  // Future getToken() async {
  //   final token = await storage.read(key: 'auth');
  //   return token;
  // }

  // Future deleteToken() async {
  //   await storage.delete(key: 'auth');
  // }

  // Future logout() async {
  //   final token = await storage.read(key: 'auth');
  //   _authenticated = false;
  //   await dio('https://lms.edcib.com').delete('auth/token/delete',
  //       data: {'deviceId': await getDeviceId()},
  //       options: di.Options(headers: {
  //         'Authorization': 'Bearer $token',
  //       }));
  //   await deleteToken();
  //   notifyListeners();
  // }

  void toggleText() {
    _obscureText = !_obscureText;
    notifyListeners();
  }
}
