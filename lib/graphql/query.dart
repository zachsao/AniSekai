import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

Query buildQuery(String query, BuildContext context, Widget Function(Map<String, dynamic>) body, {Map<String, dynamic> variables = const {}}) {
  return Query(
    options: QueryOptions(document: gql(query), variables: variables ),
    builder: (QueryResult result, {
      Refetch? refetch,
      FetchMore? fetchMore,
    }) {
      if (result.hasException && result.exception?.linkException is! CacheMissException) {
        // TODO: clear token from storage and redirect to splash if the response is unauthorized.
        return Text(result.exception.toString());
      }
      if (result.isLoading || result.data == null) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      return body(result.data!);
    },
  );
}