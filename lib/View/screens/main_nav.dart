import 'package:adaptive_navigation_widget/adaptive_navigation_widget.dart';
import 'package:flutter/material.dart';
import 'package:salakhana_project/View/screens/habits.dart';
import 'package:salakhana_project/View/screens/home.dart';
import 'package:salakhana_project/View/screens/login.dart';

class MainNav extends StatefulWidget {
  final String userEmail;

  const MainNav({super.key, required this.userEmail});

  @override
  State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int index = 0;

  // =========================
  // NAVIGATION DESTINATIONS
  // =========================
  final List<AdaptiveDestination> destinations = const [
    AdaptiveDestination(
      initialPath: "/tasks",
      icon: Icon(Icons.checklist),
      selectedIcon: Icon(
        Icons.checklist_outlined,
        color: Colors.purple,
      ),
      label: "Tasks",
    ),
    AdaptiveDestination(
      initialPath: "/habits",
      icon: Icon(Icons.repeat),
      selectedIcon: Icon(
        Icons.repeat_on,
        color: Colors.purple,
      ),
      label: "Habits",
    ),
    AdaptiveDestination(
      initialPath: "/login",
      icon: Icon(Icons.login_outlined),
      selectedIcon: Icon(
        Icons.login,
        color: Colors.purple,
      ),
      label: "Login",
    ),
  ];

  // =========================
  // BUILD PAGES (IMPORTANT)
  // =========================
  List<Widget> buildPages() {
    return [
      Home(userEmail: widget.userEmail),
      Habits(userEmail: widget.userEmail),
      const Test(), // Login screen
    ];
  }

  @override
  Widget build(BuildContext context) {
    // If login tab selected → show login ONLY (no nav)
    if (index == 2) {
      return const Test();
    }

    return AdaptiveNavigation(
      destinations: destinations,

      backgroundColor: Colors.purple[400],

      navigationTypeResolver: (context) {
        if (MediaQuery.of(context).size.width < 600) {
          return NavigationType.bottom;
        } else if (MediaQuery.of(context).size.width < 1024) {
          return NavigationType.rail;
        } else {
          return NavigationType.drawer;
        }
      },

      appBar: AppBar(
        backgroundColor: Colors.purple[400],
        //center the title
        centerTitle: true,
        title: Text(destinations[index].label, style: TextStyle(color: Colors.white),),
      ),

      onDestinationChanged: (context, location, newIndex) {
        setState(() {
          index = newIndex;
        });
      },

      child: IndexedStack(
        index: index,
        children: buildPages(),
      ),
    );
  }
}