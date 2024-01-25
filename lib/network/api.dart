import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  String _url;
  var token;

  Network([this._url = 'https://lms.edcrib.com/api']);
  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    if (localStorage.getString('token') != null) {
      token = localStorage.getString('token');
    }
    token = jsonDecode(token)['token'];
  }

  auth(data, apiURL) async {
    Uri fullUrl = Uri.parse(_url + apiURL);
    return await http.post(fullUrl,
        body: json.encode(data), headers: _setHeaders());
  }

  post(data, apiURL) async {
    Uri fullUrl = Uri.parse(_url + apiURL);
    return await http.post(fullUrl,
        body: json.encode(data), headers: _setHeaders());
  }

  getData(apiURL) async {
    Uri fullUrl = Uri.parse(_url + apiURL);
    await _getToken();
    return await http.get(
      fullUrl,
      headers: _setHeaders(),
    );
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
}
