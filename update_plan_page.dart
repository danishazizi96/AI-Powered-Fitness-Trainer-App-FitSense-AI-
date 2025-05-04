import 'package:flutter/material.dart';

class UpdatePlanPage extends StatefulWidget {
  const UpdatePlanPage({super.key});

  @override
  _UpdatePlanPageState createState() => _UpdatePlanPageState();
}

class _UpdatePlanPageState extends State<UpdatePlanPage> {
  final _formKey = GlobalKey<FormState>();
  String? _gender;
  double? _mass;
  int? _age;
  String? _fitnessGoal;
  String? _fitnessLevel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Your Plan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Gender'),
                items: ['Male', 'Female'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _gender = newValue;
                  });
                },
                validator: (value) => value == null ? 'Please select a gender' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Mass (kg)'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _mass = double.tryParse(value ?? ''),
                validator: (value) => value == null || value.isEmpty ? 'Please enter your mass' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _age = int.tryParse(value ?? ''),
                validator: (value) => value == null || value.isEmpty ? 'Please enter your age' : null,
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Fitness Goal'),
                items: ['Weight Loss', 'Muscle Gain', 'Maintenance', 'Hypertrophy Growth', 'Strength Build', 'Bulk', 'Athlete', 'Slim', 'Marathon', 'Runway'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _fitnessGoal = newValue;
                  });
                },
                validator: (value) => value == null ? 'Please select a fitness goal' : null,
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Fitness Level'),
                items: ['Beginner', 'Intermediate', 'Advanced'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _fitnessLevel = newValue;
                  });
                },
                validator: (value) => value == null ? 'Please select a fitness level' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WorkoutPlanScreen(
                          gender: _gender!,
                          mass: _mass!,
                          age: _age!,
                          fitnessGoal: _fitnessGoal!,
                          fitnessLevel: _fitnessLevel!,
                        ),
                      ),
                    );
                  }
                 },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.orange, // Set the background color to orange
    foregroundColor: Colors.white,  // Set the text color to white
  ),
                child: const Text('Generate Workout Plan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WorkoutPlanScreen extends StatelessWidget {
  final String gender;
  final double mass;
  final int age;
  final String fitnessGoal;
  final String fitnessLevel;

  const WorkoutPlanScreen({super.key, 
    required this.gender,
    required this.mass,
    required this.age,
    required this.fitnessGoal,
    required this.fitnessLevel,
  });

  @override
  Widget build(BuildContext context) {
    final workoutPlan = generateWorkoutPlan();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Workout Plan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: workoutPlan.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(workoutPlan[index]),
            );
          },
        ),
      ),
    );
  }

  List<String> generateWorkoutPlan() {
    // Calculate BMR
    double bmr;
    if (gender == 'Male') {
      bmr = 88.362 + (13.397 * mass) + (4.799 * 165) - (5.677 * age);
    } else {
      bmr = 447.593 + (9.247 * mass) + (3.098 * 165) - (4.330 * age);
    }

    // Calculate TDEE based on an average activity level
    double tdee = bmr * 1.55;

    // Determine caloric intake based on fitness goal
    double caloricIntake;
    String dietRecommendation;
    switch (fitnessGoal) {
      case 'Weight Loss':
        caloricIntake = tdee * 0.8;
        dietRecommendation = '40% Protein, 30% Carbs, 30% Fat';
        break;
      case 'Muscle Gain':
      case 'Hypertrophy Growth':
      case 'Strength Build':
        caloricIntake = tdee * 1.1;
        dietRecommendation = '30% Protein, 40% Carbs, 30% Fat';
        break;
      case 'Bulk':
        caloricIntake = tdee * 1.2;
        dietRecommendation = '30% Protein, 40% Carbs, 30% Fat';
        break;
      case 'Maintenance':
        caloricIntake = tdee;
        dietRecommendation = '30% Protein, 50% Carbs, 20% Fat';
        break;
      case 'Athlete':
        caloricIntake = tdee * 1.2;
        dietRecommendation = '30% Protein, 50% Carbs, 20% Fat';
        break;
      case 'Slim':
        caloricIntake = tdee * 0.9;
        dietRecommendation = '35% Protein, 40% Carbs, 25% Fat';
        break;
      case 'Marathon':
        caloricIntake = tdee * 1.1;
        dietRecommendation = '30% Protein, 50% Carbs, 20% Fat';
        break;
      case 'Runway':
        caloricIntake = tdee * 0.85;
        dietRecommendation = '35% Protein, 40% Carbs, 25% Fat';
        break;
      default:
        caloricIntake = tdee;
        dietRecommendation = 'Balanced Diet';
        break;
    }

    // Generate workout plan
    List<String> workoutPlan = [];
    workoutPlan.add('Total Daily Caloric Intake: ${caloricIntake.toStringAsFixed(0)} kcal');
    workoutPlan.add('Diet Recommendation: $dietRecommendation');

    if (fitnessGoal == 'Weight Loss') {
      workoutPlan.add('Cardio - 30 minutes');
      workoutPlan.add('Strength Training - 20 minutes');
    } else if (fitnessGoal == 'Muscle Gain' || fitnessGoal == 'Hypertrophy Growth') {
      workoutPlan.add('Strength Training - 45 minutes');
    } else if (fitnessGoal == 'Maintenance') {
      workoutPlan.add('Mixed Training - 30 minutes');
    } else if (fitnessGoal == 'Strength Build') {
      workoutPlan.add('Strength Training - 30 minutes');
      workoutPlan.add('Progressive Overload Training');
    } else if (fitnessGoal == 'Bulk') {
      workoutPlan.add('Heavy Lifting - 60 minutes');
    } else if (fitnessGoal == 'Athlete') {
      workoutPlan.add('Functional Training - 60 minutes');
      workoutPlan.add('Sport-Specific Drills');
    } else if (fitnessGoal == 'Slim') {
      workoutPlan.add('Cardio - 40 minutes');
      workoutPlan.add('Core Workouts');
    } else if (fitnessGoal == 'Marathon') {
      workoutPlan.add('Running - 60 minutes');
      workoutPlan.add('Leg Strengthening Exercises');
    } else if (fitnessGoal == 'Runway') {
      workoutPlan.add('Light Weight Training - 30 minutes');
      workoutPlan.add('Toning Exercises');
    }

    // Adjust based on fitness level
    if (fitnessLevel == 'Beginner') {
      workoutPlan.add('Stretching - 10 minutes');
    } else if (fitnessLevel == 'Intermediate') {
      workoutPlan.add('HIIT - 20 minutes');
    } else if (fitnessLevel == 'Advanced') {
      workoutPlan.add('Advanced Lifting Techniques');
    }

    return workoutPlan;
  }
}
