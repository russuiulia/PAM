import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'data/datasources/recipe_remote_datasource.dart';
import 'data/repositories/recipe_repository_impl.dart';
import 'presentation/controllers/recipe_controller.dart';
import 'presentation/pages/recipe_home_page.dart';

void main() {
  // Dependency injection
  final client = http.Client();
  final remoteDataSource = RecipeRemoteDataSourceImpl(client: client);
  final repository = RecipeRepositoryImpl(remoteDataSource: remoteDataSource);
  
  Get.put(RecipeController(repository: repository));
  
  runApp(const RecipeApp());
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Recipe App - Clean Architecture',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const RecipeHomePage(),
    );
  }
}