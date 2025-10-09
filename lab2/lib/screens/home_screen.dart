// import 'package:flutter/material.dart';
// import '../models/recipe.dart';
// import '../widgets/recipe_card.dart';
// import 'recipe_detail_screen.dart';

// class HomeScreen extends StatelessWidget {
//   final List<Recipe> recipes = [
//     Recipe(
//       title: "Classic Greek Salad",
//       image: "assets/salad.jpg",
//       rating: 4.5,
//       time: "15 Mins",
//       author: "Laura Wilson",
//       location: "Lagos, Nigeria",
//       ingredients: [
//         {"Tomatos": "500g"},
//         {"Cabbage": "300g"},
//         {"Taco": "300g"},
//         {"Slice Bread": "300g"},
//       ],
//     ),
//     Recipe(
//       title: "Crunchy Nut Coleslaw",
//       image: "assets/coleslaw.jpg",
//       rating: 3.5,
//       time: "10 Mins",
//       author: "James Milner",
//       location: "London, UK",
//       ingredients: [
//         {"Cabbage": "400g"},
//         {"Carrots": "250g"},
//         {"Mayonnaise": "100g"},
//       ],
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         title: const Text(
//           'Hello Jega',
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           const Text(
//             "New Recipes",
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 12),
//           SizedBox(
//             height: 230,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: recipes.length,
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => RecipeDetailScreen(recipe: recipes[index]),
//                       ),
//                     );
//                   },
//                   child: RecipeCard(recipe: recipes[index]),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

