import 'dart:convert';

import 'package:anisekai/secrets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'graphql/client_provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  _authenticate(BuildContext context) async {
    String url = 'https://anilist.co/api/v2/oauth/authorize?client_id=$clientId&redirect_uri=anisekai%3A%2F&response_type=code';
    final result = await FlutterWebAuth.authenticate(url: url, callbackUrlScheme: "anisekai");
    final code = result.split("=")[1];
    dynamic credentials = jsonDecode((await fetchAccessToken(code)).body);
    const _storage = FlutterSecureStorage();
    _storage.write(key: "accessToken", value: credentials['access_token']);
    Provider.of<AuthenticationState>(context, listen: false).isAuthenticated(credentials['access_token']);
  }

  Future<http.Response> fetchAccessToken(String code) {
    return http.post(
      Uri.parse('https://anilist.co/api/v2/oauth/token'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'grant_type': 'authorization_code',
        'client_id': clientId,
        'client_secret': clientSecret,
        'redirect_uri': 'anisekai:/',
        'code': code
      }),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF2B2D42),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              _authenticate(context);
            },
            child: const Text(
              "Sign in with AniList",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

}