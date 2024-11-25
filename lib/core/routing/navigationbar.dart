// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// class ScaffoldWithNavigationCustoms extends StatefulWidget {
//   const ScaffoldWithNavigationCustoms(
//       {super.key, required this.navigatorShell});

//   final StatefulNavigationShell navigatorShell;

//   @override
//   // ignore: library_private_types_in_public_api
//   _ScaffoldWithNavigationCustomsState createState() =>
//       _ScaffoldWithNavigationCustomsState();
// }

// class _ScaffoldWithNavigationCustomsState
//     extends State<ScaffoldWithNavigationCustoms> {
//   int _selectedIndex = 0;

//   void _onBranch(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//     widget.navigatorShell.goBranch(
//       index,
//       initialLocation: index == widget.navigatorShell.currentIndex,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: widget.navigatorShell,
//       bottomNavigationBar: NavigationBar(
//         backgroundColor: const Color(0xfff7f7f7),
//         shadowColor: Colors.red[200],
//         selectedIndex: _selectedIndex,
//         onDestinationSelected: _onBranch,
//         destinations: const [
//           NavigationDestination(
//             icon: Icon(Icons.home),
//             label: "Home",
//             selectedIcon: Icon(Icons.home, color: const Color(0xffdb1e39)),
//           ),
//           NavigationDestination(
//             icon: Icon(Icons.history),
//             label: "History",
//             selectedIcon: Icon(Icons.history, color: Colors.red),
//           ),
//         ],
//       ),
//     );
//   }
// }
