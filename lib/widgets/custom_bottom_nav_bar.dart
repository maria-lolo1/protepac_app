import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60, // <-- MUDE AQUI a altura da barra como quiser!
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            icon: Icons.home_rounded,
            label: 'Home',
            selected: selectedIndex == 0,
            onTap: () => onTap(0),
          ),
          _buildNavItem(
            icon: Icons.list_alt_rounded,
            label: 'Manifestações',
            selected: selectedIndex == 1,
            onTap: () => onTap(1),
          ),
          _buildNavItem(
            icon: Icons.person_rounded,
            label: 'Perfil',
            selected: selectedIndex == 2,
            onTap: () => onTap(2),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    final selectedColor = Color(0xFF181883);
    final unselectedColor = Color(0xFFB0B0B0);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 27,
              color: selected ? selectedColor : unselectedColor,
            ),
            SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                color: selected ? selectedColor : unselectedColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
