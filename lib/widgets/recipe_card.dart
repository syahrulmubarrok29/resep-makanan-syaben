import 'package:flutter/material.dart';
import '../models/recipe_model.dart';
import '../utils/constants.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onTap;

  const RecipeCard({
    required this.recipe,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Resep
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                image: DecorationImage(
                  image: NetworkImage(recipe.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            
            // Konten
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                  SizedBox(height: 4),
                  Text(
                    recipe.description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  
                  // Badge Info
                  Row(
                    children: [
                      Chip(
                        label: Text('${recipe.cookingTime} min'),
                        backgroundColor: Colors.green[50],
                        labelStyle: TextStyle(fontSize: 10),
                      ),
                      SizedBox(width: 4),
                      Chip(
                        label: Text(recipe.difficulty),
                        backgroundColor: Colors.blue[50],
                        labelStyle: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}