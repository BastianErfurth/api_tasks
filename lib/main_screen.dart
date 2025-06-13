import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<dynamic> myfruits = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Tasks'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Name: ${myfruits.isNotEmpty ? myfruits[1]["name"] : ""}'),
          Text('Family: ${myfruits.isNotEmpty ? myfruits[1]["family"] : ""}'),
          Text(
              'Kalorien: ${myfruits.isNotEmpty ? myfruits[1]["nutritions"]["calories"].toString() : ""}'),
          ElevatedButton(
            onPressed: () async {
              final response = await http.get(
                Uri.parse("https://www.fruityvice.com/api/fruit/all"),
              );
              String myJson = response.body;

              final List myFruits = jsonDecode(myJson);
              setState(() {
                myfruits = myFruits;
              });
              debugPrint(myfruits[1]["name"]);
              debugPrint(myfruits[1]["family"]);
              debugPrint(myfruits[1]["nutritions"]["calories"].toString());
            },
            child: Text("click"),
          )
        ],
      )),
    );
  }
}
