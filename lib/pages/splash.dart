import 'package:firebase_auth/firebase_auth.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../utils/packs.dart';

class SplashScreen extends StatefulWidget {
  final bool alreadySeen;
  const SplashScreen({super.key, required this.alreadySeen});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? _user;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) { 
      _user = user;
    });
  }


  @override
  Widget build(BuildContext context) {
    print(_user);
    return EasySplashScreen(
      logo:Image.asset("lib/assets/routedz.png"),
      title: Text(
        "Route Dz",
        style: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      showLoader: true,
      loadingText: Text("Chargement en cours..."),
      navigator: widget.alreadySeen 
      ? _user == null
        ? LoginPage()
        : MyHomePage()
      : IntroductionScreen(),
      durationInSeconds: 5,
    );
  }
}