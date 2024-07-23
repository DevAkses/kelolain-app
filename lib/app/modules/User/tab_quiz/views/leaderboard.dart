import 'package:flutter/material.dart';
import 'package:safeloan/app/utils/warna.dart';

class LeaderBoard extends StatelessWidget {
  const LeaderBoard({super.key});

  Widget cardHeader(
       String deskripsi, String linkGambar, VoidCallback onTap) {
    return Container(
      width: double.infinity,
      height: 150,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
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
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Leaderboard',
          style: Utils.header,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            cardHeader('Ayo selesaikan kuis dan tantangan untuk mengumpulkan poin dan menjadi nomor satu!', 'assets/images/trophy.png', (){}),
            Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  final user = leaderboardData[index];
                  return Container(
                    width: 100,
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
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
                                color: Utils.biruSatu),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${user['name']!}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${user['points']} pts',
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.all(1.0),
                          decoration: BoxDecoration(
                            color: Colors.yellow[700],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.star,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Remaining Leaderboard
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: leaderboardData.length - 3,
                  itemBuilder: (context, index) {
                    final user = leaderboardData[index + 3];
                    return ListTile(
                      leading: Text('${index + 4}'),
                      title: Text(
                        '${user['name']}',
                        style: TextStyle(
                          fontWeight: user['name'] == 'Anda'
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: user['name'] == 'Anda'
                              ? Utils.biruDua
                              : Colors.black,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${user['points']}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.all(1.0),
                            decoration: BoxDecoration(
                              color: Colors.yellow[700],
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.star,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
