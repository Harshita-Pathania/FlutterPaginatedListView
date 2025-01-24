import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFFE25E36),
            ),
            accountName: Text("ABC Company"),
            accountEmail: Text("contact@abc.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage(
                  "assets/images/img.png"
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("About Us"),
            subtitle: Text("Learn more about our company and mission"),
            trailing: Icon(Icons.arrow_forward, color: Colors.grey),
            onTap:() {

            },
          ),
          ListTile(
            leading: Icon(Icons.contact_mail),
            title: Text('Contact Us'),
            subtitle: Text('Get in touch with our support team'),
            trailing: Icon(Icons.arrow_forward, color: Colors.grey),
            onTap:() {

            },
          ),
          ListTile(
            leading: Icon(Icons.assignment),
            title: Text('Terms and Conditions'),
            subtitle: Text('Understand our terms of service'),
            trailing: Icon(Icons.arrow_forward, color: Colors.grey),
            onTap:() {

            },
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text('Privacy Policy'),
            subtitle: Text('How we protect your personal data'),
            trailing: Icon(Icons.arrow_forward, color: Colors.grey),
            onTap:() {

            },
          ),
          ListTile(
            leading: Icon(Icons.money_off),
            title: Text('Refund Policy'),
            subtitle: Text('Learn about our refund policy'),
            trailing: Icon(Icons.arrow_forward, color: Colors.grey),
            onTap:() {

            },
          ),
          ListTile(
            leading: Icon(Icons.delete_forever),
            title: Text('User Data Deletion Policy'),
            subtitle: Text('Understand how to delete your data'),
            trailing: Icon(Icons.arrow_forward, color: Colors.grey),
            onTap:() {

            },
          )
        ],
      ),
    );
  }
}
