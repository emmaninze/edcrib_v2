import 'package:flutter/material.dart';

class ErrPage extends StatefulWidget {
  final msg;
  const ErrPage({Key? key, required this.msg}) : super(key: key);

  @override
  State<ErrPage> createState() => _ErrPageState();
}

class _ErrPageState extends State<ErrPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Expanded(
          child: IntrinsicHeight(
            child: Container(
              // A fixed-height child.
              color: const Color(0xffeeee00), // Yellow
              height: 120.0,
              alignment: Alignment.center,
              child: Text(widget.msg),
            ),
          ),
        ),
      ),
    );
  }
}
