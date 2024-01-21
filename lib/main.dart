import 'package:flutter/material.dart';
import 'package:flutter_challenge_coffee_app_3d_effect/coffee_concept/coffee_concept_app.dart';
import 'package:flutter_challenge_coffee_app_3d_effect/coffee_concept/coffee_concept_home.dart';
import 'package:flutter_challenge_coffee_app_3d_effect/coffee_concept/coffee_concept_list.dart';

import 'coffee_concept/coffee_concept_list_remake.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: CoffeeConceptHome() ,
    );
  }
}
