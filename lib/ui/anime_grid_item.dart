import 'package:anisekai/details/details_arguments.dart';
import 'package:anisekai/models/media.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class AnimeGridItem extends StatelessWidget {
  const AnimeGridItem({Key? key, required this.anime}) : super(key: key);
  final Media anime;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: FadeInImage.memoryNetwork(
              image: anime.coverImage.large,
              fit: BoxFit.fill,
              width: 100,
              height: 150,
              placeholder: kTransparentImage,
            ),
          ),
          SizedBox(
              width: 100,
              child: Text(
                anime.title.english ?? anime.title.romaji,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ))
        ],
      ),
      onTap: () {
        Navigator.pushNamed(context, '/details', arguments: DetailsArguments(anime.id));
      },
    );
  }

}