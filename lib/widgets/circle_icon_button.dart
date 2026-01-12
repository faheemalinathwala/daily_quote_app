import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircleIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;

  const CircleIconButton({
    required this.icon,
    required this.onTap,
  });

  @override
  State<CircleIconButton> createState() => CircleIconButtonState();
}

class CircleIconButtonState extends State<CircleIconButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
        child: Icon(widget.icon, color: Colors.white, size: 20),
      ),
    );
  }
}
