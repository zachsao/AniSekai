import 'dart:core';

import 'package:anisekai/details/anime_details_view.dart';
import 'package:anisekai/graphql/client_provider.dart';
import 'package:anisekai/graphql/query.dart';
import 'package:anisekai/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import 'discover/discover_view.dart';
import 'ui/custom_shape.dart';

void main() async {
  await initHiveForFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthenticationState(),
      child: ClientProvider(
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => const SplashPage(),
            DetailsPage.routeName: (context) => const DetailsPage(),
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> bottomNavItems = [
      const BottomNavigationBarItem(
          icon: Icon(Icons.home_filled), label: "Home"),
      const BottomNavigationBarItem(
          icon: Icon(Icons.remove_red_eye), label: "Watchlist"),
      const BottomNavigationBarItem(
          icon: Icon(Icons.explore), label: "Discover"),
      const BottomNavigationBarItem(
          icon: Icon(Icons.favorite), label: "Favorites"),
      const BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
    ];

    Widget buildFakePage() {
      return Container(
        color: const Color(0xFF2B2D42),
        child: Center(
          child: Text(
            "Current tab index: $_selectedIndex",
          ),
        ),
      );
    }

    List<Widget> pages = [
      buildFakePage(), buildFakePage(), const DiscoverPage(), buildFakePage(), buildFakePage()
    ];
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        elevation: 0,
        backgroundColor: const Color(0xFF2B2D42),
        flexibleSpace: ClipPath(
          clipper: Customshape(),
          child: Container(
            height: 250,
            width: MediaQuery.of(context).size.width,
            color: ThemeData.light().primaryColor,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 40.0, horizontal: 16.0),
              child: Text(
                bottomNavItems[_selectedIndex].label ?? "",
                style: const TextStyle(
                    fontSize: 36.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems,
        selectedItemColor: ThemeData.light().primaryColor,
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color(0xFF2B2D42),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
      body: pages[_selectedIndex]
    );
  }
}
