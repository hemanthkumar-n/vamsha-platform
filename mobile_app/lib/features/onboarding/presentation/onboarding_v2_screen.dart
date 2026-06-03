import 'package:flutter/material.dart';

class OnboardingV2Screen extends StatefulWidget {
  const OnboardingV2Screen({super.key});

  @override
  State<OnboardingV2Screen> createState() => _OnboardingV2ScreenState();
}

class _OnboardingV2ScreenState extends State<OnboardingV2Screen> {
  int currentStep = 0;
  String selectedRelationship = 'Uncle';
  String selectedDisplayTerm = 'Mama';

  Widget premiumField(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vamsha Onboarding')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF7F8FF), Color(0xFFEDE7FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stepper(
          elevation: 0,
          currentStep: currentStep,
          onStepContinue: () {
            if (currentStep < 4) setState(() => currentStep++);
          },
          onStepCancel: () {
            if (currentStep > 0) setState(() => currentStep--);
          },
          steps: [
            Step(
              title: const Text('Identity'),
              content: Column(
                children: [
                  premiumField('Legal Name'),
                  premiumField('Display Name'),
                  premiumField('Mother Tongue'),
                ],
              ),
            ),
            const Step(
              title: Text('Naming Intelligence'),
              content: Text('Support cultural naming conventions.'),
            ),
            Step(
              title: const Text('Family Space'),
              content: premiumField('Family Space Name'),
            ),
            const Step(
              title: Text('Immediate Family'),
              content: Text('Quick add setup coming next.'),
            ),
            Step(
              title: const Text('Relationship Intelligence'),
              content: Column(
                children: [
                  DropdownButtonFormField<String>(
                    initialValue: selectedRelationship,
                    decoration:
                        const InputDecoration(labelText: 'Relationship'),
                    items: [
                      'Father',
                      'Mother',
                      'Uncle',
                      'Aunt',
                      'Brother',
                      'Sister'
                    ]
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) =>
                        setState(() => selectedRelationship = value!),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: selectedDisplayTerm,
                    decoration: const InputDecoration(
                        labelText: 'How do you call them?'),
                    items: [
                      'Uncle',
                      'Mama',
                      'Mamaji',
                      'Babai',
                      'Machan',
                      'Chettan',
                      'Other'
                    ]
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) =>
                        setState(() => selectedDisplayTerm = value!),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
