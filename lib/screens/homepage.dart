import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restcipe/api_manager/api.dart';
import 'package:http/http.dart' as http;
import 'package:restcipe/models/recipe_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<RecipeModel> recipes = new List<RecipeModel>();
  TextEditingController searchController = new TextEditingController();
  String Id = appId;
  String appKey = APIkey;

  getRecipe(String query) async {
    String url =
        "https://api.edamam.com/search?q=$query&app_id=$appId&app_key=$APIkey";

    var response = await http.get(url);
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["hits"].forEach((element) {
      print(element.toString());
      RecipeModel recipeModel = new RecipeModel();
      recipeModel = RecipeModel.fromMap(element['recipe']);
      recipes.add(recipeModel);
    });
    print("${recipes.toString()}");
//    print("$response this is response");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: 24.0, bottom: 60.0, left: 24.0, right: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Row(
                    mainAxisAlignment: kIsWeb
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.center,
                    children: [
                      Text(
                        'Rest',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Cipe',
                        style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
                  SizedBox(
                    height: 40.0,
                  ),
                  Text(
                    ' What will you like to cook today?',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.yellowAccent),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "Enter any available ingredient, and get the best RestCipe tailored for you.",
                    style: TextStyle(
                        color: Colors.white, fontSize: 16.0, height: 1.3),
                  ),
                  SizedBox(
                    height: 32.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 40.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: 'Enter Ingredients',
                              hintStyle: TextStyle(color: Colors.white70),
                            ),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.yellow,
                          ),
                          child: IconButton(
                            color: Colors.teal,
                            icon: Icon(Icons.search, size: 24.0),
                            onPressed: () {
                              if (searchController.text.isNotEmpty) {
                                getRecipe(searchController.text);
                                print('Keep going');
                              } else {
                                print('Enter a text');
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RecipeTile extends StatelessWidget {

  String url, source, title, postUrl;
  RecipeTile({this.source,this.title, this.url, this.postUrl });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Image.network(url),

        ],
      ),
    );
  }
}

