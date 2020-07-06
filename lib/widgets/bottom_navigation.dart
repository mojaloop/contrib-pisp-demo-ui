import 'package:flutter/material.dart';
import 'package:pispapp/theme/light_color.dart';

class BottomNavigationButton {
  BottomNavigationButton(this.icon, this.widget);

  IconData icon;
  Widget widget;
}

class BottomNavigation extends StatefulWidget {
  BottomNavigation(this.buttons, this.rootWidgetChange);

  final List<BottomNavigationButton> buttons;
  final void Function(Widget) rootWidgetChange;

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _index = 0;

  BottomNavigationBarItem _icons(IconData icon) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
      ),
      title: Text(
        '',
      ),
    );
  }

  void _onItemTapped(int index) {
    widget.rootWidgetChange(widget.buttons[index].widget);
    setState(
      () {
        _index = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showUnselectedLabels: true,
      showSelectedLabels: true,
      selectedItemColor: LightColor.navyBlue2,
      unselectedItemColor: LightColor.grey,
      currentIndex: _index,
      items: widget.buttons.map((e) => _icons(e.icon)).toList(),
      onTap: _onItemTapped,
    );
  }
}
