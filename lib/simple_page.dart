import 'package:flutter/material.dart';

class SimplePage extends StatefulWidget {
  final Function onPressMenu;
  const SimplePage({Key key, @required this.onPressMenu}) : super(key: key);
  @override
  _SimplePageState createState() => _SimplePageState();
}

class _SimplePageState extends State<SimplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(),
          child: Column(
            children: <Widget>[
              SizedBox(height: 50),
              Container(
                height: 200,
                child: PageView(
                  controller: PageController(viewportFraction: 0.8),
                  scrollDirection: Axis.horizontal,
                  pageSnapping: true,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      color: Colors.redAccent,
                      width: 100,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      color: Colors.purpleAccent,
                      width: 100,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      color: Colors.orangeAccent,
                      width: 100,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text("Transactions",
                  style: TextStyle(color: Colors.black, fontSize: 20)),
              ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("Macbook"),
                      subtitle: Text("Apple"),
                      trailing: Text("-2900"),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(height: 16);
                  },
                  itemCount: 10)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: widget.onPressMenu,
        icon: Icon(Icons.menu),
      ),
      title: Text("Simple Page"),
      actions: <Widget>[
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.settings),
        ),
      ],
    );
  }
}
