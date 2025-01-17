import 'package:flutter/material.dart';
import '../services/firebase_service.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  String _response = '';
  bool _isLoading = false;

  Future<void> _testFirebaseFunction() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final result = await _firebaseService.getHelloWorld();
      setState(() {
        _response = result;
      });
    } catch (e) {
      setState(() {
        _response = 'Hata: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Function Test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isLoading)
              const CircularProgressIndicator()
            else
              Text(_response.isEmpty ? 'Henüz istek yapılmadı' : _response),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _testFirebaseFunction,
              child: const Text('Firebase Fonksiyonunu Test Et'),
            ),
          ],
        ),
      ),
    );
  }
}
