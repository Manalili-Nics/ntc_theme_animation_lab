import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final int imageIndex;

  const DetailScreen({super.key, required this.imageIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Porsche 911')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Hero(
            tag: 'image-$imageIndex',
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1614162692292-7ac56d7f7f1e?w=800&h=600&fit=crop', // Sharp Porsche detail
                  ),
                  fit: BoxFit
                      .contain, // Changed to contain to prevent zooming/cropping
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
