import 'package:RouteDz/views/profile.dart';

import 'utils/packs.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


Future<void> main(List<String> args) async {

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool alreadySeen = prefs.getBool('alreadySeen') ?? false;

  runApp(ResponsiveSizer(
    builder: (context, orientation, screenT) {
      return GetMaterialApp(      
        debugShowCheckedModeBanner: false,
        //home: SplashScreen(alreadySeen : alreadySeen),
        home: MyProfilePage(),
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
    Container(), // Null 
    const SettingsPage(),
  ];

  void _onItemTapped(int index) {
    if (index == 1){
      Get.to(SignalerForm());
    }else{
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        child: _pages.elementAt(_selectedIndex),
      )),
      bottomNavigationBar: SizedBox(
        height: 10.h,
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
          iconSize: 23.sp,
          selectedFontSize: 14.sp,
          unselectedFontSize: 14.sp,
          items: <BottomNavigationBarItem>[
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
