import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe_model.dart';
import '../models/planner_model.dart';

class ApiService {
  // Comment dulu URL API yang belum ada
  // static const String baseUrl = 'https://your-api-url.com/api';
  
  // GET - List resep (untuk rekomendasi)
  static Future<List<Recipe>> getRecipes() async {
    try {
      // Untuk development, langsung return dummy data
      // Tanpa HTTP request dulu
      return _getDummyRecipes();
      
      /* Comment dulu HTTP request
      final response = await http.get(Uri.parse('$baseUrl/recipes'));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Recipe.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load recipes');
      }
      */
    } catch (e) {
      print('API Error: $e');
      // Fallback data untuk development
      return _getDummyRecipes();
    }
  }
  
  // GET - List planner
  static Future<List<Planner>> getPlanners() async {
    try {
      // Untuk development, return empty list
      return [];
      
      /* Comment dulu
      final response = await http.get(Uri.parse('$baseUrl/planners'));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Planner.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load planners');
      }
      */
    } catch (e) {
      print('API Error: $e');
      return [];
    }
  }
  
  // POST - Tambah planner (simpan lokal dulu)
  static Future<bool> addPlanner(Planner planner) async {
    try {
      // Untuk development, langsung return true
      print('Planner added locally: ${planner.recipeTitle}');
      return true;
      
      /* Comment dulu
      final response = await http.post(
        Uri.parse('$baseUrl/planners'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(planner.toJson()),
      );
      
      return response.statusCode == 201;
      */
    } catch (e) {
      print('API Error: $e');
      return true; // Return true agar app tetap jalan
    }
  }
  
  // DELETE - Hapus planner
  static Future<bool> deletePlanner(String id) async {
    try {
      // Untuk development, langsung return true
      print('Planner deleted locally: $id');
      return true;
      
      /* Comment dulu
      final response = await http.delete(
        Uri.parse('$baseUrl/planners/$id'),
      );
      
      return response.statusCode == 200;
      */
    } catch (e) {
      print('API Error: $e');
      return true; // Return true agar app tetap jalan
    }
  }
  
  // Dummy data untuk development
  static List<Recipe> _getDummyRecipes() {
    return [
      Recipe(
        id: '1',
        title: 'Nasi Goreng Spesial',
        description: 'Nasi goreng dengan bumbu rempah khas Indonesia',
        imageUrl: 'https://images.unsplash.com/photo-1575936123452-b67c3203c357?w=400&h=300&fit=crop',
        ingredients: [
          'Nasi putih 2 piring',
          'Telur 2 butir',
          'Bawang merah 5 siung',
          'Kecap manis 2 sdm',
          'Garam secukupnya',
          'Minyak goreng 2 sdm',
          'Ayam suwir 100 gram',
          'Udang kupas 50 gram'
        ],
        steps: [
          'Panaskan minyak di wajan',
          'Tumis bawang merah hingga harum',
          'Masukkan telur, orak-arik hingga matang',
          'Tambahkan ayam suwir dan udang, aduk rata',
          'Masukkan nasi dan semua bumbu',
          'Aduk rata dan masak selama 5 menit',
          'Koreksi rasa dan sajikan panas'
        ],
        videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
        cookingTime: 20,
        difficulty: 'Mudah',
        category: 'Main Course',
      ),
      Recipe(
        id: '2',
        title: 'Rendang Sapi',
        description: 'Rendang dengan bumbu rempah yang kaya rasa',
        imageUrl: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=400&h=300&fit=crop',
        ingredients: [
          'Daging sapi 1 kg',
          'Santan kental 1 liter',
          'Bawang merah 10 siung',
          'Bawang putih 5 siung',
          'Kemiri 5 butir',
          'Kunyit 2 cm',
          'Jahe 2 cm',
          'Lengkuas 3 cm',
          'Daun jeruk 5 lembar',
          'Sereh 2 batang',
          'Garam 2 sdt',
          'Gula merah 50 gram'
        ],
        steps: [
          'Haluskan semua bumbu kecuali daun jeruk dan sereh',
          'Tumis bumbu halus hingga harum',
          'Masukkan daging sapi, aduk hingga berubah warna',
          'Tuangkan santan sedikit demi sedikit',
          'Masukkan daun jeruk dan sereh yang sudah digeprek',
          'Masak dengan api kecil selama 2-3 jam hingga kuah menyusut',
          'Aduk sesekali agar tidak gosong',
          'Masak hingga daging empuk dan bumbu meresap'
        ],
        videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
        cookingTime: 180,
        difficulty: 'Sulit',
        category: 'Main Course',
      ),
      Recipe(
        id: '3',
        title: 'Soto Ayam Lamongan',
        description: 'Soto ayam dengan kuah bening khas Lamongan',
        imageUrl: 'https://images.unsplash.com/photo-1563379091339-03246963d9d6?w=400&h=300&fit=crop',
        ingredients: [
          'Ayam 1 ekor',
          'Bihun 200 gram',
          'Tauge 100 gram',
          'Kol 100 gram',
          'Bawang merah 8 siung',
          'Bawang putih 5 siung',
          'Kemiri 4 butir',
          'Kunyit 2 cm',
          'Jahe 2 cm',
          'Daun salam 3 lembar',
          'Sereh 2 batang',
          'Garam 2 sdt',
          'Kaldu ayam 1 sdt'
        ],
        steps: [
          'Rebus ayam hingga matang, suwir-suwir',
          'Haluskan bumbu: bawang merah, bawang putih, kemiri, kunyit, jahe',
          'Tumis bumbu halus hingga harum',
          'Masukkan daun salam dan sereh',
          'Tuang air kaldu ayam, didihkan',
          'Masukkan garam dan kaldu ayam bubuk',
          'Siapkan bihun, tauge, dan kol dalam mangkuk',
          'Tuang kuah soto panas, tambahkan suwiran ayam',
          'Sajikan dengan sambal dan jeruk nipis'
        ],
        videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
        cookingTime: 60,
        difficulty: 'Sedang',
        category: 'Soup',
      ),
      Recipe(
        id: '4',
        title: 'Martabak Manis',
        description: 'Martabak manis tebal dengan topping beragam',
        imageUrl: 'https://images.unsplash.com/photo-1563729784474-d77dbb933a9e?w=400&h=300&fit=crop',
        ingredients: [
          'Tepung terigu 250 gram',
          'Gula pasir 100 gram',
          'Telur 2 butir',
          'Soda kue 1 sdt',
          'Ragi instan 1 sdt',
          'Santan 200 ml',
          'Air 100 ml',
          'Margarin untuk olesan',
          'Keju parut untuk topping',
          'Kacang tanah sangrai',
          'Susu kental manis'
        ],
        steps: [
          'Campur tepung, gula, telur, soda kue, dan ragi',
          'Tuang santan dan air sedikit demi sedikit, aduk hingga licin',
          'Diamkan adonan selama 1 jam hingga mengembang',
          'Panaskan cetakan martabak, olesi dengan minyak',
          'Tuang adonan, masak dengan api kecil',
          'Taburi gula pasir saat permukaan mulai berlubang',
          'Tutup cetakan, masak hingga matang',
          'Olesi dengan margarin, beri topping keju dan kacang',
          'Siram dengan susu kental manis, lipat dan potong-potong'
        ],
        videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
        cookingTime: 40,
        difficulty: 'Sedang',
        category: 'Dessert',
      ),
      Recipe(
        id: '5',
        title: 'Es Teh Manis',
        description: 'Es teh segar dengan lemon',
        imageUrl: 'https://images.unsplash.com/photo-1561047029-3000c68339ca?w=400&h=300&fit=crop',
        ingredients: [
          'Teh celup 3 buah',
          'Gula pasir 100 gram',
          'Air panas 500 ml',
          'Es batu secukupnya',
          'Lemon 1 buah',
          'Daun mint untuk hiasan'
        ],
        steps: [
          'Seduh teh celup dengan air panas selama 5 menit',
          'Tambahkan gula pasir, aduk hingga larut',
          'Dinginkan teh di lemari es',
          'Siapkan gelas, isi dengan es batu',
          'Tuang teh yang sudah dingin',
          'Tambahkan perasan lemon',
          'Hias dengan daun mint dan irisan lemon',
          'Sajikan segera'
        ],
        videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
        cookingTime: 10,
        difficulty: 'Mudah',
        category: 'Minuman',
      ),
      Recipe(
        id: '6',
        title: 'Salad Buah Segar',
        description: 'Salad buah dengan yogurt dan madu',
        imageUrl: 'https://images.unsplash.com/photo-1519996529931-28324d5a630e?w=400&h=300&fit=crop',
        ingredients: [
          'Apel 1 buah',
          'Anggur 100 gram',
          'Stroberi 100 gram',
          'Kiwi 2 buah',
          'Pisang 1 buah',
          'Yogurt plain 200 ml',
          'Madu 2 sdm',
          'Keju parut 50 gram'
        ],
        steps: [
          'Cuci bersih semua buah',
          'Potong dadu apel, kiwi, dan pisang',
          'Belah anggur dan stroberi menjadi dua',
          'Campur semua buah dalam mangkuk besar',
          'Dalam mangkuk terpisah, campur yogurt dan madu',
          'Tuang saus yogurt ke atas buah, aduk rata',
          'Taburi dengan keju parut',
          'Dinginkan di kulkas selama 30 menit sebelum disajikan'
        ],
        videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
        cookingTime: 15,
        difficulty: 'Mudah',
        category: 'Dessert',
      ),
    ];
  }
}