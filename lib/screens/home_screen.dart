import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/recipe_model.dart';
import '../widgets/recipe_card.dart';
import './recipe_detail_screen.dart';
import './planner_screen.dart';
import './search_result_screen.dart';
import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Recipe> _recipes = [];
  bool _isLoading = true;
  String _userName = 'Syahrul';

  @override
  void initState() {
    super.initState();
    _fetchRecipes();
  }

  Future<void> _fetchRecipes() async {
    try {
      final recipes = await ApiService.getRecipes();
      setState(() {
        _recipes = recipes;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching recipes: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Fungsi Pencarian
  List<Recipe> _searchRecipes(String query) {
    if (query.isEmpty) return _recipes;
    
    final lowerCaseQuery = query.toLowerCase();
    return _recipes.where((recipe) {
      return recipe.title.toLowerCase().contains(lowerCaseQuery) ||
             recipe.description.toLowerCase().contains(lowerCaseQuery) ||
             recipe.category.toLowerCase().contains(lowerCaseQuery);
    }).toList();
  }

  // Fungsi untuk handle pencarian
  void _handleSearch(String query) {
    if (query.trim().isNotEmpty) {
      final filteredRecipes = _searchRecipes(query);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchResultScreen(
            searchQuery: query,
            recipes: filteredRecipes,
          ),
        ),
      );
    }
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Logout'),
          content: const Text('Apakah Anda yakin ingin keluar?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Resep Masakan',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.orange,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today, color: Colors.white),
            tooltip: 'Planner',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PlannerScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            tooltip: 'Logout',
            onPressed: _showLogoutDialog,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Sapaan
          Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange.shade400, Colors.orange.shade600],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Halo, $_userName! 👋',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Mau masak apa hari ini?',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          
          // Search Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari resep (nama, bahan, kategori)',
                prefixIcon: const Icon(Icons.search, color: Colors.orange),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear, color: Colors.grey),
                  onPressed: () => _searchController.clear(),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              ),
              onSubmitted: _handleSearch,
            ),
          ),
          
          // Grid Resep
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator(color: Colors.orange))
                : _recipes.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.fastfood, size: 80, color: Colors.grey),
                            SizedBox(height: 16),
                            Text(
                              'Belum ada resep tersedia',
                              style: TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: _recipes.length,
                        itemBuilder: (context, index) {
                          return RecipeCard(
                            recipe: _recipes[index],
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RecipeDetailScreen(
                                    recipe: _recipes[index],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchRecipes,
        child: const Icon(Icons.refresh),
        backgroundColor: Colors.orange,
        tooltip: 'Refresh resep',
      ),
    );
  }
}