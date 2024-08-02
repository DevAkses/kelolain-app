import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safeloan/app/services/notification_service.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationManager {
  final NotificationService notificationService = NotificationService();

  Future<void> scheduleNotifications(String userId) async {
    tz.initializeTimeZones();
    final localTimezone = tz.local;

    final loansSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('loans')
        .get();

    for (var doc in loansSnapshot.docs) {
      final data = doc.data();
      final tanggalPinjaman = (data['tanggalPinjaman'] as Timestamp).toDate();
      final angsuran = data['angsuran'] as int;

      final jatuhTempo = tanggalPinjaman;
      final satuHariSebelum = jatuhTempo.subtract(Duration(days: 1));

      final tzJatuhTempo = tz.TZDateTime.from(jatuhTempo, localTimezone);
      final tzSatuHariSebelum = tz.TZDateTime.from(satuHariSebelum, localTimezone);

      await notificationService.showNotification(
        id: doc.id.hashCode,
        title: 'Peringatan Tagihan',
        body: 'Tagihan Anda sebesar ${angsuran} akan jatuh tempo besok.',
        sound: 'lagu2',
        channelId: 'channel_id_29',
        scheduledTime: tzSatuHariSebelum,
      );

      await notificationService.showNotification(
        id: doc.id.hashCode + 1,
        title: 'Jatuh Tempo Tagihan',
        body: 'Tagihan Anda sebesar ${angsuran} jatuh tempo hari ini.',
        sound: 'lagu2',
        channelId: 'channel_id_22',
        scheduledTime: tzJatuhTempo,
      );
    }
  }

  Future<void> showDelayedNotification(String userId, String title, String body) async {
    tz.initializeTimeZones();
    final localTimezone = tz.local;

    final now = tz.TZDateTime.now(localTimezone);
    final fiveSecondsLater = now.add(Duration(seconds: 5));

    await notificationService.showNotification(
      id: DateTime.now().hour, 
      title: title,
      body: body,
      sound: 'lagu2',
      channelId: 'channel_id_28',
      scheduledTime: fiveSecondsLater,
    );
  }
}
