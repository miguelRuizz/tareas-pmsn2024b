import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:pmsn2024b/main.dart';
import 'package:pmsn2024b/provider/test_provider.dart';
import 'package:pmsn2024b/screens/login_screen.dart';
import 'package:pmsn2024b/screens/profile_screen.dart';
import 'package:pmsn2024b/screens/start_screen.dart';
import 'package:pmsn2024b/settings/colors_settings.dart';
import 'package:pmsn2024b/settings/global_values.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  final _key = GlobalKey<ExpandableFabState>();
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    TestProvider testProvider = Provider.of<TestProvider>(context);

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
      drawer: myDrawer(testProvider),
      body: IndexedStack(
        index: index,
        children: [
          Navigator(
            key: _navigatorKey,
            onGenerateRoute: (routeSettings) {
              return MaterialPageRoute(
                builder: (context) {
                  return StartScreen();
                },
              );
            },
          ),
          Navigator(
            onGenerateRoute: (routeSettings) {
              return MaterialPageRoute(
                builder: (context) {
                  return ProfileScreen();
                },
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react,
        backgroundColor: ColorsSettings.navColor,
        items: [
          TabItem(icon: Icons.home, title: 'Accueil'),
          TabItem(icon: Icons.person, title: 'Profil'),
          TabItem(icon: Icons.exit_to_app, title: 'Sortir'),
        ],
        onTap: (int i) {
          if (i == 2) { // Opción de salir
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          } else {
            setState(() {
              index = i;
              // Optionally pop to the root of the current Navigator
              _navigatorKey.currentState?.popUntil((route) => route.isFirst);
            });
          }
        },
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        key: _key,
        type: ExpandableFabType.up,
        children: [
          FloatingActionButton.small(
            heroTag: "btn1",
            onPressed: () {
              GlobalValues.flagDarkTheme.value = false;
            },
            child: Icon(Icons.light_mode),
          ),
          FloatingActionButton.small(
            heroTag: "btn2",
            onPressed: () {
              GlobalValues.flagDarkTheme.value = true;
            },
            child: Icon(Icons.dark_mode),
          ),
        ],
      ),
    );
  }

  Widget myDrawer(TestProvider testProvider) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('https://inaturalist-open-data.s3.amazonaws.com/photos/102241209/original.jpg'),
            ),
            accountName: Text(testProvider.name), 
            accountEmail: Text('pantroglodytes@itcelaya.edu.mx')
          ),
          ListTile(
            onTap: () => Navigator.pushNamed(context, '/db'),
            title: Text('Movies List'),
            subtitle: Text('CR7'),
            leading: Icon(Icons.movie),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            onTap: () => Navigator.pushNamed(context, '/popmovies'),
            title: Text('Popular Movies'),
            subtitle: Text('Messi'),
            leading: Icon(Icons.movie),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            onTap: () => Navigator.pushNamed(context, '/firebasemovies'),
            title: Text('Popular Movies Firebase'),
            subtitle: Text('Mbappe'),
            leading: Icon(Icons.movie),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            onTap: () => Navigator.pushNamed(context, '/gmaps'),
            title: Text('Gugul Maps'),
            subtitle: Text('Verstappen'),
            leading: Icon(Icons.map),
            trailing: Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
