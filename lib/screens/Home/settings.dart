// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/louding.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constant.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formkey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  // form values
  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Userr>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userdata = snapshot.data;
            return Form(
              key: _formkey,
              child: Column(
                children: [
                  const Text(
                    'Update your brew settings',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userdata?.name,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val == '' ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  DropdownButtonFormField(
                    value: _currentSugars ?? userdata?.sugars,
                    decoration: textInputDecoration,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text(
                          '$sugar sugars',
                          style: const TextStyle(fontSize: 13),
                        ),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentSugars = val),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 23,
                        child: Text('Strength of Coffe'),
                      ),
                      Slider(
                        value: (_currentStrength ?? userdata?.strength)!
                            .toDouble(),
                        activeColor: Colors
                            .brown[_currentStrength ?? userdata!.strength],
                        inactiveColor: Colors
                            .brown[_currentStrength ?? userdata!.strength],
                        min: 100.0,
                        max: 900.0,
                        divisions: 8,
                        label: _currentStrength?.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            _currentStrength = value.round();
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextButton(
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                            _currentSugars ?? userdata!.sugars,
                            _currentName ?? userdata!.name,
                            _currentStrength ?? userdata!.strength);
                        Navigator.pop(context);
                      }
                      
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.pink[400])),
                    child: const Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Louding();
          }
        });
  }
}
