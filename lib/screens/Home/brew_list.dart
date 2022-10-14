// ignore_for_file: avoid_print


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/models/brew.dart';
import 'brew_tile.dart';

class BrewList extends StatefulWidget {
  const BrewList({super.key});

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {


   final  brews =  Provider.of<List<Brew>?>(context) ?? [];



    // brews?.forEach((brew) {
    //   print(brew.name);
    //   print(brew.strength);
    //   print(brew.sugars);
    // });



  return ListView.builder(
        itemCount: brews.length,
        itemBuilder: (context, index)   {
         

          return  BrewTile(brew: brews[index]);

          
        });


  }
}




























// brews?.forEach((brew) {
    //   print(brew.name);
    //   print(brew.strength);
    //   print(brew.sugars);
    // });

    // print('888888888${brew.docs}');
    // for (var doc in brew!.docs) {
    //   print(doc.get('strength'));
    // }

    // for (var doc in brew!.docs) {
    //   print("${doc.id} => ${doc.data()}");
    // }