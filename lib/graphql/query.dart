import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

Query buildQuery(String query, BuildContext context, Widget Function(Map<String, dynamic> data) body) {
  return Query(
    options: QueryOptions(document: gql(query)),
    builder: (QueryResult result, {
      Refetch? refetch,
      FetchMore? fetchMore,
    }) {
      if (result.hasException) {
        return Text(result.exception.toString());
      }
      if (result.isLoading) {
        return const Center(child: CircularProgressIndicator(),);
      }

      return body(result.data!);
    },
  );
}