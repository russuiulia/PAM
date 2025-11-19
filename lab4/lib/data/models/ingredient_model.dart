import '../../domain/entities/ingredient.dart';

class IngredientModel extends Ingredient {
  IngredientModel({
    required super.id,
    required super.name,
    required super.quantity,
    required super.icon,
  });

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    return IngredientModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      quantity: json['quantity'] ?? '',
      icon: json['icon'] ?? '',
    );
  }
}