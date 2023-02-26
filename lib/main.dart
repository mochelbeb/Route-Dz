import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tariki/views/home.dart';
import 'package:tariki/views/settings.dart';
import 'package:tariki/views/signaler.dart';

void main(List<String> args) {
  runApp(ResponsiveSizer(
    builder: (context, orientation, screenT) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      );
    },
  ));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final List<Widget> _pages = <Widget>[
    HomePage(),
    const SignalerPage(),
    const SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        child: _pages.elementAt(_selectedIndex),
      )),
      bottomNavigationBar: SizedBox(
        height: 11.h,
        child: BottomNavigationBar(
          selectedItemColor: const Color.fromRGBO(94, 129, 244, 1.0),
          unselectedItemColor: const Color.fromRGBO(77, 77, 89, 1.0),
          unselectedLabelStyle: const TextStyle(
              color: Color.fromRGBO(77, 77, 89, 1.0),
              fontFamily: "Roboto",
              fontWeight: FontWeight.normal),
          selectedLabelStyle: const TextStyle(
              color: Color.fromRGBO(94, 129, 244, 1.0),
              fontFamily: "Roboto",
              fontWeight: FontWeight.w500),
          iconSize: 25.sp,
          selectedFontSize: 16.sp,
          unselectedFontSize: 16.sp,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(LineIcons.home), // change it
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: Icon(LineIcons.plusCircle), // change it
              label: 'Signaler',
            ),
            BottomNavigationBarItem(
              icon: Icon(LineIcons.cog), // change it
              label: 'Parametres',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
