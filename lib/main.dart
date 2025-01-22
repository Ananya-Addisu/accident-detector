import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_hack/Screens/add_Contact.dart';
import 'package:supabase_hack/Screens/graph_page.dart';
// import 'package:supabase_hack/screens/home_screen.dart';

import './splash_scren.dart';
import './auth/login_page.dart';
import './auth/account_page.dart';
import 'Screens/home_screen.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://bctvroarauosabudzdlu.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJjdHZyb2FyYXVvc2FidWR6ZGx1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODQ2OTUzOTUsImV4cCI6MjAwMDI3MTM5NX0.p3MDRwElSNPXrZlfRN7qVxBJ7yAHKSAWM5lfxq78DkI',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  List help = [];

  changeStateAlias(String email, String alias) {
    help.add({'email': email, 'alias': alias});
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Accident Detector',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.green,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.green,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
          ),
        ),
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (_) =>  const SplashPage(),
        '/login': (_) =>  const HomePage(),
        '/home': (_) =>  const HomePage(),
        '/add': (_) =>  AddContact(change: changeStateAlias),
        '/graph': (_) =>  Graph(),
      },
    );
  }
}
