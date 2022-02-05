import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key, required this.refetch, required this.exception})
      : super(key: key);

  final Refetch? refetch;
  final OperationException exception;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade300,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                child: SvgPicture.asset("assets/icon/error.svg"),
                height: MediaQuery.of(context).size.height / 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                parseException(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xFF2B2D42)),
              ),
            ),
            ElevatedButton(onPressed: refetch, child: const Text("Try again"))
          ],
        ),
      ),
    );
  }

  String parseException() {
    if (exception.linkException != null &&
        exception.linkException?.originalException is SocketException) {
      if ((exception.linkException?.originalException as SocketException)
              .message ==
          "Failed host lookup: 'graphql.anilist.co'") {
        return "Oops... it looks like you're not connected to the internet. Check your connection.";
      }
    }
    return "Oops...a network error occured";
  }
}
