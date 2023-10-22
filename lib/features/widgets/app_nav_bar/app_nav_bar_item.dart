import 'package:flutter/material.dart';

class AppNavBarItem extends StatelessWidget {
  final bool isActive;
  final IconData iconSrc;
  final Function onTap;
  final String label;

  const AppNavBarItem({
    super.key,
    required this.isActive,
    required this.iconSrc,
    required this.onTap,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => onTap(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconSrc,
                color: isActive ? Colors.black : Colors.grey, size: 24),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.black : Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
