import 'package:responsive_sizer/responsive_sizer.dart';
import '../utils/packs.dart';

class SplashScreen extends StatefulWidget {
  final bool alreadySeen;
  const SplashScreen({super.key, required this.alreadySeen});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
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
      navigator: widget.alreadySeen ? LoginPage() : IntroductionScreen(),
      durationInSeconds: 5,
    );
  }
}