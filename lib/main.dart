//import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_connect/facebook_connect.dart';
import 'package:flutter_connect/insta_connect.dart';
import 'package:flutter_connect/instagram_connect.dart';
import 'constant.dart';
import 'package:simple_auth/simple_auth.dart' as simpleAuth;
import 'package:simple_auth_flutter/simple_auth_flutter.dart';

void main() {
  runApp(MaterialApp(
      home: FlutterConnect()));
}
class FlutterConnect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Connect with social media",
        ),
      ),
      body: Container(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FacebookConnect()));
              },
              child: Text("Click to connect with Facebook"),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => InstagramConnect()));
              },
              child: Text("Click to connect with Instagram"),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("Click to connect with Spotify"),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
