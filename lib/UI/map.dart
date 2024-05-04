import 'package:flood/UI/homescreen.dart';
import 'package:flutter/material.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  int _selectedIndex = 0;
  String _currentImage = 'images/MapSafeZones.png'; // Initial image

  TransformationController _controller = TransformationController();

  @override
  void initState() {
    super.initState();
    // Set initial scale more dynamically
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.value = Matrix4.identity()
        ..scale(1.5); // Adjusted for better initial fit
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _handleMenuSelection(String choice) {
    setState(() {
      if (choice == 'Option 2') {
        _currentImage =
            'images/HotzoneMap.png'; // Change to new image on selection of Option 2
      } else {
        _currentImage =
            'images/MapSafeZones.png'; // Revert to original or handle other options
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Interactive Map Viewer'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Color(0xFF263DA8), Color(0xFF0E1A68)],
          ),
        ),
        child: Stack(
          children: [
            InteractiveViewer(
              transformationController: _controller,
              boundaryMargin: EdgeInsets.zero,
              minScale: 0.1,
              maxScale: 4.0,
              constrained: false,
              child: Image.asset(
                _currentImage,
                fit: BoxFit
                    .cover, // Ensuring the image covers the area, adjust as needed
              ),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: PopupMenuButton<String>(
                onSelected: _handleMenuSelection,
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'Option 1',
                    child: Text('Option 1'),
                  ),
                  PopupMenuItem<String>(
                    value: 'Option 2',
                    child: Text('Option 2'),
                  ),
                ],
                icon: Icon(Icons.menu, size: 30, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
