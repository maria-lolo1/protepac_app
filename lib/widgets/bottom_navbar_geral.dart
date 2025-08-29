import 'package:flutter/material.dart';

class CustomBottomNavBarGeral extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CustomBottomNavBarGeral({
    Key? key,
    required this.selectedIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor, // muda conforme claro/escuro
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 140, // ajuste para caber "Manifestações"
            child: _buildNavItem(
              context: context,
              icon: Icons.list_alt_rounded,
              label: 'Manifestações',
              selected: selectedIndex == 0,
              onTap: () => onTap(0),
            ),
          ),
          const SizedBox(width: 24),
          SizedBox(
            width: 140,
            child: _buildNavItem(
              context: context,
              icon: Icons.logout,
              label: 'Sair',
              selected: selectedIndex == 1,
              onTap: () => onTap(1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final selectedColor =
        theme.colorScheme.primary; // azul no claro, laranja no escuro
    final unselectedColor = Colors.grey; // pode mudar também p/ theme.hintColor

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
              color: selected ? selectedColor : unselectedColor,
            ),
            const SizedBox(height: 1),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
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
