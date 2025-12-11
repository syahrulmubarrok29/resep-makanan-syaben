import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/planner_model.dart';
import '../services/database_service.dart';
import '../services/notification_service.dart';

class PlannerScreen extends StatefulWidget {
  @override
  _PlannerScreenState createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> {
  @override
  Widget build(BuildContext context) {
    final databaseService = Provider.of<DatabaseService>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Planner Masak'),
      ),
      body: databaseService.planners.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.calendar_today, size: 80, color: Colors.grey),
                  SizedBox(height: 20),
                  Text(
                    'Belum ada jadwal masak',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Tambahkan resep ke planner dari detail resep',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: databaseService.planners.length,
              itemBuilder: (context, index) {
                final planner = databaseService.planners[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Icon(Icons.restaurant_menu, color: Colors.white),
                    ),
                    title: Text(
                      planner.recipeTitle,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      DateFormat('dd MMM yyyy, HH:mm').format(planner.schedule),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            planner.notificationEnabled
                                ? Icons.notifications_active
                                : Icons.notifications_off,
                            color: planner.notificationEnabled
                                ? Colors.green
                                : Colors.grey,
                          ),
                          onPressed: () {
                            databaseService.toggleNotification(planner.id);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _showDeleteDialog(context, planner);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.add),
        label: Text('Tambah Resep'),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, Planner planner) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Hapus Jadwal'),
        content: Text('Yakin ingin menghapus jadwal "${planner.recipeTitle}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<DatabaseService>(context, listen: false)
                  .removePlanner(planner.id);
              Navigator.pop(context);
            },
            child: Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}