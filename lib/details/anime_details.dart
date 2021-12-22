import 'dart:core';

import 'package:anisekai/details/details_arguments.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key}) : super(key: key);

  static const routeName = "/details";

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as DetailsArguments;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("anime id: ${args.id}"),
            ElevatedButton(
              onPressed: () { Navigator.pop(context);},
              child: const Text("Go back"),
            ),
          ],
        ),
      )
    );
  }
}
