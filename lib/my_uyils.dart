import 'dart:convert';
import 'package:flutter/material.dart';

class FlipBar extends StatelessWidget {
  const FlipBar({Key? key, this.titleTxt}) : super(key: key);
  final String? titleTxt;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titleTxt!,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            )),
        const SizedBox(
          height: 2.0,
        ),
        const Text(
          'Building a reliable future',
          style: TextStyle(
            fontSize: 10.0,
            color: Colors.grey,
          ),
        )
      ],
    );
  }
}

class FlipBottomNav extends StatelessWidget {
  const FlipBottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedItemColor: Colors.grey[500],
      selectedItemColor: Colors.black,
      showSelectedLabels: false,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: InkWell(
              onTap: () {
                // Navigator.push(
                //     context, MaterialPageRoute(builder: (_) => Home()));
              },
              child: const Icon(Icons.dashboard)),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: InkWell(
              onTap: (() {
                // Navigator.push(
                //     context, MaterialPageRoute(builder: (_) => Portfolio()));
              }),
              child: const Icon(Icons.folder)),
          label: 'Portfolio',
        ),
        BottomNavigationBarItem(
          icon: InkWell(
            onTap: (() {
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (_) => Rewards()));
            }),
            child: const Icon(Icons.star_rate),
          ),
          label: 'Rewards',
        ),
        BottomNavigationBarItem(
          icon: InkWell(
            onTap: (() {
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (_) => Settings()));
            }),
            child: const Icon(Icons.settings),
          ),
          label: 'Settings',
        )
      ],
    );
  }
}

class FormButton extends StatelessWidget {
  final String text;
  final Function? onPressed;
  const FormButton({this.text = "", this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //double screenHeight = MediaQuery.of(context).size.height;

    return ElevatedButton(
      onPressed: onPressed as void Function()?,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}

class PageBtns extends StatelessWidget {
  const PageBtns({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.grey[800],
            child: IconButton(
                color: Colors.white,
                onPressed: () {},
                icon: const Icon(
                  Icons.phone,
                )),
          ),
        ),
        const SizedBox(
          width: 2,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.grey[800],
            child: IconButton(
                color: Colors.white,
                onPressed: () {},
                icon: const Icon(Icons.wifi)),
          ),
        ),
        const SizedBox(
          width: 2,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.grey[800],
            child: IconButton(
                color: Colors.white,
                onPressed: () {},
                icon: const Icon(
                  Icons.history,
                )),
          ),
        ),
        const SizedBox(
          width: 2,
        ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Container(
        //     color: Colors.grey[800],
        //     child: IconButton(
        //         color: Colors.white,
        //         onPressed: () {},
        //         icon: const Icon(Icons.share)),
        //   ),
        // ),
        // SizedBox(
        //   height: 15,
        // )
      ],
    );
  }
}

class SchoolUrl {
  SchoolUrl({
    required this.url,
    required this.name,
  });

  late final String url;
  late final String name;

  SchoolUrl.fromJson(Map<String, dynamic> json) {
    url = json['url']!;
    name = json['name']!;
  }

  static Map<String, dynamic> toMap(SchoolUrl sch) => {
        'url': sch.url,
        'name': sch.name,
      };

  static String encode(List<SchoolUrl> schs) => json.encode(
        schs.map<Map<String, dynamic>>((sch) => SchoolUrl.toMap(sch)).toList(),
      );

  static List<SchoolUrl> decode(String schs) =>
      (json.decode(schs) as List<dynamic>)
          .map<SchoolUrl>((item) => SchoolUrl.fromJson(item))
          .toList();

  // @override
  // String toString() {
  //   return '$name, $url';
  // }
}
