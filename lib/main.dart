import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const PetAgeApp());
}

class PetAgeApp extends StatelessWidget {
  const PetAgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Age Calculator',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.pinkAccent,
        scaffoldBackgroundColor: Colors.pink.shade50,
      ),
      home: const PetAgeHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PetAgeHomePage extends StatefulWidget {
  const PetAgeHomePage({super.key});

  @override
  State<PetAgeHomePage> createState() => _PetAgeHomePageState();
}

class _PetAgeHomePageState extends State<PetAgeHomePage> {
  final List<String> petTypes = ['Dog', 'Cat'];
  String selectedPet = 'Dog';
  DateTime? selectedDate;
  String result = '';

  void _pickDate() async {
    final today = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(today.year - 3),
      firstDate: DateTime(today.year - 30),
      lastDate: today,
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _calculateAge() {
    if (selectedDate == null) return;

    final today = DateTime.now();
    final ageInYears = today.year - selectedDate!.year;
    double petAge;

    if (selectedPet == 'Dog') {
      petAge = ageInYears * 7;
    } else {
      petAge = ageInYears * 6;
    }

    setState(() {
      result =
          'Your $selectedPet is approximately ${petAge.toStringAsFixed(1)} human years old.';
    });
  }

  IconData _getPetIcon(String pet) {
    return pet == 'Dog' ? Icons.pets : Icons.pets_outlined;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Age Calculator'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Select your pet: ', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 12),
                DropdownButton<String>(
                  value: selectedPet,
                  icon: const Icon(Icons.arrow_drop_down),
                  items:
                      petTypes.map((pet) {
                        return DropdownMenuItem<String>(
                          value: pet,
                          child: Row(
                            children: [
                              Icon(_getPetIcon(pet), color: Colors.pink),
                              const SizedBox(width: 8),
                              Text(pet),
                            ],
                          ),
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedPet = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _pickDate,
              icon: const Icon(Icons.calendar_today),
              label: Text(
                selectedDate == null
                    ? 'Select Birth Date'
                    : DateFormat('yMMMMd').format(selectedDate!),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _calculateAge,
              child: const Text('Calculate Age'),
            ),
            const SizedBox(height: 40),
            Text(
              result,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
