import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:safeloan/app/services/notification_service.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationManager {
  final NotificationService notificationService = NotificationService();
  final Map<String, List<int>> scheduledNotifications = {}; // Mengelola ID notifikasi berdasarkan dokumen

  Future<void> scheduleNotifications(String userId) async {
    await notificationService.initNotification();
    tz.initializeTimeZones();
    final localTimezone = tz.getLocation('Asia/Jakarta');

    // Memantau perubahan data secara real-time
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('loans')
        .snapshots()
        .listen((snapshot) async {
      for (var change in snapshot.docChanges) {
        final docId = change.doc.id;
        final data = change.doc.data();

        if (change.type == DocumentChangeType.added || change.type == DocumentChangeType.modified) {
          final tanggalPinjaman = (data!['tanggalPinjaman'] as Timestamp).toDate();
          final angsuran = data['angsuran'] as int;

          final now = tz.TZDateTime.now(localTimezone);
          final tzTanggalPinjaman = tz.TZDateTime.from(tanggalPinjaman, localTimezone);
          final delay = tzTanggalPinjaman.difference(now).inSeconds;

          if (delay >= 0) {
            // Hapus notifikasi yang sudah ada sebelum menjadwalkan yang baru
            await cancelScheduledNotifications(docId);

            List<int> ids = [];
            for (int i = 0; i < angsuran; i++) {
              final notificationId = docId.hashCode + i;
              ids.add(notificationId);
              await Future.delayed(Duration(seconds: 7)); // Simulasi 1 hari, ganti sesuai kebutuhan
              await notificationService.showNotification(
                id: notificationId,
                title: 'Tagihan Notification',
                body: 'Ada Tagihan',
                sound: 'lagu2',
                channelId: 'channel_id_00',
              );
            }
            scheduledNotifications[docId] = ids;
          } else {
            await notificationService.showNotification(
              id: docId.hashCode,
              title: 'Tagihan Notification',
              body: '-------------',
              sound: 'lagu2',
              channelId: 'channel_id_00',
            );
          }
        } else if (change.type == DocumentChangeType.removed) {
          await cancelScheduledNotifications(docId);
        }
      }
    });
  }

  Future<void> cancelScheduledNotifications(String docId) async {
    final ids = scheduledNotifications[docId] ?? [];
    for (int id in ids) {
      await notificationService.cancelNotification(id);
    }
    scheduledNotifications.remove(docId);
  }

  Future<void> showInstantNotification(String title, String body) async {
    await notificationService.initNotification();
    notificationService.showNotification(
      id: 0,
      title: title,
      body: body,
      sound: 'lagu2',
      channelId: 'channel_id_00',
    );
  }

  Future<void> showDelayedNotification(String title, String body) async {
    await notificationService.initNotification();
    await Future.delayed(const Duration(seconds: 5));
    notificationService.showNotification(
      id: 0,
      title: title,
      body: body,
      sound: 'lagu2',
      channelId: 'channel_id_00',
    );
  }
}
