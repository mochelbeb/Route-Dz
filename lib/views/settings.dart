import 'package:flutter/material.dart';
import 'package:tariki/utils/app_styles.dart';
import 'package:gap/gap.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Styles.bgColor,
        body:ListView(
          children: [
            Container(
              padding: EdgeInsets.only(left: 40 , top: 50 ,right: 40 ),
              child: Text("Paramètres" , style: Styles.headlineStyle1,),
            ),
            const Gap(30),
            colorTiles(),
          ],
        ),
    ) ;
  }
}

Widget divider(){
  return const Padding(
    padding:  EdgeInsets.symmetric(horizontal: 40),
    child: Divider(
      thickness: 1.5,
    ),
    );
}

Widget colorTiles (){
  return Column(
    children: [
      colorTile(FontAwesomeIcons.user,"Compte"),divider(),
      colorTile(FontAwesomeIcons.language, "Change de langue"),divider(),
      colorTile(FontAwesomeIcons.file, "Conditions"),divider(),
      colorTile(FontAwesomeIcons.lock, "Politique de confidentialité"),divider(),
      colorTile(FontAwesomeIcons.circleInfo, "À propos"),divider(),
      colorTile(FontAwesomeIcons.rightFromBracket, "Se déconnecter"),
    ],
  );
}

Widget colorTile (IconData icon , String text){
  return ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: 40 , vertical: 3),
    leading : Icon(
      icon , 
      color: Styles.textColor,
      size: 15
      ),
    title : Text(
      text , 
      style: Styles.textStyle.copyWith(color: Styles.textColor),
    ),
    trailing: Icon(
      FontAwesomeIcons.chevronRight,  
      color: Styles.textColor, 
      size: 15
      ),
  );
}
    
