import 'package:custom_sidebar/simple_page.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      backgroundColor: Color(0xFF4A4A58),
      body: Stack(
        children: <Widget>[
          buildMenuBody(),
          buildDashboard(),
        ],
      ),
    );
  }

  Widget buildDashboard() {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenWidth,
      right: isCollapsed ? 0 : -0.2 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          elevation: 8,
          child: SimplePage(
            onPressMenu: () {
              setState(() {
                if (isCollapsed)
                  _controller.forward();
                else
                  _controller.reverse();

                isCollapsed = !isCollapsed;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget buildMenuBody() {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              buildMenuItems('Dashboard'),
              SizedBox(height: 10),
              buildMenuItems('Messages'),
              SizedBox(height: 10),
              buildMenuItems('Utility Bills'),
              SizedBox(height: 10),
              buildMenuItems('Funds Transfer'),
              SizedBox(height: 10),
              buildMenuItems('Branches'),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItems(String name) {
    return Text(name, style: TextStyle(color: Colors.white, fontSize: 22));
  }
}
