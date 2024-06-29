part of 'landing.dart';

class LandingBottomBar extends StatefulWidget {
  const LandingBottomBar({super.key});

  @override
  State<LandingBottomBar> createState() => _LandingBottomBarState();
}

class _LandingBottomBarState extends State<LandingBottomBar> {
  void _onBottomNavTapped(int index) {
    context.read<AppBloc>().add(AppChangeBottomNavEvent(index));
  }

  @override
  Widget build(BuildContext context) {
    const List<TabItem> items = [
      TabItem(icon: Icons.home),
      TabItem(icon: Icons.search_sharp),
      TabItem(icon: Icons.play_arrow_rounded),
      TabItem(icon: Icons.chat_bubble_rounded),
      TabItem(icon: Icons.person_rounded),
    ];
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return Container(
          height: 70,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: BottomBarDefault(
            items: items,
            backgroundColor: context.theme.scaffoldBackgroundColor,
            colorSelected: context.theme.primaryColor,
            color: Colors.grey,
            // colorSelected: Colors.white,
            indexSelected: state.bottomNavIndex,
            onTap: _onBottomNavTapped,
            // top: -25,
            animated: true,
            // itemStyle: ItemStyle.circle,
            // chipStyle: const ChipStyle(drawHexagon: true),
          ),
        );
      },
    );
  }
}
