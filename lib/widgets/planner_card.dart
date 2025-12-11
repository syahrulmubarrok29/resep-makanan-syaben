import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/planner_model.dart';
import '../utils/helpers.dart';
import '../utils/constants.dart';

class PlannerCard extends StatelessWidget {
  final Planner planner;
  final VoidCallback onDelete;
  final VoidCallback onToggleNotification;
  final VoidCallback? onTap;

  const PlannerCard({
    Key? key,
    required this.planner,
    required this.onDelete,
    required this.onToggleNotification,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timeColor = Helpers.getTimeColor(planner.schedule);
    final timeIcon = _getTimeIcon(planner.schedule);
    
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header dengan judul dan menu
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      planner.recipeTitle,
                      style: AppConstants.heading3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  PopupMenuButton<String>(
                    icon: Icon(Icons.more_vert),
                    onSelected: (value) {
                      if (value == 'delete') {
                        onDelete();
                      } else if (value == 'notification') {
                        onToggleNotification();
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'notification',
                        child: Row(
                          children: [
                            Icon(
                              planner.notificationEnabled
                                  ? Icons.notifications_off
                                  : Icons.notifications_active,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 8),
                            Text(
                              planner.notificationEnabled
                                  ? 'Matikan Notifikasi'
                                  : 'Nyalakan Notifikasi',
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Hapus Jadwal', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              SizedBox(height: 12),
              
              // Info Waktu
              Row(
                children: [
                  Icon(Icons.access_time, color: timeColor, size: 18),
                  SizedBox(width: 8),
                  Text(
                    Helpers.formatDate(planner.schedule),
                    style: TextStyle(
                      fontSize: 14,
                      color: timeColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 8),
              
              // Status waktu
              Row(
                children: [
                  Icon(timeIcon, size: 16, color: timeColor),
                  SizedBox(width: 4),
                  Text(
                    _getTimeStatus(planner.schedule),
                    style: TextStyle(
                      fontSize: 12,
                      color: timeColor,
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 16),
              
              // Footer dengan notifikasi status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Status notifikasi
                  Row(
                    children: [
                      Icon(
                        planner.notificationEnabled
                            ? Icons.notifications_active
                            : Icons.notifications_off,
                        size: 16,
                        color: planner.notificationEnabled
                            ? AppConstants.primaryColor
                            : Colors.grey,
                      ),
                      SizedBox(width: 4),
                      Text(
                        planner.notificationEnabled
                            ? 'Notifikasi aktif'
                            : 'Notifikasi nonaktif',
                        style: TextStyle(
                          fontSize: 12,
                          color: planner.notificationEnabled
                              ? AppConstants.primaryColor
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  
                  // Countdown (jika masih lama)
                  if (planner.schedule.isAfter(DateTime.now()))
                    _buildCountdown(planner.schedule),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCountdown(DateTime schedule) {
    final now = DateTime.now();
    final difference = schedule.difference(now);
    
    String countdownText;
    
    if (difference.inDays > 0) {
      countdownText = '${difference.inDays} hari lagi';
    } else if (difference.inHours > 0) {
      countdownText = '${difference.inHours} jam lagi';
    } else if (difference.inMinutes > 0) {
      countdownText = '${difference.inMinutes} menit lagi';
    } else {
      countdownText = 'Segera';
    }
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppConstants.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        countdownText,
        style: TextStyle(
          fontSize: 12,
          color: AppConstants.primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _getTimeStatus(DateTime schedule) {
    final now = DateTime.now();
    final difference = schedule.difference(now);
    
    if (difference.inMinutes <= 0) {
      return 'Waktu sudah lewat';
    } else if (difference.inMinutes <= 30) {
      return 'Kurang dari 30 menit';
    } else if (difference.inHours <= 1) {
      return 'Kurang dari 1 jam';
    } else if (difference.inHours <= 24) {
      return 'Hari ini';
    } else if (difference.inDays <= 7) {
      return 'Minggu ini';
    } else {
      return 'Masih lama';
    }
  }

  IconData _getTimeIcon(DateTime schedule) {
    final now = DateTime.now();
    final difference = schedule.difference(now);
    
    if (difference.inMinutes <= 0) {
      return Icons.warning;
    } else if (difference.inMinutes <= 30) {
      return Icons.timer;
    } else if (difference.inHours <= 1) {
      return Icons.access_time;
    } else if (difference.inDays <= 1) {
      return Icons.today;
    } else {
      return Icons.calendar_today;
    }
  }
}