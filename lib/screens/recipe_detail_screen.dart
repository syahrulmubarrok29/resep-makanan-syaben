import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/recipe_model.dart';
import '../models/planner_model.dart';
import '../services/database_service.dart';
import 'video_tutorial_screen.dart';
import '../utils/constants.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({Key? key, required this.recipe}) : super(key: key);

  void _addToPlanner(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    ).then((selectedDate) {
      if (selectedDate != null) {
        showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        ).then((selectedTime) {
          if (selectedTime != null) {
            final schedule = DateTime(
              selectedDate.year,
              selectedDate.month,
              selectedDate.day,
              selectedTime.hour,
              selectedTime.minute,
            );
            
            final planner = Planner(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              recipeId: recipe.id,
              recipeTitle: recipe.title,
              schedule: schedule,
              notificationEnabled: true,
            );
            
            Provider.of<DatabaseService>(context, listen: false)
                .addPlanner(planner);
            
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Resep ditambahkan ke planner!'),
                backgroundColor: Colors.green,
              ),
            );
          }
        });
      }
    });
  }

  Widget _buildInfoChip(IconData icon, String text, Color color) {
    return Chip(
      avatar: Icon(icon, size: 16, color: color),
      label: Text(text),
      backgroundColor: color.withOpacity(0.1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Resep
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(recipe.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            
            // Informasi Resep
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    recipe.description,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 16),
                  
                  // Info Cooking Time & Difficulty
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildInfoChip(
                        Icons.timer,
                        '${recipe.cookingTime} menit',
                        Colors.blue,
                      ),
                      _buildInfoChip(
                        Icons.bar_chart,
                        recipe.difficulty,
                        Colors.orange,
                      ),
                      _buildInfoChip(
                        Icons.category,
                        recipe.category,
                        Colors.purple,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Tombol Video Tutorial
                  if (recipe.videoUrl.isNotEmpty)
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoTutorialScreen(
                              videoUrl: recipe.videoUrl,
                              recipeTitle: recipe.title,
                              recipe: recipe,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.videocam),
                      label: const Text('Tonton Video Tutorial'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Colors.orange,
                      ),
                    ),
                  
                  const SizedBox(height: 16),
                  
                  // Tombol Tambah ke Planner
                  ElevatedButton.icon(
                    onPressed: () => _addToPlanner(context),
                    icon: const Icon(Icons.calendar_today),
                    label: const Text('Tambah ke Planner'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.green,
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Bahan-bahan
                  const Text(
                    'Bahan-bahan:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...recipe.ingredients.map((ingredient) => 
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('• ', style: TextStyle(fontSize: 16)),
                          Expanded(
                            child: Text(
                              ingredient,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Langkah-langkah
                  const Text(
                    'Langkah-langkah:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...recipe.steps.asMap().entries.map((entry) => 
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${entry.key + 1}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              entry.value,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
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