import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class ActivityCard extends StatelessWidget {
  final String activity;
  final String duration;
  final String imagePath;
  final String description;
  final String url;

  const ActivityCard({
    super.key,
    required this.activity,
    required this.duration,
    required this.imagePath,
    required this.description,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ActivityDetailPage(
              activity: activity,
              duration: duration,
              description: description,
              url: url,
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: Image.asset(imagePath, width: 40, height: 40),
          title: Text(activity, style: const TextStyle(fontSize: 24)),
          trailing: Text(duration, style: const TextStyle(fontSize: 24)),
        ),
      ),
    );
  }
}

class ActivityDetailPage extends StatelessWidget {
  final String activity;
  final String duration;
  final String description;
  final String url;

  const ActivityDetailPage({
    super.key,
    required this.activity,
    required this.duration,
    required this.description,
    required this.url,
  });

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/plank.json',
                width: 180,
                height: 180,
                fit: BoxFit.cover,
              ),
              Text(
                activity,
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
              Text(
                duration,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => _launchURL(url),
                child: Container(
                  color: Colors.black12,
                  height: 200,
                  child: const Center(
                    child: Text(
                      'Start Workout',
                      style: TextStyle(fontSize: 24, color: Colors.blue),
                    ),
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
