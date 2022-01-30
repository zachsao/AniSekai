import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

ValueNotifier<GraphQLClient> clientFor(BuildContext context) {
  Link link;
  final HttpLink httpLink = HttpLink('https://graphql.anilist.co');
  final AuthenticationState authenticationState = Provider.of<AuthenticationState>(context);
  if (authenticationState.accessToken.isNotEmpty){
    final AuthLink authLink = AuthLink(
      getToken: () => 'Bearer ${authenticationState.accessToken[0]}',
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

class ClientProvider extends StatelessWidget {
  const ClientProvider({Key? key, required this.child,}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final client = clientFor(context);
    return GraphQLProvider(
      client: client,
      child: child,
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