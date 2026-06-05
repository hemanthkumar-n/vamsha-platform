import 'package:flutter/material.dart';

class SelfProfileScreen extends StatelessWidget {
  const SelfProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Your Profile')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: const [
          _ProfileField(label: 'Full name'),
          _ProfileField(label: 'Display name'),
          _ProfileField(
            label: 'App language',
            hint: 'Example: English (en-IN)',
          ),
          _ProfileField(
            label: 'Mother tongue',
            hint: 'Example: Telugu (te-IN)',
          ),
          _ProfileField(
            label: 'Fluent languages',
            hint: 'Example: Telugu, Tamil, Malayalam',
          ),
          _ProfileField(label: 'Country', hint: 'Example: India (IN)'),
          _ProfileField(label: 'State or region'),
          _ProfileField(label: 'City or locality'),
          _ProfileField(label: 'Native place'),
          _ProfileField(label: 'Religion (optional)'),
        ],
      ),
    );
  }
}

class _ProfileField extends StatelessWidget {
  final String label;
  final String? hint;

  const _ProfileField({
    required this.label,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
