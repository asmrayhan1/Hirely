import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hirely/core/service/auth_service.dart';
import 'package:hirely/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/extentions/image_path.dart';
import '../../feature/auth/login/view/login_screen.dart';
import '../containers/custom_image.dart';

class Logout extends StatefulWidget {
  const Logout({super.key});

  @override
  State<Logout> createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      color: Colors.white,
      icon: CustomImage(height: 28, width: 28, imagePath: ImagePath.more),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onSelected: (value) async {
        if (value == 1){
          setState(() {
            userEmail = null;
            userRole = null;
          });
          final prefs = await SharedPreferences.getInstance();
          await prefs.remove('email');
          await prefs.remove('role');
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
          await AuthServices().logout();
        }
        if (kDebugMode) {
          print("Selected: $value");
        }
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem<int>(
            value: 1,
            child: Column(
              children: [
                const SizedBox(height: 13),
                Row(
                  children: [
                    Icon(Icons.logout_outlined, size: 22),
                    SizedBox(width: 8),
                    Text("Logout", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                  ],
                ),
              ],
            ),
          ),
          PopupMenuItem<int>(
            value: 2,
            child: Column(
              children: [
                const Divider(color: Color(0xffe1e4ea)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    CustomImage(height: 22, width: 22, imagePath: ImagePath.cancel),
                    const SizedBox(width: 8),
                    const Text("Cancel", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                  ],
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ];
      },
      menuPadding: const EdgeInsets.all(0),
      padding: const EdgeInsets.all(0),
    );
  }
}
