import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/blocs/auth/providers/providers.dart';
import 'package:ulearning_app/blocs/index.dart';
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
      appBar: _buildAppbar(context),
      body: Column(
        children: [
          Center(
            child: RichText(
              text: const TextSpan(
                text: 'Welcome to ',
                style: TextStyle(
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
          TextButton(
              onPressed: () => context
                  .read<AuthBloc>()
                  .add(AuthLogoutSubmitted(GoogleAuth())),
              child: const Text('Logout'))
        ],
      ),
    ).showDraggableWidget(const ThemeSwitch());
  }

  PreferredSize _buildAppbar(BuildContext context) {
    return buildAppbar(
      context,
      transparent: true,
      leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
      theme: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.person),
        ),
      ],
    );
  }
}
