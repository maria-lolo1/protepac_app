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
    const azul = Color(0xFF181883);
    const unselectedColor = Colors.grey;

    return Container(
      height: 50,
      decoration: const BoxDecoration(
        color: Colors.white, // ✅ sempre branco
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
    const azul = Color(0xFF181883);
    const unselectedColor = Colors.grey;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24,
              color: selected ? azul : unselectedColor, // ✅ fixado
            ),
            const SizedBox(height: 1),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                color: selected ? azul : unselectedColor, // ✅ fixado
              ),
            ),
          ],
        ),
      ),
    );
  }
}
