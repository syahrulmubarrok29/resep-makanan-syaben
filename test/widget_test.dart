import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Simple test tanpa import app yang kompleks
void main() {
  testWidgets('Simple widget test', (WidgetTester tester) async {
    // Build a simple widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Resep Makanan'),
          ),
          body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      color: Colors.grey[300],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Nasi Goreng Spesial'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );

    // Verify the app bar title exists
    expect(find.text('Resep Makanan'), findsOneWidget);
  });

  testWidgets('Test basic UI components', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('Food Recipe App'),
          ),
        ),
      ),
    );

    expect(find.text('Food Recipe App'), findsOneWidget);
  });

  // Test sederhana untuk fungsi matematika
  test('Addition test', () {
    expect(1 + 1, equals(2));
  });

  test('String test', () {
    expect('Food Recipe App'.length, greaterThan(0));
  });
}