import "package:bananize_mobile_app/Routes/Pages/rules.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class MySignup extends StatelessWidget {
  MySignup({super.key});
  final int oneSideSize = 250;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _signUp(BuildContext context) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Sign up successful \nWelcome ${userCredential.user!.email}')),
      );
      // Navigate to the next screen if sign-up is successful
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyRules(
                  email: {userCredential.user!.email},
                )),
      );
    } on FirebaseAuthException catch (e) {
      // Show an error message if sign-up fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.message ?? 'Login failed'}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Container(
                  padding: const EdgeInsets.all(1.0),
                  // decoration: BoxDecoration(
                  //   color: Colors.blueAccent,
                  //   borderRadius: BorderRadius.circular(8.0),
                  // ),
                  child: Image.asset(
                    'lib/Assets/Images/banana-white.png',
                    width: oneSideSize.toDouble(),
                    height: oneSideSize.toDouble(),
                  ),
                ),
                // const SizedBox(height: 20),
                const Text(
                  'Bananize',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                // Card for Sign Up Form
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        12.0), // Rounded corners for the card
                  ),
                  elevation: 8.0, // Shadow effect for the card
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // Sign Up title
                        const Text(
                          'S I G N U P',
                          style: TextStyle(
                              fontSize: 34, fontWeight: FontWeight.normal),
                        ),
                        const SizedBox(height: 20),

                        // Username TextField
                        TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Email TextField
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Password TextField
                        TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          obscureText: true,
                        ),
                        const SizedBox(height: 20),

                        // Sign Up button
                        ElevatedButton(
                          onPressed: () {
                            _signUp(context);
                          }, // sign up functionality
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.black, // Text color (white)
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(8.0), // Rounded corners
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32.0, // Horizontal padding
                              vertical: 12.0, // Vertical padding
                            ),
                          ),
                          child: const Text('Sign Up'),
                        ),
                        const SizedBox(height: 10),

                        // if already have an account
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Go back to login page
                          },
                          child:
                              const Text('Already have an account? Click Here'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
