import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_connect/constant.dart';
import 'package:simple_auth/simple_auth.dart' as simpleAuth;
import 'package:simple_auth_flutter/simple_auth_flutter.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IG Flutter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: InstagramConnect(),
    );
  }
}

class InstagramConnect extends StatefulWidget {
  InstagramConnect({Key key}) : super(key: key);

  @override
  _InstagramConnectState createState() => _InstagramConnectState();
}

class _InstagramConnectState extends State<InstagramConnect> {
  String _errorMsg;
  Map _userData;
  var userdata;

  final simpleAuth.InstagramApi _igApi = simpleAuth.InstagramApi(
    "instagram",
    Constants.igClientId,
    Constants.igClientSecret,
    Constants.igRedirectURL,
    scopes: [
      'user_profile', // For getting username, account type, etc.
      'user_media', // For accessing media count & data like posts, videos etc.
    ],
  );

  @override
  void initState() {
    super.initState();
    SimpleAuthFlutter.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instagram Basic Display API Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Visibility(
              visible: _userData != null,
              child: Text(_userData ==null?
                "hello":
                _userData.keys.fold(
                    '', (kvText, key) => kvText + "$key: ${_userData[key]} \n"),
                textAlign: TextAlign.center,
              ),
              replacement:
              Text("Click the button below to get Instagram Login."),
            ),
            FlatButton.icon(
              icon: Icon(Icons.input),
              label: Text(
                "Get Profile Data",
              ),
              onPressed:(){
                var temp = _loginAndGetData();
                print(temp.toString());
                print(userdata.toString());
                },
              color: Colors.pink.shade400,
            ),
            if (_errorMsg != null) Text("Error occured: $_errorMsg"),
          ],
        ),
      ),
    );
  }

  Future<void> _loginAndGetData() async {
    _igApi.authenticate().then(
          (simpleAuth.Account _user) async {
        simpleAuth.OAuthAccount user = _user;

        var igUserResponse =
        await Dio(BaseOptions(baseUrl: 'https://graph.instagram.com')).get(
          '/17841406722022855',
          queryParameters: {
            // Get the fields you need.
            // https://developers.facebook.com/docs/instagram-basic-display-api/reference/user
            "fields": "media_url",
            "access_token": user.token,
          },
        );
        //17841406722022855
print(igUserResponse.data);
print(igUserResponse);
        setState(() {
          _userData = igUserResponse.data;
          _errorMsg = null;
        });
      },
    ).catchError(
          (Object e) {
        setState(() => _errorMsg = e.toString());
      },
    );
  }

  // Future<void> getProfileData(String username) async {
  //   var res = await http.get(Uri.encodeFull("https://www.instagram.com/" + username + "/?__a=1"));
  //   var data = json.decode(res.body);
  //   var graphql = data['graphql'];
  //   var user = graphql['user'];
  //   print(user);
  //
  // }
  //
  // Future<void> _getMoreData(String username) {
  //   return Dio().get('https://instagram.com/$username/?__a=1').then(
  //         (Response response) {
  //           String jsonsDataString = response.data.toString();
  //       var userData = jsonDecode(jsonsDataString)['graphql']['user']['profile_pic_url_hd'];
  //         print(userData);
  //         return userData;
  //     },
  //   );
  // }

}