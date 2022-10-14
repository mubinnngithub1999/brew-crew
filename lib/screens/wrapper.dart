// ignore_for_file: avoid_print

import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'Home/home.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Userr?>(context);
    print(user);

    if (user == null) {
     return  const Authenticate();
    } else {
     return  Home();
    }

    
  }
}
