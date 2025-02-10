import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hirely/feature/auth/login/view/login_screen.dart';
import 'package:hirely/feature/dashboard/view/recruiter/recruiter_dashboard.dart';
import 'package:hirely/feature/dashboard/view/talent/talent_dashboard.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/service/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Supabase.initialize(
      url: 'https://cldryweohlzpfeteqesz.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNsZHJ5d2VvaGx6cGZldGVxZXN6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzg4NTIwMjAsImV4cCI6MjA1NDQyODAyMH0.YnAGa6qDLNUQTH2tz8cQ-gnv5vyMc1A8Xt23h7QjPic'
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: (AuthService().getCurrentUserEmail() != null? (AuthService().getCurrentUserRole() == true ? RecruiterDashboard() : TalentDashboard()) : LoginScreen()),
    );
  }
}