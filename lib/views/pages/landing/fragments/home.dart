import 'package:flutter/material.dart';
import 'package:ulearning_app/utils/extentions/index.dart';
import 'package:ulearning_app/views/widgets/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RichText(
          text: const TextSpan(
            text: 'Welcome to ',
            style: const TextStyle(
              fontSize: 10,
              color: Colors.black,
              leadingDistribution: TextLeadingDistribution.proportional,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'Ulearning',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    ).showDraggableWidget(const ThemeSwitch());
  }
}
