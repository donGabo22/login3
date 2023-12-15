import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecipeDetailScreen2 extends StatefulWidget {
  final String mealId;

  RecipeDetailScreen2({required this.mealId});

  @override
  _RecipeDetailScreen2State createState() => _RecipeDetailScreen2State();
}

class _RecipeDetailScreen2State extends State<RecipeDetailScreen2> {
  Map<String, dynamic>? _mealDetails;

  @override
  void initState() {
    super.initState();
    _loadMealDetails();
  }

  void _loadMealDetails() async {
    final apiUrl = 'https://www.themealdb.com/api/json/v1/1/lookup.php?i=${widget.mealId}';
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> meals = data['meals'];

        if (meals.isNotEmpty) {
          setState(() {
            _mealDetails = meals[0];
          });
        }
      } else {
        print('Failed to load meal details. Status Code: ${response.statusCode}');
        print('Error body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meal Details"),
        backgroundColor: Colors.brown,
      ),
      body: _mealDetails != null
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    child: Image.network(
                      _mealDetails?['strMealThumb'] ?? '',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16.0),
                        Text(
                          'Meal Name: ${_mealDetails?['strMeal'] ?? ''}',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Category: ${_mealDetails?['strCategory'] ?? ''}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Area: ${_mealDetails?['strArea'] ?? ''}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Instructions: ${_mealDetails?['strInstructions'] ?? ''}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
