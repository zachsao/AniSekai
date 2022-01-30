import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

ValueNotifier<GraphQLClient> clientFor(BuildContext context, String? accessToken) {
  Link link;
  String? token = accessToken;
  final HttpLink httpLink = HttpLink('https://graphql.anilist.co');
  final AuthenticationState authenticationState = Provider.of<AuthenticationState>(context);

  if (authenticationState.accessToken.isNotEmpty) token = authenticationState.accessToken[0];
  if (token != null){
    final AuthLink authLink = AuthLink(
      getToken: () => 'Bearer $token',
    );
    link = authLink.concat(httpLink);
  }else {
    link = httpLink;
  }


  return ValueNotifier<GraphQLClient>(GraphQLClient(
    cache: GraphQLCache(store: HiveStore()),
    link: link,
  ));
}

class ClientProvider extends StatefulWidget {
  const ClientProvider({Key? key, required this.child,}) : super(key: key);
  final Widget child;
  final storage = const FlutterSecureStorage();

  @override
  State<ClientProvider> createState() => _ClientProviderState();
}

class _ClientProviderState extends State<ClientProvider> {
  String? accessToken;

  @override
  void initState() {
    super.initState();
    _readTokenFromStorage();
  }

  Future<void> _readTokenFromStorage() async {
    String? token = await widget.storage.read(key: "accessToken");
    setState(() {
      accessToken = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: clientFor(context, accessToken),
      child: widget.child,
    );
  }
}

class AuthenticationState with ChangeNotifier{

  final _token = [];
  dynamic get accessToken => _token;

  void isAuthenticated(String value) {
    _token.add(value);
    notifyListeners();
  }

  void isNotAuthenticated() {
    _token.clear();
    notifyListeners();
  }
}