import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../packages/bmi_provider.dart';

class FoodDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> response;

  const FoodDetailsScreen(this.response, {Key? key}) : super(key: key);

  @override
  FoodDetailsScreenState createState() => FoodDetailsScreenState();
}

class FoodDetailsScreenState extends State<FoodDetailsScreen> {
  bool showSuggestedFood = false;

  @override
  Widget build(BuildContext context) {
    final foodData = widget.response['food_data'];
    final nearestRecipe = widget.response['nearest_recipe'];
    final similarFood = widget.response['similar_food_with_less_calories'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 6,
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        height: 300, // Adjust the height as needed
                        child: PageView.builder(
                          itemCount: foodData['Images'].length,
                          itemBuilder: (context, index) {
                            return Center(
                              child: Image.network(foodData['Images'][index]),
                            );
                          },
                        ),
                      ),
                      Container(
                        // margin: EdgeInsets.all(8.0),
                        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          '${foodData['Images'].length} Images',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          foodData['Name'],
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Food Content:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('Calories: ${foodData['foodContents']['Calories']}'),
                        Text('Carbohydrates: ${foodData['foodContents']['CarbohydrateContent']}'),
                        Text('Cholesterol: ${foodData['foodContents']['CholesterolContent']}'),
                        Text('Fat: ${foodData['foodContents']['FatContent']}'),
                        Text('Fiber: ${foodData['foodContents']['FiberContent']}'),
                        Text('Protein: ${foodData['foodContents']['ProteinContent']}'),
                        Text('Saturated Fat: ${foodData['foodContents']['SaturatedFatContent']}'),
                        Text('Sodium: ${foodData['foodContents']['SodiumContent']}'),
                        Text('Sugar: ${foodData['foodContents']['SugarContent']}'),
                        SizedBox(height: 10),
                        Text(
                          'Recipe Instructions:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        for (var instruction in foodData['RecipeInstructions'])
                          Text(instruction),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            if (similarFood != null) ...[
              if (!showSuggestedFood) Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showSuggestedFood = true;
                    });
                  },
                  child: const Text('View Suggestions'),
                ),
              ),
              if (showSuggestedFood) Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showSuggestedFood = false;
                    });
                  },
                  child: const Text('Close Suggestions'),
                ),
              ),
              const SizedBox(height: 5),
              if (showSuggestedFood) ...[
                const Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Text(
                    'Suggested Food',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Card(
                  elevation: 6,
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          SizedBox(
                            height: 300, // Adjust the height as needed
                            child: PageView.builder(
                              itemCount: similarFood['Images'].length,
                              itemBuilder: (context, index) {
                                return Center(
                                  child: Image.network(similarFood['Images'][index]),
                                );
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(8.0),
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              '${similarFood['Images'].length} Images',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              similarFood['Name'],
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Food Content:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('Calories: ${similarFood['foodContents']['Calories']}'),
                            Text('Carbohydrates: ${similarFood['foodContents']['CarbohydrateContent']}'),
                            Text('Cholesterol: ${similarFood['foodContents']['CholesterolContent']}'),
                            Text('Fat: ${similarFood['foodContents']['FatContent']}'),
                            Text('Fiber: ${similarFood['foodContents']['FiberContent']}'),
                            Text('Protein: ${similarFood['foodContents']['ProteinContent']}'),
                            Text('Saturated Fat: ${similarFood['foodContents']['SaturatedFatContent']}'),
                            Text('Sodium: ${similarFood['foodContents']['SodiumContent']}'),
                            Text('Sugar: ${similarFood['foodContents']['SugarContent']}'),
                            const SizedBox(height: 10),
                            const Text(
                              'Recipe Instructions:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            for (var instruction in similarFood['RecipeInstructions'])
                              Text(instruction),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]
            ]
          ],
        ),
      ),
    );
  }
}
