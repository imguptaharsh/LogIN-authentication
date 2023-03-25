import 'package:flutter/material.dart';
import './chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping app',
      // theme: ThemeData(
      //   primarySwatch: Colors.pink,
      //   backgroundColor: Colors.pink,
      //   accentColor: Colors.deepPurple,
      //   accentColorBrightness: Brightness.dark,
      //   buttonTheme: ButtonTheme.of(context).copyWith(
      //     buttonColor: Colors.pink,
      //     textTheme: ButtonTextTheme.primary,
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(20),
      //     ),
      //   ),
      // ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, userSnapshot) {
            if (userSnapshot.hasData) {
              return ChatScreen();
            }
            return AuthScreen();
          }),
    );
  }
}




// MaterialApp(
//     debugShowCheckedModeBanner: false,
//     initialRoute: 'loginAuth',
//     routes: {
//       // 'login': (context) => Login(),
//       // 'register': (context) => Register(),
//       'chatScreen': (context) => ChatScreen(),
//       // 'homepage': (context) => ShoppingApp(),
//       'loginAuth': (context) => AuthScreen(),
//     },
//   )