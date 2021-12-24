import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

Query buildQuery(String query, BuildContext context, Widget Function(Map<String, dynamic>) body, {Map<String, dynamic> variables = const {}}) {
  return Query(
    options: QueryOptions(document: gql(query), variables: variables ),
    builder: (QueryResult result, {
      Refetch? refetch,
      FetchMore? fetchMore,
    }) {
      // if (result.hasException) {
      //   return Text(result.exception.toString());
      // } TODO: handle errors
      if (result.isLoading || result.data == null) {
        return const Center(child: CircularProgressIndicator(),);
      }

      return body(result.data!);
    },
  );
}