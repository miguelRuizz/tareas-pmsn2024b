import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:pmsn2024b/screens/login_screen.dart';
import 'package:pmsn2024b/screens/profile_screen.dart';
import 'package:pmsn2024b/screens/start_screen.dart';
import 'package:pmsn2024b/settings/colors_settings.dart';
import 'package:pmsn2024b/settings/global_values.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  final _key = GlobalKey<ExpandableFabState>();

  // final List<Widget> _pages = [
  //   StartScreen(),
  //   ProfileScreen(),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsSettings.navColor,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.access_alarm_outlined)),
          GestureDetector(
            onTap: () {},
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Image.asset('assets/apeicon.png'),
            ),
          ),
        ],
      ),
      drawer: Drawer(),
      //body: _pages[_currentIndex],
      body: Builder(builder: (context) {
        switch (index) {
          case 0:
            return StartScreen();
          case 1:
            return ProfileScreen();
          default:
            return StartScreen();
        }
      }),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react,
        backgroundColor: ColorsSettings.navColor,
        items: [
          TabItem(icon: Icons.home, title: 'Accueil'),
          TabItem(icon: Icons.person, title: 'Profil'),
          TabItem(icon: Icons.exit_to_app, title: 'Sortir'),
        ],
        onTap: (int i) => setState(() {
          index = i;
        }),
        // initialActiveIndex: _currentIndex,
        // onTap: (int i) {
        //   if (i == 2) { // Opción de salir, quita la convexbar
        //     Navigator.pushReplacement(
        //       context,
        //       MaterialPageRoute(builder: (context) => LoginScreen()),
        //     );
        //   } else {
        //     setState(() {
        //       _currentIndex = i;
        //     });
        //   }
        // },
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        key: _key,
        type: ExpandableFabType.up,
        children: [
          FloatingActionButton.small(
            onPressed: (){
              GlobalValues.flagDarkTheme.value = false;
            },
            child: Icon(Icons.light_mode),
            ),
          FloatingActionButton.small(
            onPressed: (){
              GlobalValues.flagDarkTheme.value = true;
            },
            child: Icon(Icons.dark_mode),
            )
        ],
      ),
    );
  }
}
