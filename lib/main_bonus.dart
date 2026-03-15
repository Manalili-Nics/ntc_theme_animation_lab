// lib/main_bonus.dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NTC Theme Animation Lab',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: BonusGalleryScreen(
        onThemeToggle: (value) {
          setState(() {
            isDarkMode = value;
          });
        },
        isDarkMode: isDarkMode,
      ),
    );
  }
}

class BonusGalleryScreen extends StatefulWidget {
  final Function(bool) onThemeToggle;
  final bool isDarkMode;

  const BonusGalleryScreen({
    super.key,
    required this.onThemeToggle,
    required this.isDarkMode,
  });

  @override
  State<BonusGalleryScreen> createState() => _BonusGalleryScreenState();
}

class _BonusGalleryScreenState extends State<BonusGalleryScreen> {
  double containerHeight = 50.0;
  Color containerColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Gallery with Animations'),
        actions: [
          Row(
            children: [
              const Text('Dark Mode'),
              Switch(value: widget.isDarkMode, onChanged: widget.onThemeToggle),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Animated Container (Bonus feature)
          GestureDetector(
            onTap: () {
              setState(() {
                containerHeight = containerHeight == 50.0 ? 100.0 : 50.0;
                containerColor = containerColor == Colors.blue
                    ? Colors.green
                    : Colors.blue;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
              width: double.infinity,
              height: containerHeight,
              color: containerColor,
              margin: const EdgeInsets.all(8.0),
              child: const Center(
                child: Text(
                  'Tap to Animate Me!',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),

          // Gallery Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 800),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            BonusDetailScreen(imageIndex: index),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                              var begin = 0.0;
                              var end = 1.0;
                              var curve = Curves.easeInOut;

                              var tween = Tween(
                                begin: begin,
                                end: end,
                              ).chain(CurveTween(curve: curve));

                              return FadeTransition(
                                opacity: animation.drive(tween),
                                child: child,
                              );
                            },
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'image-$index',
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color:
                            Colors.primaries[index % Colors.primaries.length],
                        image: const DecorationImage(
                          image: NetworkImage(
                            'https://picsum.photos/200/300?random=$index',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BonusDetailScreen extends StatelessWidget {
  final int imageIndex;

  const BonusDetailScreen({super.key, required this.imageIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image $imageIndex Details')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'image-$imageIndex',
                child: Container(
                  height: 400,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color:
                        Colors.primaries[imageIndex % Colors.primaries.length],
                    image: const DecorationImage(
                      image: NetworkImage('https://picsum.photos/400/600'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Beautiful Image',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'This is a detailed view of the selected image with Hero animation.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
