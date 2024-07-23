import 'package:flutter/material.dart';
import 'package:safeloan/app/utils/warna.dart';

class LeaderBoard extends StatelessWidget {
  const LeaderBoard({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data
    final leaderboardData = [
      {'name': 'Alice', 'points': 1500},
      {'name': 'Bob', 'points': 1200},
      {'name': 'Charlie', 'points': 1100},
      {'name': 'David', 'points': 1000},
      {'name': 'Eve', 'points': 950},
      {'name': 'Dev', 'points': 900},
      {'name': 'Ulul', 'points': 930},
      {'name': 'Yusril', 'points': 800},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard', style: Utils.header,),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Top 3 Leaderboard
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
                          backgroundColor: Utils.biruEmpat,
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold, color: Utils.biruSatu),
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
            const SizedBox(height: 10),
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
                      title: Text('${user['name']!}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('${user['points']}', style: const TextStyle(color: Colors.grey),),
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
