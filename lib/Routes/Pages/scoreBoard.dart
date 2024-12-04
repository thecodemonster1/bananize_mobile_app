import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Scoreboard extends StatefulWidget {
  const Scoreboard({super.key});

  @override
  State<Scoreboard> createState() => _ScoreboardState();
}

class _ScoreboardState extends State<Scoreboard> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scoreboard'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('scores').orderBy('score', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No scores available'));
          }

          final scores = snapshot.data!.docs;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Rank')),
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Score')),
              ],
              rows: List<DataRow>.generate(
                scores.length,
                (index) {
                  final scoreData = scores[index].data() as Map<String, dynamic>;
                  return DataRow(
                    cells: [
                      DataCell(Text('${index + 1}')),
                      DataCell(Text(scoreData['name'] ?? 'Unknown')),
                      DataCell(Text('${scoreData['score']}')),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}