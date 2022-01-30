import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

Query buildQuery(String query, Widget Function(Map<String, dynamic>, Refetch?) body, {Map<String, dynamic> variables = const {}}) {
  return Query(
    options: QueryOptions(document: gql(query), variables: variables, fetchPolicy: FetchPolicy.networkOnly, cacheRereadPolicy: CacheRereadPolicy.ignoreAll),
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

      try {
        return body(result.data!, refetch);
      } on Exception catch (e) {
        print(e);
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}

Mutation buildMutation(String mutation, Widget Function(Map<String, dynamic>?, RunMutation) body, {Map<String, dynamic> variables = const {}}) {
  return
    Mutation(
      options: MutationOptions(document: gql(mutation), fetchPolicy: FetchPolicy.networkOnly, cacheRereadPolicy: CacheRereadPolicy.ignoreAll),
      builder: (RunMutation runMutation, QueryResult? result) {
        return body(result?.data, runMutation);
      },
    );
}