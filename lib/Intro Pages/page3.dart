import 'package:responsive_sizer/responsive_sizer.dart';
import '../utils/packs.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

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
                  image: DecorationImage(image: AssetImage("lib/assets/image3.png"),fit: BoxFit.fill)
                ),
              ),
            ),
            // $$ Title
            Padding(padding: EdgeInsets.fromLTRB(20, 40, 0, 10),child: Text("Travaillons tous ensemble",style: Styles.title,),),
            // $$ Descriptions
            Padding(padding: EdgeInsets.fromLTRB(20, 10, 20, 0),child: Text("Pour un trajet plus sur , un quotidien plus \nserien ",style: Styles.textStyle,),)
        ],
      )
    );
  }
}