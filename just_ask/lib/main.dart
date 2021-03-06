import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:just_ask/screens/JustAsk.dart';
import 'services/authenticator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Wrapper());
}

class Wrapper extends StatelessWidget {
  //A initialization Future for using Firebase in JustAsk. Resolves when app can interact with Firebase.
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          //Potential error connecting to Firebase
          if (snapshot.hasError) {
            return MaterialApp(
                home: Scaffold(body: Text('Something went wrong')));
          }

          //App was successfully connected to Firebase and we can display our app.
          if (snapshot.connectionState == ConnectionState.done) {
            Stream<User> userStateStream = Authenticator().userStateStream;
            return StreamProvider<User>.value(
              value: userStateStream,
              child: MaterialApp(
                title: 'JustAsk',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                home: JustAsk(),
              ),
            );
          }

          return MaterialApp(home: Scaffold(body: Text('Loading')));
        });
  }
}
