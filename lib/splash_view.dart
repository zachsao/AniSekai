import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'graphql/client_provider.dart';
import 'login_view.dart';
import 'main.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _storage = const FlutterSecureStorage();
  bool? isLoggedIn;

  @override
  void initState() {
    super.initState();
    _readTokenFromStorage();
  }

  Future<void> _readTokenFromStorage() async {
    String? token = await _storage.read(key: "accessToken");
    bool tokenExists = token?.isNotEmpty ?? false;
    setState(() {
      isLoggedIn = tokenExists;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationState>(
      builder: (context, authState, child) {

        if (authState.accessToken.isNotEmpty || isLoggedIn == true) {
          return const LoggedInPage();
        } else if (isLoggedIn == false) {
          return const LoginPage();
        }
        return Container(
          color: const Color(0xFF2B2D42),
          child: const Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
}