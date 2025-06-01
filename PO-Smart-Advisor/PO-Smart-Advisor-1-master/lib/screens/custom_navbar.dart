import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class CustomNavBarWidget extends StatelessWidget {
  final List<PersistentBottomNavBarItem> items;
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const CustomNavBarWidget({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor =
        items[selectedIndex].activeColorSecondary ?? Colors.white;

    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final bool isSelected = index == selectedIndex;

          return GestureDetector(
            onTap: () => onItemSelected(index),
            behavior: HitTestBehavior.translucent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon(
                //   item.icon.icon,
                //   color: isSelected
                //       ? item.activeColorPrimary
                //       : item.inactiveColorPrimary,
                // ),
                const SizedBox(height: 4),
                Text(
                  item.title ?? '',
                  style: item.textStyle?.copyWith(
                        color: isSelected
                            ? item.activeColorPrimary
                            : item.inactiveColorPrimary,
                      ) ??
                      TextStyle(
                        color: isSelected
                            ? item.activeColorPrimary
                            : item.inactiveColorPrimary,
                        fontSize: 12,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
