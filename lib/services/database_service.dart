import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/planner_model.dart';
import 'notification_service.dart';
import 'api_service.dart';
import 'dart:convert';

class DatabaseService extends ChangeNotifier {
  List<Planner> _planners = [];
  
  List<Planner> get planners => _planners;
  
  DatabaseService() {
    _loadPlanners();
  }
  
  Future<void> _loadPlanners() async {
    try {
      // Try API first
      _planners = await ApiService.getPlanners();
      notifyListeners();
    } catch (e) {
      // Fallback to local storage
      final prefs = await SharedPreferences.getInstance();
      final plannersJson = prefs.getStringList('planners') ?? [];
      _planners = plannersJson
          .map((json) => Planner.fromJson(jsonDecode(json)))
          .toList();
      notifyListeners();
    }
    
    // Schedule notifications for all planners
    _scheduleAllNotifications();
  }
  
  Future<void> addPlanner(Planner planner) async {
    _planners.add(planner);
    notifyListeners();
    
    // Save to local storage
    final prefs = await SharedPreferences.getInstance();
    final plannersJson = _planners.map((p) => jsonEncode(p.toJson())).toList();
    await prefs.setStringList('planners', plannersJson);
    
    // Try API sync
    try {
      await ApiService.addPlanner(planner);
    } catch (e) {
      print('Failed to sync with API: $e');
    }
    
    // Schedule notification
    if (planner.notificationEnabled) {
      await NotificationService().scheduleCookingNotification(
        id: planner.id,
        title: 'Waktunya Masak! 🍳',
        body: 'Jadwal masak "${planner.recipeTitle}" sudah tiba',
        schedule: planner.schedule,
      );
    }
  }
  
  Future<void> removePlanner(String id) async {
    _planners.removeWhere((planner) => planner.id == id);
    notifyListeners();
    
    // Update local storage
    final prefs = await SharedPreferences.getInstance();
    final plannersJson = _planners.map((p) => jsonEncode(p.toJson())).toList();
    await prefs.setStringList('planners', plannersJson);
    
    // Try API sync
    try {
      await ApiService.deletePlanner(id);
    } catch (e) {
      print('Failed to sync with API: $e');
    }
    
    // Cancel notification
    await NotificationService().cancelNotification(int.parse(id));
  }
  
  Future<void> toggleNotification(String id) async {
    final index = _planners.indexWhere((planner) => planner.id == id);
    if (index != -1) {
      _planners[index] = Planner(
        id: _planners[index].id,
        recipeId: _planners[index].recipeId,
        recipeTitle: _planners[index].recipeTitle,
        schedule: _planners[index].schedule,
        notificationEnabled: !_planners[index].notificationEnabled,
      );
      notifyListeners();
      
      // Update local storage
      final prefs = await SharedPreferences.getInstance();
      final plannersJson = _planners.map((p) => jsonEncode(p.toJson())).toList();
      await prefs.setStringList('planners', plannersJson);
      
      // Update notification
      if (_planners[index].notificationEnabled) {
        await NotificationService().scheduleCookingNotification(
          id: _planners[index].id,
          title: 'Waktunya Masak! 🍳',
          body: 'Jadwal masak "${_planners[index].recipeTitle}" sudah tiba',
          schedule: _planners[index].schedule,
        );
      } else {
        await NotificationService().cancelNotification(int.parse(id));
      }
    }
  }
  
  void _scheduleAllNotifications() {
    for (final planner in _planners) {
      if (planner.notificationEnabled && planner.schedule.isAfter(DateTime.now())) {
        NotificationService().scheduleCookingNotification(
          id: planner.id,
          title: 'Waktunya Masak! 🍳',
          body: 'Jadwal masak "${planner.recipeTitle}" sudah tiba',
          schedule: planner.schedule,
        );
      }
    }
  }
}