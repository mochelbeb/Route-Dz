import 'package:RouteDz/Client/Auth/Auth.dart';
import 'package:RouteDz/pages/Apropos.dart';

import '../utils/packs.dart';
import 'profile.dart';
import 'language.dart';
import 'package:RouteDz/pages/termsAndCondition/privacy.dart';
import 'package:RouteDz/pages/termsAndCondition/condition.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 40, top: 50, right: 40),
            child: Text( 
              "Paramètres",
              style: Styles.headlineStyle1,
            ),
          ),
          const Gap(30),
          Column(
            children: [
              GestureDetector(child: _colorTile(FontAwesomeIcons.user, "Compte"),onTap: (){Get.to(MyProfilePage());},),
              _divider(),
              GestureDetector(child: _colorTile(FontAwesomeIcons.language, "Changer de langue"),onTap: (){Get.to(Languagepage());},),
              _divider(),
              GestureDetector(child:_colorTile(FontAwesomeIcons.file, "Conditions"),onTap:(){Get.to(conditionPage());},),
              _divider(),
              GestureDetector(child:_colorTile(FontAwesomeIcons.lock, "Politique de confidentialité"),onTap:(){Get.to(privacyPage());},),
              _divider(),
              GestureDetector(child: _colorTile(FontAwesomeIcons.circleInfo, "À propos"), onTap: (){
                Get.to(AboutPage());
              },),
              _divider(),
              GestureDetector(child: _colorTile(FontAwesomeIcons.rightFromBracket, "Se déconnecter"), onTap: SignOut,),
            ],
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: const Divider(
        thickness: 1.5,
      ),
    );
  }

  Widget _colorTile(IconData icon, String text) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 40, vertical: 3),
      leading: Icon(
        icon,
        color: Styles.textColor,
        size: 15,
      ),
      title: Text(
        text,
        style: Styles.textStyle.copyWith(color: Styles.textColor),
      ),
      trailing: Icon(
        FontAwesomeIcons.chevronRight,
        color: Styles.textColor,
        size: 15,
      ),
    );
  }
}
