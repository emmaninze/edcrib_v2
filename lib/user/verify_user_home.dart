import 'package:flutter/material.dart';
import '../my_uyils.dart';

class VerifyPhone extends StatelessWidget {
  const VerifyPhone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VerifyUser();
  }
}

class VerifyUser extends StatelessWidget {
  final TextStyle headerStyle = TextStyle(
    color: Colors.grey.shade800,
    fontWeight: FontWeight.bold,
    fontSize: 16.0,
  );

  final TextStyle headerStyle2 = TextStyle(
    color: Colors.grey.shade700,
    fontSize: 12.0,
  );

  VerifyUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        centerTitle: true,
        title: const FlipBar(
          titleTxt: 'Verification Method',
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Let's verify your Account",
              style: headerStyle,
            ),
            const SizedBox(height: 10.0),
            Text(
              "Choose an option below",
              style: headerStyle2,
            ),
            const SizedBox(height: 100.0),
            const Text('METHOD OF VERIFICATION'),
            Card(
              margin: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 0,
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.verified_rounded),
                    title: const Text("Phone"),
                    onTap: () {},
                    trailing: const Icon(Icons.keyboard_arrow_right,
                        color: Color.fromARGB(255, 202, 202, 202), size: 30.0),
                  ),
                  _buildDivider(),
                  ListTile(
                    leading: const Icon(Icons.verified_rounded),
                    title: const Text("Passport"),
                    onTap: () {},
                    trailing: const Icon(Icons.keyboard_arrow_right,
                        color: Color.fromARGB(255, 202, 202, 202), size: 30.0),
                    enabled: false,
                  ),
                  _buildDivider(),
                  ListTile(
                    leading: const Icon(Icons.perm_identity_rounded),
                    title: const Text("Identity Card"),
                    onTap: () {},
                    trailing: const Icon(Icons.keyboard_arrow_right,
                        color: Color.fromARGB(255, 202, 202, 202), size: 30.0),
                    enabled: false,
                  ),
                  _buildDivider(),
                  ListTile(
                    leading: const Icon(Icons.file_copy_rounded),
                    title: const Text("Digital Documents"),
                    onTap: () {},
                    trailing: const Icon(Icons.keyboard_arrow_right,
                        color: Color.fromARGB(255, 202, 202, 202), size: 30.0),
                    enabled: false,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                const SizedBox(height: 200.0),
                Expanded(
                  child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Colors.cyan,
                      ),
                      onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      )),
                ),
              ],
            )
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
