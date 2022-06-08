import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  final Widget childrenWidget;

  const MainLayout({
    Key? key,
    required this.childrenWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: childrenWidget,
        ),
        SizedBox(
          height: 60,
          width: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.blueGrey[100],
            ),
          ),
        )
      ],
    );
  }
}
