import 'package:chat_app/pages/setting_page.dart';
import 'package:flutter/material.dart';

import '../auth/auth_service.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout(){
    // get auth service
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // logo

            Column(
              children: [
                DrawerHeader(
                  child: Center(
                    child: Icon(
                      Icons.message,
                      color: Theme.of(context).colorScheme.primary,
                      size: 40,
                    ),
                  ),
                ),

                // home list title
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    title: const Text('HOME'),
                    leading: const Icon(Icons.home),
                    onTap: () {
                      // pop the drawer
                      Navigator.pop(context);
                    },
                  ),
                ),

                // setting list tile
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    title: const Text('SETTINGS'),
                    leading: const Icon(Icons.settings),
                    onTap: () {
                      // pop the drawer
                      Navigator.pop(context);

                      // navigate to seetings page
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SettingPage(),
                          ),
                      );
                    },
                  ),
                ),
              ],
            ),

          // logout list tile
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25),
            child: ListTile(
              title: const Text('LOGOUT'),
              leading: const Icon(Icons.logout),
              onTap: logout,
            ),
          ),

        ],
      ),
    );

  }
}
