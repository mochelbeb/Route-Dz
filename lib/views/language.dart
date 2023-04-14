import '../utils/packs.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:gap/gap.dart';

class Languagepage extends StatelessWidget {
  const Languagepage({Key? key}) : super(key: key);
   Languagepage createState() => new Languagepage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 5,
        leading: IconButton(
          icon: FaIcon(
            FontAwesomeIcons.arrowLeft,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "Langue de l'application",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(children: [
        const Gap(10),
        Row(children: [
          const Gap(10),
          Icon(
            FontAwesomeIcons.globe,
            size: 20,
            color: Colors.blue,
          ),
          const Gap(5),
          Text(
            "Suggestions",
            style: TextStyle(fontSize: 20, color: Colors.blue),
          )
        ]),
        const Gap(10),
        Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                Get.defaultDialog(
                    title: "Parametre systeme par defaut vers francais ",
                    content: Column(
                      children: [
                        Text(
                            "  - Etes vous sure de vouloir changer la langue en Francais ",textAlign: TextAlign.center,),
                        
                      ],
                    ),
                    cancel: TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text("oui")));
              },
              child: Text('francais'),
            ),
          ),
        ),
        const Gap(10),
        Center(
          child: Container(
            
            
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: ElevatedButton(
              
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () { 
                
                Get.defaultDialog(
                    title: "Parametre systeme par defaut vers English ",
                    content: Column(
                      
                      children: [
                        
                        Text(
                            " - Etes vous sure de vouloir changer la langue en Anglais  ",textAlign: TextAlign.center,),
                        Text(
                            " - Are you sure you want to change the language to English?",textAlign: TextAlign.center,),


                      ],
                    ),
                    cancel: TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text("oui . yes")));
              },
              child: Text('English'),
            ),
          ),
        ),
        const Gap(10),
        Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                Get.defaultDialog(
                    title: "Parametre systeme par defaut vers  عربية",
                    content: Column(
                      children: [
                        Text(
                            "   - Etes vous sure de vouloir changer la langue en arabe",textAlign: TextAlign.center,),
                        Text(
                            "  - هل أنت متأكد أنك تريد تغيير اللغة إلى اللغة إلعربية -",textAlign: TextAlign.center,),
                      ],
                    ),
                    cancel: TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text("oui . نعم")));
              },
              child: Text('عربية'),
            ),
          ),
        )
      ]),
    );
  }
}

