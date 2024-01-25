import '../user/profile.dart';
import 'package:flutter/material.dart';
import '../my_uyils.dart';

class Settings extends StatelessWidget {
  final TextStyle headerStyle = TextStyle(
    color: Colors.grey.shade800,
    fontWeight: FontWeight.bold,
    fontSize: 16.0,
  );

  final TextStyle headerStyle2 = TextStyle(
    color: Colors.grey.shade800,
    fontWeight: FontWeight.bold,
    fontSize: 13.0,
  );

  Settings({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[50],
      appBar: AppBar(
        centerTitle: true,
        title: const FlipBar(
          titleTxt: 'Settings',
        ),
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 158, 158, 158),
        ),
        backgroundColor: Colors.black,
      ),
      bottomNavigationBar: const FlipBottomNav(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Profile Settings",
              style: headerStyle,
            ),
            const SizedBox(height: 10.0),
            Card(
              elevation: 0.5,
              margin: const EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 0,
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.verified_user,
                    ),
                    title: const Text("Edit Profile"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ProfileSettings()));
                    },
                    trailing: const Icon(Icons.keyboard_arrow_right,
                        color: Color.fromARGB(255, 202, 202, 202), size: 10.0),
                  ),
                  ListTile(
                    leading: const Icon(Icons.payment),
                    title: const Text("Billing (My Cards)"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ProfileSettings()));
                    },
                    trailing: const Icon(Icons.keyboard_arrow_right,
                        color: Color.fromARGB(255, 202, 202, 202), size: 10.0),
                  ),
                  ListTile(
                    leading: const Icon(Icons.account_balance),
                    title: const Text("Bank Account"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ProfileSettings()));
                    },
                    trailing: const Icon(Icons.keyboard_arrow_right,
                        color: Color.fromARGB(255, 202, 202, 202), size: 10.0),
                  ),

                  //   title: const Text("Damodar Lohani"),
                  //   onTap: () {},
                  // ),
                  // _buildDivider(),
                  // SwitchListTile(
                  //   activeColor: Colors.purple,
                  //   value: true,
                  //   title: const Text("Private Account"),
                  //   onChanged: (val) {},
                  // ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Card(
                margin: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 0,
                ),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(
                        Icons.payment_rounded,
                      ),
                      title: const Text("Change PIN"),
                      onTap: () {},
                      trailing: const Icon(Icons.keyboard_arrow_right,
                          color: Color.fromARGB(255, 202, 202, 202),
                          size: 30.0),
                    ),
                    _buildDivider(),
                    ListTile(
                      leading: const Icon(
                        Icons.support_agent_rounded,
                      ),
                      title: const Text("FAQ & Support"),
                      onTap: () {},
                      trailing: const Icon(Icons.keyboard_arrow_right,
                          color: Color.fromARGB(255, 202, 202, 202),
                          size: 30.0),
                    ),
                    _buildDivider(),
                    ListTile(
                      leading: const Icon(
                        Icons.info,
                      ),
                      title: const Text("About"),
                      onTap: () {},
                      trailing: const Icon(Icons.keyboard_arrow_right,
                          color: Color.fromARGB(255, 202, 202, 202),
                          size: 30.0),
                    ),
                  ],
                )),
            const SizedBox(height: 20.0),
            Card(
              margin: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 0,
              ),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(
                      Icons.language_rounded,
                    ),
                    title: const Text("Language"),
                    onTap: () {},
                    trailing: const Icon(Icons.keyboard_arrow_right,
                        color: Color.fromARGB(255, 202, 202, 202), size: 30.0),
                  ),
                  _buildDivider(),
                  SwitchListTile(
                    activeColor: Colors.black,
                    value: true,
                    title: const Row(
                      children: [
                        Icon(Icons.notification_add_rounded),
                        SizedBox(
                          width: 26.0,
                        ),
                        Text("Receive notification"),
                      ],
                    ),
                    onChanged: (val) {},
                  ),
                  _buildDivider(),
                  const SwitchListTile(
                    activeColor: Colors.black,
                    value: true,
                    title: Row(
                      children: [
                        Icon(Icons.contrast_rounded),
                        SizedBox(
                          width: 26.0,
                        ),
                        Text("Datk Mode"),
                      ],
                    ),
                    onChanged: null,
                  ),
                  _buildDivider(),
                ],
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 0,
              ),
              child: ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text("Logout"),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 60.0),
          ],
        ),
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade300,
    );
  }
}
