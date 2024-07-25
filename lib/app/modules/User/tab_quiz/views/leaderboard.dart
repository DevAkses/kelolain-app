import 'package:flutter/material.dart';
import 'package:safeloan/app/utils/warna.dart';
import 'package:safeloan/app/widgets/button_back_leading.dart';

class LeaderBoard extends StatelessWidget {
  const LeaderBoard({super.key});

  Widget cardHeader(String deskripsi, String linkGambar, VoidCallback onTap) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Utils.backgroundCard,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 30,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Center(
        child: ListTile(
          subtitle: Text(
            deskripsi,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          trailing: SizedBox(
            width: 100,
            height: 100,
            child: Image.asset(
              linkGambar,
              fit: BoxFit.cover,
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final leaderboardData = [
      {'name': 'Alice', 'points': 1500},
      {'name': 'Bob', 'points': 1200},
      {'name': 'Charlie', 'points': 1100},
      {'name': 'David', 'points': 1000},
      {'name': 'Eve', 'points': 950},
      {'name': 'Anda', 'points': 900},
      {'name': 'Ulul', 'points': 930},
      {'name': 'Yusril', 'points': 800},
      {'name': 'Yusril', 'points': 800},
      {'name': 'Yusril', 'points': 800},
      {'name': 'Yusril', 'points': 800},
      {'name': 'Yusril', 'points': 800},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Leaderboard',
          style: Utils.header,
        ),
        centerTitle: true,
        leading: const ButtonBackLeading(),
      ),
      body: Column(
        children: [
          cardHeader(
            'Ayo selesaikan kuis dan tantangan untuk mengumpulkan poin dan menjadi nomor satu!',
            'assets/images/trophy.png',
            () {},
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 25),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Utils.backgroundCard,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.05),
                    spreadRadius: 0,
                    blurRadius: 30,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ListView.builder(
                itemCount: leaderboardData.length - 2,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    // Top 3 section
                    return Container(
                      height: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(3, (i) {
                          final user = leaderboardData[i];
                          return _buildTopThreeItem(i, user);
                        }),
                      ),
                    );
                  } else {
                    // Rest of the list
                    final user = leaderboardData[index + 2];
                    return _buildListItem(index + 3, user);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopThreeItem(int index, Map<String, dynamic> user) {
    return Container(
      width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blue[50],
            child: Text(
              '${index + 1}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Utils.biruSatu,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${user['name']}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            '${user['points']} pts',
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.all(1.0),
            decoration: BoxDecoration(
              color: Colors.yellow[700],
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.star, color: Colors.white, size: 25),
          ),
        ],
      ),
    );
  }

 Widget _buildListItem(int index, Map<String, dynamic> user) {
  bool isCurrentUser = user['name'] == 'Anda';
  
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: isCurrentUser ? Utils.biruLima : Colors.transparent,
    ),
    child: ListTile(
      leading: CircleAvatar(
        backgroundColor: Utils.biruSatu,
        child: Text(
          '$index',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      title: Text(
        '${user['name']}',
        style: TextStyle(
          fontWeight: isCurrentUser ? FontWeight.bold : FontWeight.normal,
          color: isCurrentUser ? Utils.biruDua : Colors.black,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${user['points']}',
            style: TextStyle(
              fontSize: 14, 
              fontWeight: FontWeight.bold,
              color: isCurrentUser ? Utils.biruDua : Colors.grey,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: Colors.yellow[700],
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.star, color: Colors.white, size: 15),
          ),
        ],
      ),
    ),
  );
}
}
