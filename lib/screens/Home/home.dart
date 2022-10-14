// ignore_for_file: empty_statements, no_leading_underscores_for_local_identifiers, unused_element

import 'package:brew_crew/screens/Home/settings.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/database.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/models/brew.dart';
import '../../models/user.dart';
import 'brew_list.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Userr>(context);


    void _showSettingspanel() {
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: const SettingsForm(),
          );
        },
      );
    }

    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService(uid: user.uid).brews,
      initialData: null,
      child: Scaffold(
       resizeToAvoidBottomInset: false,
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          title: const Text('Brew Crew'),
          elevation: 0,
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                await _auth.signOut();
              },
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.black)),
              child: Row(
                children: const [
                  Icon(Icons.person),
                  SizedBox(
                    width: 1,
                  ),
                  Text('Logout'),
                ],
              ),
            ),
            TextButton(
              onPressed: () => _showSettingspanel(),
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.black)),
              child: Row(
                children: const [
                  Icon(Icons.settings),
                  SizedBox(
                    width: 1,
                  ),
                  Text('Settings'),
                ],
              ),
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('asset/coffee_bg.png'),
              fit: BoxFit.cover)
           ),
          
          child: const BrewList()),
      ),
    );
  }
}
