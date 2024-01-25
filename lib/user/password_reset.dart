import 'package:flutter/material.dart';
import '../my_uyils.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  final _formKey = GlobalKey<FormState>();
  void reset() {
    if (_formKey.currentState!.validate()) {
      _showMaterialDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Flipt<>',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(
            height: 2.0,
          ),
          Text(
            'Building a reliable future',
            style: TextStyle(
              fontSize: 10.0,
              color: Color.fromARGB(255, 75, 53, 45),
            ),
          )
        ],
      )),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 25.0,
                left: 35.0,
                right: 35.0,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x34ADFFFF),
                          blurRadius: 50.0,
                          blurStyle: BlurStyle.outer,
                        ),
                        // BoxShadow(
                        //   color: Color(0x525790FA),
                        //   blurRadius: 50.0,
                        //   blurStyle: BlurStyle.outer,
                        // ),
                      ],
                      color: const Color.fromARGB(255, 209, 217, 224)
                          .withAlpha(100),
                      borderRadius: BorderRadiusDirectional.circular(
                        15.0,
                      ),
                      // gradient: LinearGradient(
                      //   begin: Alignment.bottomLeft,
                      //   end: Alignment.centerRight,
                      //   colors: [
                      //     Colors.blue.shade700,
                      //     Colors.teal.shade500,
                      //   ],
                      // ),
                    ),
                    padding: const EdgeInsets.all(20.0),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      'Please enter the email address associated with your account to submit for resetting your password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueGrey.shade700,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'user@gmail.com',
                      prefixIcon: Icon(
                        Icons.email_outlined,
                      ),
                      labelText: 'Email*',
                      labelStyle: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                      // filled: true,
                      // hoverColor: Colors.lightBlueAccent.withAlpha(20),
                      // enabledBorder: const OutlineInputBorder(
                      //   borderSide: BorderSide(
                      //     color: Color(0x325161ff),
                      //     width: 2.0,
                      //     style: BorderStyle.solid,
                      //   ),
                      // ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(3),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 100.0,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: FormButton(
                      text: "Submit",
                      onPressed: reset,
                    ),
                    // child: ElevatedButton(
                    //   child: const Text(
                    //     'Submit',
                    //     style: TextStyle(
                    //       fontWeight: FontWeight.w500,
                    //       letterSpacing: 0.8,
                    //     ),
                    //   ),
                    //   onPressed: () {
                    //     if (_formKey.currentState!.validate()) {
                    //       _showMaterialDialog();
                    //     }
                    //   },
                    //   style: ButtonStyle(
                    //     backgroundColor: MaterialStateProperty.all<Color>(
                    //       Colors.lightBlue.shade300,
                    //     ),
                    //     shadowColor: MaterialStateProperty.all<Color>(
                    //       Colors.blueGrey,
                    //     ),
                    //   ),
                    // ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMaterialDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Notification'),
          content: const Text(
              'Successfully! Check the verify code for reset your password on your Email.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _dismissDialog();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  _dismissDialog() {
    Navigator.pop(context);
  }
}
