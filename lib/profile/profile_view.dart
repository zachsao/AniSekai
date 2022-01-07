import 'package:anisekai/graphql/operations.dart';
import 'package:anisekai/models/user.dart';
import 'package:anisekai/profile/profile_query.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF2B2D42),
      child: buildProfilePage(context),
    );
  }

  Widget buildProfilePage(BuildContext context) {
    return buildQuery(profileQuery, (data) {
      User user = UserModel.fromJson(data).user;
      return Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 4 + 60,
            child: Stack(
              children: [
                FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: user.bannerImage ??
                      "https://via.placeholder.com/1600x400?text=Banner+unavailable",
                  height: MediaQuery.of(context).size.height / 4,
                  fit: BoxFit.cover,
                  placeholderCacheHeight: MediaQuery.of(context).size.height ~/ 4,
                  placeholderFit: BoxFit.cover,
                ),
                Positioned(
                  left: (MediaQuery.of(context).size.width/2) - 50,
                  top: MediaQuery.of(context).size.height / 4 - 50,
                  child: Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 3), color: const Color(0xFF2B2D42), borderRadius: BorderRadius.circular(10)),
                    child: Image(
                      image: NetworkImage(user.avatar!.large),
                      fit: BoxFit.fill,
                      height: 100,
                      width: 100,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(user.name!, style: const TextStyle(color: Colors.white, fontSize: 18),),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(user.about ?? "Write something about you", style: const TextStyle(color: Colors.white), textAlign: TextAlign.center,),
          )
        ],
      );
    });
  }
}
