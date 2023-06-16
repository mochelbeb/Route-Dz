import 'package:RouteDz/views/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'utils/packs.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main(List<String> args) async {

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  bool alreadySeen = prefs.getBool('alreadySeen') ?? false;
  
  var logger = Logger(
    filter: null,
    printer: PrettyPrinter(
      printEmojis: true,
    ),
    output: null,
  );

  runApp(ResponsiveSizer(
    builder: (context, orientation, screenT) {
      return GetMaterialApp(      
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        home: SplashScreen(alreadySeen : alreadySeen),
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
      print(FirebaseAuth.instance.currentUser);
      if(FirebaseAuth.instance.currentUser == null){
        Get.defaultDialog(
          title: "Utilisateur non connecté",
          content: Text('vous devez vous connecter pour signaler un nouveau point noir'),
          actions: [
            TextButton(onPressed: (){Get.back();}, child: Text("Cancel")),
            TextButton(onPressed: (){Get.to(LoginPage());}, child: Text("Login"))
          ]
        );
      }
      else{
        Get.to(SignalerForm());
      }
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
          selectedItemColor: const Color(0xff5e81f4),
          unselectedItemColor: const Color.fromRGBO(77, 77, 89, 1.0),
          unselectedLabelStyle: const TextStyle(
              color: Color.fromRGBO(77, 77, 89, 1.0),
              fontFamily: "Roboto",
              fontWeight: FontWeight.normal),
          selectedLabelStyle: const TextStyle(
              color: Color(0xff5e81f4),
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
