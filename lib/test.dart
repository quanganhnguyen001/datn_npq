import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hover Icon Demo',
      home: HoverIconDemo(),
    );
  }
}

class HoverIconDemo extends StatefulWidget {
  @override
  _HoverIconDemoState createState() => _HoverIconDemoState();
}

class _HoverIconDemoState extends State<HoverIconDemo> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hover Icon Demo'),
      ),
      body: Center(
        child: MouseRegion(
          onEnter: (_) {
            setState(() {
              _hovering = true;
            });
          },
          onExit: (_) {
            setState(() {
              _hovering = false;
            });
          },
          child: Stack(
            children: [
              Image.asset(
                'assets/images/glass.jpg', // Replace with your image path
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              ),
              AnimatedOpacity(
                duration: Duration(milliseconds: 200),
                opacity: _hovering ? 1.0 : 0.0,
                child: Container(
                  width: 300,
                  height: 300,
                  color: Colors.black
                      .withOpacity(0.5), // Adjust the color and opacity here
                  child: Center(
                    child: Icon(
                      Icons.play_circle_fill, // Replace with your icon
                      size: 50,
                      color: Colors.white,
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
