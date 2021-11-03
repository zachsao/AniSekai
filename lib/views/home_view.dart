import 'dart:core';

import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: const Color(0xFF2B2D42),
      child: ListView.builder(
          padding: const EdgeInsets.only(top: 8),
          itemCount: 3,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: buildListItem("Title", 75, "958",
                    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
              ),
            );
          }),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
    );
  }

  Widget buildListItem(
      String title, double progress, String nextEpisode, String imgUrl) {
    return Stack(fit: StackFit.expand, children: [
      Image(
        image: NetworkImage(imgUrl),
        fit: BoxFit.cover,
        color: const Color.fromRGBO(255, 255, 255, 0.3),
        colorBlendMode: BlendMode.modulate,
      ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            Text(
              title,
              style: const TextStyle(
                  color: Color(0xFF2B2D42),
                  fontSize: 36,
                  fontWeight: FontWeight.bold),
            ),
            const Spacer(flex: 1),
            Row(
              children: [
                const Spacer(),
                Stack(alignment: Alignment.center, children: [
                  const SizedBox(
                    width: 80,
                    height: 80,
                    child: CircularProgressIndicator(
                      value: 0.75,
                      color: Color(0xFF347DEA),
                    ),
                  ),
                  Column(
                    children: [
                      Text("${progress.toInt()}%",
                          style: const TextStyle(
                              color: Color(0xFF2B2D42),
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      const Text("Complete",
                          style: TextStyle(
                              color: Color(0xFF2B2D42),
                              fontSize: 12,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ]),
                const Spacer(),
                Column(
                  children: [
                    const Text("Next Episode:",
                        style: TextStyle(
                            color: Color(0xFF2B2D42),
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                    Text(nextEpisode,
                        style: const TextStyle(
                            color: Color(0xFF2B2D42),
                            fontSize: 18,
                            fontWeight: FontWeight.bold))
                  ],
                ),
                const Spacer(),
              ],
            ),
            const Spacer(flex: 2)
          ],
        ),
      ),
    ]);
  }
}
