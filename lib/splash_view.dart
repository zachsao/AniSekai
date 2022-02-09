import 'package:anisekai/graphql/operations.dart';
import 'package:anisekai/models/user.dart';
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
  int? userId;

  @override
  void initState() {
    super.initState();
    _readTokenFromStorage();
  }

  Future<void> _readTokenFromStorage() async {
    String? token = await _storage.read(key: "accessToken");
    String? uid = await _storage.read(key: "uid");
    bool tokenExists = token?.isNotEmpty ?? false;
    setState(() {
      isLoggedIn = tokenExists;
      userId = int.tryParse(uid ?? "");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationState>(
      builder: (context, authState, child) {
        if (authState.accessToken.isNotEmpty || isLoggedIn == true) {
          if (userId == null) {
            String viewerQuery = '''
              query user {
                Viewer {
                  id
                }
              }
            ''';
            return buildQuery(viewerQuery, (data, _) {
              int userId = UserModel.fromJson(data).user.id;
              _storage.write(key: "uid", value: "$userId");
              return LoggedInPage(userId: userId,);
            });
          }
          return LoggedInPage(userId: userId!);
        } else if (isLoggedIn == false) {
          return const LoginPage();
        }
        return Container(
          color: Theme.of(context).colorScheme.background,
          child: const Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
}