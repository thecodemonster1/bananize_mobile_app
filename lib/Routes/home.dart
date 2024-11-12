// import "package:flutter/material.dart";

// class MyHome extends StatelessWidget {
//   const MyHome({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.amberAccent,
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           style: ElevatedButton.styleFrom(
//             foregroundColor: Colors.white,
//             backgroundColor: Colors.black, // Text color (white)
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8.0), // Rounded corners
//             ),
//             padding: const EdgeInsets.symmetric(
//               horizontal: 32.0, // Horizontal padding
//               vertical: 12.0, // Vertical padding
//             ),
//           ),
//           child: const Text('Go Back'),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // List<dynamic> _data = [];
  String? questionImageUrl;
  int? solution;
  String userInput = '';
  bool isLoading = true;
  String message = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true; // Show loader while fetching new data
      message = ''; // Clear any previous message
    });

    final response =
        await http.get(Uri.parse('http://marcconrad.com/uob/banana/api.php'));
    // print("checkpoint 1");
    if (response.statusCode == 200) {
      // sucess code 200
      final data = json.decode(response.body);
      setState(() {
        // _data = json.decode(response.body);
        questionImageUrl = data['question'];
        solution = data['solution'];
        userInput = ''; // Clear the input field after fetching new data
        isLoading = false;
      });
    } else {
      //  failed to fetch data
      throw Exception('Failed to load data');
    }
  }

  void checkAnswer() async {
    if (userInput.isEmpty) {
      setState(() {
        message = 'Please enter a number!';
      });
      return;
    }

    if (int.tryParse(userInput) == solution) {
      setState(() {
        message = 'Correct! 🎉';
      });
      // Add a 1-second delay before fetching new data
      await Future.delayed(const Duration(seconds: 1));
      fetchData(); // Fetch a new image after the correct answer
    } else {
      setState(() {
        message = 'Wrong answer. Try again!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  if (questionImageUrl != null)
                    Image.network(questionImageUrl!),
                  const SizedBox(height: 20),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        userInput = value;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Enter your answer',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: checkAnswer,
                    child: const Text('Submit'),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
