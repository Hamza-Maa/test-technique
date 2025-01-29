import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;
  final Widget body;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.body,
  });

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomBar(
      width: MediaQuery.of(context).size.width * 0.7,
      borderRadius: BorderRadius.circular(24),
      barColor: Colors.white,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      showIcon: false,
      body: (context, controller) => widget.body,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavBarItem(
            icon: Icons.home_outlined,
            label: "Accueil",
            isSelected: widget.currentIndex == 0,
            onTap: () => widget.onTap(0),
          ),
          _buildNavBarItem(
            icon: Icons.bookmark_outline,
            label: "Favoris",
            isSelected: widget.currentIndex == 1,
            onTap: () => widget.onTap(1),
          ),
        ],
      ),
    );
  }

  Widget _buildNavBarItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isSelected)
            Container(
              width: 30,
              height: 4,
              margin: const EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          Icon(
            icon,
            color: isSelected ? Colors.green : Colors.black,
          ),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.green : Colors.black,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
