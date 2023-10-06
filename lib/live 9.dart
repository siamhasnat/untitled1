import 'package:flutter/material.dart';

void main() {
  runApp(SizeSelectorApp());
}

class SizeSelectorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SizeSelectorScreen(),
    );
  }
}

class SizeSelectorScreen extends StatefulWidget {
  @override
  _SizeSelectorScreenState createState() => _SizeSelectorScreenState();
}

class _SizeSelectorScreenState extends State<SizeSelectorScreen> {
  String selectedSize = '';

  void _selectSize(String size) {
    setState(() {
      selectedSize = size;
    });

    // Show Snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Selected Size: $size'),
      ),
    );
  }

  Widget _buildSizeButton(String size) {
    final isSelected = selectedSize == size;
    return ElevatedButton(
      onPressed: () => _selectSize(size),
      style: ElevatedButton.styleFrom(
        primary: isSelected ? Colors.orange : null,
        padding: EdgeInsets.all(16.0), // Increase the button padding for a larger button
        textStyle: TextStyle(fontSize: 20.0), // Increase the font size
      ),
      child: Text(size),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Size Selector App'),
        centerTitle: true, // Center the title text
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSizeButton('S'),
                SizedBox(width: 16),
                _buildSizeButton('M'),
                SizedBox(width: 16),
                _buildSizeButton('L'),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSizeButton('XL'),
                SizedBox(width: 16),
                _buildSizeButton('XXL'),
                SizedBox(width: 16),
                _buildSizeButton('XXXL'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
