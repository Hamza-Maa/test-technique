import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import '../../utils/colors.dart';

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
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.3),
            spreadRadius: 0.5,
            blurRadius: 8,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: BottomBar(
        width: MediaQuery.of(context).size.width * 0.55,
        borderRadius: BorderRadius.circular(10),
        barColor: AppColors.whiteColor,
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
              height: 5,
              margin: const EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: AppColors.primaryColor.withOpacity(0.2),
                        spreadRadius: 0.1,
                        blurRadius: 0.5,
                      ),
                    ]
                  : [],
            ),
            child: Icon(
              icon,
              color: isSelected ? AppColors.primaryColor : Colors.black,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? AppColors.primaryColor : Colors.black,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
