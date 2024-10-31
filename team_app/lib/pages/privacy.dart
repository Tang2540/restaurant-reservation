import 'package:flutter/material.dart';
import 'package:team_app/pages/passwordpage.dart';

class PrivacyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.key),
            title: Text('Password'),
            onTap: () {
              //ทำงานเมื่อต้องการกำหนดรหัสผ่าน
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PasswordPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.phone_android),
            title: Text('Permission'),
            onTap: () {
              //การทำงานเมื่อกำหนดการเข้าถึงสิทะิ์
            },
          ),
        ],
      ),
    );
  }
}
