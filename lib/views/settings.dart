import '../utils/packs.dart';
import 'profile.dart';
import 'language.dart';


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
              _colorTile(FontAwesomeIcons.file, "Conditions"),
              _divider(),
              _colorTile(FontAwesomeIcons.lock, "Politique de confidentialité"),
              _divider(),
              GestureDetector(child: _colorTile(FontAwesomeIcons.circleInfo, "À propos"), onTap: (){
                Get.bottomSheet(
                  BottomSheet(
                   shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)
                    ),
                   ),
                   onClosing: (){},
                   builder: ((context) => Container(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(25)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                      Text(
                        'À propos',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Route Dz',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Application mobile pour le signalement des \ndégradations routières en Algérie',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'v1.0.0',
                        style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                )))
                );
              },),
              _divider(),
              _colorTile(FontAwesomeIcons.rightFromBracket, "Se déconnecter"),
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
