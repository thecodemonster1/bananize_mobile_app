import "package:bananize_mobile_app/Routes/Pages/rules.dart";
import "package:bananize_mobile_app/Routes/Pages/signup.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:google_sign_in/google_sign_in.dart";

class MyLogin extends StatelessWidget {
  MyLogin({super.key});
  final logoSize = 250.0;
  final iconSize = 30;
  // final String username = "";
  // final String password = "";
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void _login(BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Login successful \nWelcome ${userCredential.user!.email}')),
      );
      // Navigate to the next screen if login is successful
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyRules()),
      );
    } on FirebaseAuthException catch (e) {
      // Show an error message if login fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.message ?? 'Login failed'}")),
      );
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // The user canceled the sign-in
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Sign in successful \nWelcome ${userCredential.user!.email}')),
      );
      // Navigate to the next screen if sign-in is successful
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyRules()),
      );
    } on FirebaseAuthException catch (e) {
      // Show an error message if sign-in fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Sign in failed')),
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Container(
                  padding: const EdgeInsets.all(1.0),
                  child: Image.asset(
                    'lib/Assets/Images/banana-white.png',
                    width: logoSize.toDouble(),
                    height: logoSize.toDouble(),
                  ),
                ),
                const Text(
                  'Bananize',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
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
                          'L O G I N',
                          style: TextStyle(
                              fontSize: 34, fontWeight: FontWeight.normal),
                        ),
                        const SizedBox(height: 20),

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
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // External login options (Inside the Card)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: Image.asset(
                                'lib/Assets/Images/1657952440google-logo-png-transparent.png.webp',
                                width: iconSize.toDouble(),
                                height: iconSize.toDouble(),
                              ),
                              onPressed: () {
                                _signInWithGoogle(context);
                              }, // Google login functionality
                            ),
                            IconButton(
                              icon: Image.asset(
                                'lib/Assets/Images/976px-Apple_logo_black.svg.png',
                                width: iconSize.toDouble(),
                                height: iconSize.toDouble(),
                              ),
                              onPressed: () {}, // Add Apple login functionality
                            ),
                            IconButton(
                              icon: Image.asset(
                                'lib/Assets/Images/Facebook_Logo_2023.png',
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
                            _login(context);
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
                                  builder: (context) => MySignup()),
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
