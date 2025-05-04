import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
import 'chat_screen.dart';
import 'welcome_page.dart';
import 'update_plan_page.dart';
import 'activity_card.dart';

class FitnessHomePage extends StatelessWidget {
  const FitnessHomePage({super.key});

  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomePage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to logout: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 111, 0),
              ),
              child: Image.asset(
                'assets/images/skip.png',
                height: 150.0,
                width: 150.0,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () => _logout(context),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 255, 111, 0),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Builder(
                      builder: (context) => CircleAvatar(
                        radius: 20,
                        backgroundColor: const Color.fromRGBO(255, 196, 145, 1),
                        child: IconButton(
                          icon: const Icon(Icons.person, color: Colors.black),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: Lottie.asset(
                    'assets/jogging.json',
                    height: 250,
                    width: 250,
                    fit: BoxFit.cover,
                  ),
                ),
                const Center(
                 
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Workouts\nCompleted',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromARGB(255, 135, 58, 0),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '151',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Workouts\nThis Week',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromARGB(255, 135, 58, 0),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '13',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Current\nMass (kg)',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromARGB(255, 135, 58, 0),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '81',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'For You',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: const [
                ActivityCard(
                  activity: 'HIIT',
                  duration: '10 mins',
                  imagePath: 'assets/images/hiit_icon.png',
                  description: 'High-Intensity Interval Training, is a workout alternating between short bursts of intense exercise and brief rest periods. This method boosts your heart rate quickly, burns more calories in less time, and keeps your metabolism elevated even after the workout, making it a highly effective way to improve fitness and burn fat.',
                  url: 'https://www.youtube.com/watch?v=edIK5SZYMZo',
                ),
                ActivityCard(
                  activity: 'PULL',
                  duration: '15 mins',
                  imagePath: 'assets/images/pull_icon.png',
                  description: 'Pull exercises focus on working muscles that pull weight toward your body, primarily targeting your back, biceps, and forearms. Examples include pull-ups, rows, and bicep curls. These exercises help improve upper body strength and posture while also engaging stabilizing muscles. Incorporating pull exercises into your workout routine can contribute to a balanced and functional physique.',
                  url: 'https://www.youtube.com/watch?v=1tHZ-hUH2P8',
                ),
                ActivityCard(
                  activity: 'PUSH',
                  duration: '70 mins',
                  imagePath: 'assets/images/push_icon.png',
                  description: 'Home jogging is simply running in place or around a designated area in your home. It’s a convenient and accessible way to stay active without needing a treadmill or outdoor space. You can incorporate it into your daily routine, and it is great for improving cardiovascular health, burning calories, and boosting your mood. Plus, you can easily adjust the intensity to match your fitness level.',
                  url: 'https://www.youtube.com/watch?v=bVVfE0M5CNw',
                ),
                ActivityCard(
                  activity: 'Jog',
                  duration: '60 mins',
                  imagePath: 'assets/images/jog_icon.png',
                  description: 'Home jogging is simply running in place or around a designated area in your home. It’s a convenient and accessible way to stay active without needing a treadmill or outdoor space. You can incorporate it into your daily routine, and it is great for improving cardiovascular health, burning calories, and boosting your mood. Plus, you can easily adjust the intensity to match your fitness level.',
                  url: 'https://www.youtube.com/watch?v=scdQ5_8X3aM',
                ),
                ActivityCard(
                  activity: 'Cardio',
                  duration: '30 mins',
                  imagePath: 'assets/images/jog_icon.png',
                  description: 'Home jogging is simply running in place or around a designated area in your home. It’s a convenient and accessible way to stay active without needing a treadmill or outdoor space. You can incorporate it into your daily routine, and it is great for improving cardiovascular health, burning calories, and boosting your mood. Plus, you can easily adjust the intensity to match your fitness level.',
                  url: 'https://www.youtube.com/watch?v=scdQ5_8X3aM',
                ),
                ActivityCard(
                  activity: 'Endurance',
                  duration: '10 mins',
                  imagePath: 'assets/images/jog_icon.png',
                  description: 'Endurance workouts improve stamina and cardiovascular health by engaging in prolonged activities like running, cycling, or swimming at a steady pace. These exercises keep your heart rate elevated, boosting energy levels, enhancing heart and lung efficiency, and aiding in calorie burning.',
                  url: 'https://www.youtube.com/watch?v=saXF2xH3A2U&t=4s',
                ),
                ActivityCard(
                  activity: 'Arm',
                  duration: '40 mins',
                  imagePath: 'assets/images/arm.png',
                  description: 'Arm workouts target the muscles in your biceps, triceps, and forearms to build strength and definition. Common exercises include bicep curls, tricep dips, and push-ups. These workouts improve upper body strength, enhance muscle tone, and support functional movements in daily activities.',
                  url: 'https://www.youtube.com/watch?v=JyV7mUFSpXs',
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 255, 111, 0),
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 255, 111, 0),
                          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: const Icon(Icons.flag),
                              title: const Text('Update Your Plan'),
                              onTap: () {
                                Navigator.pop(context); // Close the bottom sheet
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const UpdatePlanPage(),
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.analytics),
                              title: const Text('Calorie Planner'),
                              onTap: () {
                                Navigator.pop(context); // Close the bottom sheet
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const UpdatePlanPage(),
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.feedback),
                              title: const Text('Feedback'),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset(
                                              'assets/images/coach_icon.png',
                                              height: 100,
                                              width: 100,
                                            ),
                                            const SizedBox(height: 20),
                                            const Text(
                                              'Give Us Feedback',
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            const Text(
                                              'Email: fitsense@helpcentre.com',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            const SizedBox(height: 10),
                                            const Text(
                                              'Customer Service: 123-456-7890',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            const SizedBox(height: 20),
                                            TextButton(
                                              onPressed: () => Navigator.pop(context),
                                              child: const Text('Close'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.contact_mail),
                              title: const Text('Contact Us'),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset(
                                              'assets/images/coach_icon.png',
                                              height: 100,
                                              width: 100,
                                            ),
                                            const SizedBox(height: 20),
                                            const Text(
                                              'Contact Us',
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            const Text(
                                              'Email: fitsense@helpcentre.com',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            const SizedBox(height: 10),
                                            const Text(
                                              'Customer Service: 123-456-7890',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            const SizedBox(height: 20),
                                            TextButton(
                                              onPressed: () => Navigator.pop(context),
                                              child: const Text('Close'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(width: 40),
              IconButton(
                icon: const Icon(Icons.bookmark, color: Color.fromARGB(255, 255, 111, 0)),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 100.0,
        width: 100.0,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChatScreen()),
            );
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(45.0),
          ),
          child: Image.asset(
            'assets/images/coach.png',
            height: 100.0,
            width: 100.0,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
