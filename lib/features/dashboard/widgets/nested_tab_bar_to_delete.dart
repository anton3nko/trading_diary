import 'package:flutter/material.dart';

class NestedTabBar extends StatefulWidget {
  const NestedTabBar({super.key, required this.tabs});

  final List<Widget> tabs;

  @override
  State<NestedTabBar> createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  late TabController _nestedTabController;

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _nestedTabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 35,
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(
              12,
            ),
          ),
          child: TabBar(
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  12,
                ),
              ),
              controller: _nestedTabController,
              tabs: const [
                Tab(
                  text: "Strategy",
                ),
                Tab(
                  text: "Currency Pair",
                ),
              ]),
        ),
        const SizedBox(
          height: 10,
        ),

        //Вот тут видишь, мы ему провайдим высоту, а без её указания его сложно использовать, поэтому заменим эту хуйню на IndexedStack
        //* Можешь удалить этот виджет, кста
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.3,
          child: TabBarView(
            controller: _nestedTabController,
            children: widget.tabs,
          ),
        ),
      ],
    );
  }
}
