import '../utils/packs.dart';


class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {

  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  final List<Widget> _pages = [Page1(),Page2(),Page3()];
  bool _enabled = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // $$ Pages
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
              _currentPage = page;
              if (_currentPage == _pages.length -1) _enabled = true;
              });
            },
            children: _pages,
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // ! Indicators
                PageViewDotIndicator(
                  currentItem: _currentPage,
                  count: _pages.length,
                  unselectedColor: Colors.black26,
                  selectedColor: Colors.blue,
                ),
                const SizedBox(height: 16),
                // ! Get Started
                ElevatedButton(
                  child: Text('Commencer'),
                  onPressed: _enabled ? () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('alreadySeen', true);
                    Get.to(LoginPage());
                  }
                  : null,
                ),  
              ]
            )
          )
        ],
      ),
    );
  }
}