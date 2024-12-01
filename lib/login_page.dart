// import 'package:authenticator/signup_page.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:authenticator/home_page.dart'; // Import the homepage

// class LoginPage extends StatefulWidget {
//   static route() => MaterialPageRoute(
//         builder: (context) => const LoginPage(),
//       );
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final formKey = GlobalKey<FormState>();

//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }

//   Future<void> loginUserWithEmailAndPassword() async {
//     try {
//       final userCredential =
//           await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: emailController.text.trim(),
//         password: passwordController.text.trim(),
//       );

//       // After successful login, navigate to the homepage
//       if (userCredential.user != null) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const MyHomePage()),
//         );
//       }
//     } on FirebaseAuthException catch (e) {
//       print(e.message);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Form(
//           key: formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 'Sign In.',
//                 style: TextStyle(
//                   fontSize: 50,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 30),
//               TextFormField(
//                 controller: emailController,
//                 decoration: const InputDecoration(
//                   hintText: 'Email',
//                 ),
//               ),
//               const SizedBox(height: 15),
//               TextFormField(
//                 controller: passwordController,
//                 decoration: const InputDecoration(
//                   hintText: 'Password',
//                 ),
//                 obscureText: true,
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () async {
//                   await loginUserWithEmailAndPassword();
//                 },
//                 child: const Text(
//                   'SIGN IN',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const SignUpPage()),
//                   );
//                 },
//                 child: RichText(
//                   text: TextSpan(
//                     text: 'Don\'t have an account? ',
//                     style: Theme.of(context).textTheme.titleMedium,
//                     children: [
//                       TextSpan(
//                         text: 'Sign Up',
//                         style:
//                             Theme.of(context).textTheme.titleMedium?.copyWith(
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:authenticator/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:authenticator/home_page.dart'; // Import the homepage

class LoginPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const LoginPage(),
      );
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> loginUserWithEmailAndPassword() async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (userCredential.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An error occurred. Please try again later.';
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password. Please try again.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is invalid.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign In.',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await loginUserWithEmailAndPassword();
                },
                child: const Text(
                  'SIGN IN',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpPage()),
                  );
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Don\'t have an account? ',
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
