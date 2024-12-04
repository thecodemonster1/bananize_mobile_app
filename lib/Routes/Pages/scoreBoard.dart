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
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('scores')
                    .orderBy('Score', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
          
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                        child: Text('No scores available',
                            style: TextStyle(fontSize: 18)));
                  }
          
                  final scores = snapshot.data!.docs;
          
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            border: TableBorder.all(color: Colors.grey),
                            columns: const [
                              // DataColumn(
                              //     label: Text('Rank',
                              //         style: TextStyle(fontWeight: FontWeight.bold))),
                              DataColumn(
                                  label: Text('Name/Email',
                                      style: TextStyle(fontWeight: FontWeight.bold))),
                              DataColumn(
                                  label: Text('Score',
                                      style: TextStyle(fontWeight: FontWeight.bold))),
                            ],
                            rows: List<DataRow>.generate(
                              scores.length,
                              (index) {
                                final scoreData =
                                    scores[index].data() as Map<String, dynamic>;
                                return DataRow(
                                  cells: [
                                    // DataCell(Text('${scoreData['Rank'] ?? index + 1}')),
                                    DataCell(Text(scoreData['Name'] ?? 'Unknown')),
                                    DataCell(Text('${scoreData['Score'] ?? '0'}')),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
