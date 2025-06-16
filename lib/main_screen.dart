import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String drinkName = "";
  String alcoholic = "";
  String image = "";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 138, 164, 160),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 138, 164, 160),
        title: Text('API Tasks'),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Cocktailname:"),
            isLoading ? CircularProgressIndicator() : SizedBox.shrink(),
            Text(drinkName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(height: 20),
            Text("mit oder ohne Alkohol?:"),
            isLoading ? CircularProgressIndicator() : SizedBox.shrink(),
            Text(alcoholic,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                )),
            SizedBox(height: 20),
            Image.network(image, height: 300, width: 300, fit: BoxFit.cover),
            isLoading ? CircularProgressIndicator() : SizedBox.shrink(),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                final response = await http.get(
                  Uri.parse(
                      "https://www.thecocktaildb.com/api/json/v1/1/random.php"),
                );
                String myJson = response.body;

                final Map<String, dynamic> myDrinks = jsonDecode(myJson);
                setState(() {
                  drinkName =
                      myDrinks["drinks"]?[0]?["strDrink"] ?? "No drink found";
                  alcoholic = myDrinks["drinks"]?[0]?["strAlcoholic"] ??
                      "No alcoholic information found";
                  image = myDrinks["drinks"]?[0]?["strDrinkThumb"] ??
                      "No image found";
                  isLoading = false;
                });
              },
              child: Text("click for new Cocktail"),
            )
          ],
        ),
      )),
    );
  }
}
