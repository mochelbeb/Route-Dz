import 'package:responsive_sizer/responsive_sizer.dart';
import '../utils/packs.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipPath(
              clipper: MyShape(),
              child: Container(
                width: double.infinity,
                height: 50.h,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("lib/assets/image1.png"),fit: BoxFit.fill)
                ),
              ),
            ),
            // $$ Title
            Padding(padding: EdgeInsets.fromLTRB(20, 40, 0, 10),child: Text("Aidez",style: Styles.title,),),
            // $$ Descriptions
            Padding(padding: EdgeInsets.fromLTRB(20, 10, 20, 0),child: Text("En signalant les problemes routiers aux \nautorités locales peut aider à prévenir \nles accidents et à maintenir les routes \nen bon état. ",style: Styles.textStyle,),)
        ],
      )
    );
  }
}
