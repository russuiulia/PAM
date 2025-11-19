import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class RecipeRemoteDataSource {
  Future<Map<String, dynamic>> getFeed();
  Future<Map<String, dynamic>> getRecipeDetails();
}

class RecipeRemoteDataSourceImpl implements RecipeRemoteDataSource {
  final http.Client client;
  static const String baseUrl = 'https://test-api-jlbn.onrender.com/v2';

  RecipeRemoteDataSourceImpl({required this.client});

  @override
  Future<Map<String, dynamic>> getFeed() async {
    final response = await client.get(Uri.parse('$baseUrl/feed'));
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load feed');
    }
  }

  @override
  Future<Map<String, dynamic>> getRecipeDetails() async {
    final response = await client.get(Uri.parse('$baseUrl/feed/details'));
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load recipe details');
    }
  }
}
