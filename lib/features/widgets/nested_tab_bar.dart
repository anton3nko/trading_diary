import 'package:flutter/material.dart';

class NestedTabBar extends StatefulWidget {
  List<Widget> tabs;
  NestedTabBar({required this.tabs});

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
        TabBar(
            controller: _nestedTabController,
            indicatorColor: Colors.teal,
            labelColor: Colors.teal,
            unselectedLabelColor: Colors.black54,
            isScrollable: true,
            tabs: const [
              Tab(
                text: "Strategy",
              ),
              Tab(
                text: "Currency Pair",
              ),
            ]),
        Container(
          height: MediaQuery.of(context).size.height * 0.22,
          child: TabBarView(
            controller: _nestedTabController,
            children: widget.tabs,
          ),
        ),
      ],
    );
  }
}
