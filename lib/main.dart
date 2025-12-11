import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/recipe_detail_screen.dart';
import 'screens/video_tutorial_screen.dart';
import 'screens/planner_screen.dart';
import 'screens/search_result_screen.dart';
import 'services/notification_service.dart';
import 'services/database_service.dart';
import 'models/recipe_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize notifications
  await NotificationService().initNotifications();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DatabaseService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Resep Makanan App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        primaryColor: Colors.orange,
        useMaterial3: true,

        // AppBar Theme
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
        ),

        // ElevatedButton Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

        // TextButton Theme
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.orange,
          ),
        ),

        // Input Decoration Theme
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[50],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.orange, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
        ),

        // Card Theme - HAPUS CONST ATAU HAPUS SELURUHNYA
        // cardTheme: const CardTheme(
        //   elevation: 2,
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(12),
        //   ),
        // ),
      ),

      // Atur halaman awal ke Login
      initialRoute: '/login',

      // Daftarkan semua rute (Navigasi)
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/planner': (context) => PlannerScreen(), // HAPUS CONST
      },

      // Untuk handle routes dengan arguments
      onGenerateRoute: (settings) {
        // Handle recipe_detail route
        if (settings.name == '/recipe_detail') {
          final recipe = settings.arguments as Recipe;
          return MaterialPageRoute(
            builder: (context) => RecipeDetailScreen(recipe: recipe),
          );
        }
        
        // Handle video_tutorial route
        if (settings.name == '/video_tutorial') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => VideoTutorialScreen(
              videoUrl: args['videoUrl'],
              recipeTitle: args['recipeTitle'],
              recipe: args['recipe'],
            ),
          );
        }
        
        // Handle search_result route
        if (settings.name == '/search_result') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => SearchResultScreen(
              searchQuery: args['searchQuery'],
              recipes: args['recipes'],
            ),
          );
        }
        
        // Default fallback
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      },

      // Route untuk menangani halaman yang tidak ditemukan
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      },
    );
  }
}