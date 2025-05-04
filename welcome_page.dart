import 'package:flutter/material.dart';
import 'login_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Remove Image for Testing
            Image.asset('assets/images/coach_icon.png'),
            const SizedBox(height: 20),
            const Text(
              'Welcome to FitSense!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'We are excited to help you in your fitness journey.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: 130,
              height: 60, // Adjust the height as needed
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(241, 115, 36, 1), // Button color
                  foregroundColor: Colors.black, // Text color
                ),
                child: const Text(
                  'Start',
                  style: TextStyle(
                    fontSize: 20, // Adjust the font size as needed
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 60, // Adjust the height as needed
              
            ),
          ],
        ),
      ),
    );
  }
}
