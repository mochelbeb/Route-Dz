import 'package:responsive_sizer/responsive_sizer.dart';
import '../utils/packs.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

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
                  image: DecorationImage(image: AssetImage("lib/assets/image2.png"),fit: BoxFit.fill)
                ),
              ),
            ),
            // $$ Title
            Padding(padding: EdgeInsets.fromLTRB(20, 40, 0, 10),child: Text("Protegez vous",style: Styles.title,),),
            // $$ Descriptions
            Padding(padding: EdgeInsets.fromLTRB(20, 10, 20, 0),child: Text("Prenez precaution en consultant les \nsignalement  sur Route DZ , connaitre les \nconditions de la route à l'avance, peut \nvous aidez a prendre le meilleur chemin \npour  arriver à votre  destination en toute \nsécurité et à temps.",style: Styles.textStyle,),)
        ],
      )
    );
  }
}