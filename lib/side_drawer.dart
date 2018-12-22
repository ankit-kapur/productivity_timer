import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Configure',
              style: TextStyle(fontSize: 28.0),
            ),
            decoration: BoxDecoration(
                 color: Theme.of(context).backgroundColor,
                 image: DecorationImage(
                      image: ExactAssetImage('images/tomato1.jpg'),
                      fit: BoxFit.cover,
                 ),
                 border: Border.all(
                      color: Colors.black,
                      width: 5.0,
                 ),
            ),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
