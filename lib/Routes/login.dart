import "package:bananize_mobile_app/Routes/home.dart";
import "package:bananize_mobile_app/Routes/signup.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

class MyLogin extends StatelessWidget {
  const MyLogin({super.key});
  final logoSize = 250.0;
  final iconSize = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
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
                    'lib/Assets/banana-white.png',
                    width: logoSize.toDouble(),
                    height: logoSize.toDouble(),
                  ),
                ),
                const SizedBox(height: 20),

                // Card for Login Form
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
                        // Login title
                        const Text(
                          'LOGIN',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),

                        // Username TextField
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Password TextField
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          obscureText: true,
                        ),
                        const SizedBox(height: 20),

                        // External login options (Inside the Card)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: Image.asset(
                                'lib/Assets/1657952440google-logo-png-transparent.png.webp',
                                width: iconSize.toDouble(),
                                height: iconSize.toDouble(),
                              ),
                              onPressed:
                                  () {}, // Add Google login functionality
                            ),
                            IconButton(
                              icon: Image.asset(
                                'lib/Assets/976px-Apple_logo_black.svg.png',
                                width: iconSize.toDouble(),
                                height: iconSize.toDouble(),
                              ),
                              onPressed: () {}, // Add Apple login functionality
                            ),
                            IconButton(
                              icon: Image.asset(
                                'lib/Assets/Facebook_Logo_2023.png',
                                width: iconSize.toDouble(),
                                height: iconSize.toDouble(),
                              ),
                              onPressed:
                                  () {}, // Add Facebook login functionality
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Sign in button
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyHome()),
                            );
                          }, // Add sign in functionality
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
                          child: const Text('Sign In'),
                        ),
                        const SizedBox(height: 10),

                        // Forgot password link
                        TextButton(
                          onPressed: () {}, // Add forgot password functionality
                          child: const Text('Forgot Password?'),
                        ),

                        // New user link
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MySignup()),
                            );
                          },
                          child: const Text('New User? Sign Up'),
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('logoSize', logoSize));
  }
}
