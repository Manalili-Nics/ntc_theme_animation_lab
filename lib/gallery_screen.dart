import 'package:flutter/material.dart';
import 'detail_screen.dart';

class GalleryScreen extends StatelessWidget {
  final Function(bool) onThemeToggle;
  final bool isDarkMode;

  const GalleryScreen({
    super.key,
    required this.onThemeToggle,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Porsche Gallery'),
        actions: [
          Row(
            children: [
              const Text('Dark Mode'),
              Switch(value: isDarkMode, onChanged: onThemeToggle),
            ],
          ),
        ],
      ),
      // FIXED: Use Column to show BOTH animated container AND grid
      body: Column(
        children: [
          // ADD THIS LINE - This actually shows the bonus feature
          const AnimatedContainerBonus(),

          // Your existing grid wrapped in Expanded
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
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(imageIndex: index),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'image-$index',
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: const DecorationImage(
                          image: NetworkImage(
                            'https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=400&h=400&fit=crop',
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

// BONUS WIDGET: AnimatedContainer (this part is correct, keep it as is)
class AnimatedContainerBonus extends StatefulWidget {
  const AnimatedContainerBonus({super.key});

  @override
  State<AnimatedContainerBonus> createState() => _AnimatedContainerBonusState();
}

class _AnimatedContainerBonusState extends State<AnimatedContainerBonus> {
  double containerHeight = 50.0;
  Color containerColor = Colors.pink;
  double borderRadius = 8.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (containerHeight == 50.0) {
            containerHeight = 100.0;
            containerColor = Colors.blue;
            borderRadius = 20.0;
          } else {
            containerHeight = 50.0;
            containerColor = Colors.pink;
            borderRadius = 8.0;
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
        width: double.infinity,
        height: containerHeight,
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        margin: const EdgeInsets.all(8.0),
        child: const Center(
          child: Text(
            'Tap to Animate :>',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
