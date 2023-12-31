import 'package:flutter/cupertino.dart';

class SliAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const SliAppBarWidget({super.key, required this.child, required this.controller, required this.visible});

  final PreferredSizeWidget child;
  final AnimationController controller;
  final bool visible;

  @override
  // TODO: implement preferredSize
  Size get preferredSize => child.preferredSize;

  @override
  Widget build(BuildContext context) {
    visible ? controller.reverse() : controller.forward();
    return SlideTransition(
      position: Tween<Offset>(begin: Offset.zero,end: Offset(0,-1)).animate(
            CurvedAnimation(
                parent: controller,
                curve: Curves.fastOutSlowIn
            )
        ),
      child: child,
    );
  }
}


