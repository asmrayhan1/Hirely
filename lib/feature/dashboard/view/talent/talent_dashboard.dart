import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hirely/feature/home/view/home_screen.dart';
import 'package:hirely/feature/profile/view/profile_screen.dart';

import '../../../post/view_model/job_controller.dart';
import '../../../profile/view_model/user_controller.dart';

class TalentDashboard extends ConsumerStatefulWidget {
  const TalentDashboard({super.key});

  @override
  ConsumerState<TalentDashboard> createState() => _TalentDashboardState();
}

class _TalentDashboardState extends ConsumerState<TalentDashboard> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (kDebugMode) {
        print("index = $index");
      }
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ProfileScreen()
  ];

  Future<void> _refreshData() async {
    await ref.read(userProvider.notifier).userInitialize();
    await ref.read(jobProvider.notifier).jobInitialize();
    await Future.delayed(Duration(milliseconds: 200));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,//Color(0xFFF2F6FB),
      body: RefreshIndicator(
          onRefresh: _refreshData, backgroundColor: Color(0xFFF2F6FB),
          child: _widgetOptions.elementAt(_selectedIndex)
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // This will keep track of the selected index
        onTap: (int index){
          _onItemTapped(index);
        }, // Function to handle tap events
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xffF2F6FB), //Color(0xff17a38f),
        selectedItemColor: Color(0xff17a38f), //Colors.white,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(
          color: Color(0xff105866),  // Change text color for the selected label
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled, size: 25),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person, size: 25),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
