import 'package:anisekai/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptyResults extends StatelessWidget {
  const EmptyResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: SvgPicture.asset("assets/icon/void.svg"),
              height: MediaQuery.of(context).size.height / 4,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "No results found. \nTry another title.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: darkTheme.colorScheme.background, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

}