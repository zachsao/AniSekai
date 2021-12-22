import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

ValueNotifier<GraphQLClient> clientFor() {
  return ValueNotifier<GraphQLClient>(GraphQLClient(
    cache: GraphQLCache(store: HiveStore()),
    link: HttpLink('https://graphql.anilist.co'),
  ));
}

class ClientProvider extends StatelessWidget {
  ClientProvider({Key? key, required this.child,}) : client = clientFor(), super(key: key);

  final Widget child;
  final ValueNotifier<GraphQLClient> client;

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: child,
    );
  }
}
