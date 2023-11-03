import 'package:flutter/material.dart';

class NestedTabBar extends StatefulWidget {
  final List<Widget> tabs;
  const NestedTabBar({super.key, required this.tabs});

  @override
  State<NestedTabBar> createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  late TabController _nestedTabController;

  @override
  void initState() {
    super.initState();
    _nestedTabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 35,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(
                0xFFE8E8E8,
              ),
            ),
            borderRadius: BorderRadius.circular(
              12,
            ),
            color: const Color(
              0xFFF6F6F6,
            ),
          ),
          child: TabBar(
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  12,
                ),
                color: Colors.white,
              ),
              controller: _nestedTabController,
              labelColor: Colors.black,
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
