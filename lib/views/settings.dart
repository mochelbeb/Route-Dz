import 'package:flutter/material.dart';
import 'package:tariki/utils/app_styles.dart';
import 'package:gap/gap.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
              _colorTile(FontAwesomeIcons.user, "Compte"),
              _divider(),
              _colorTile(FontAwesomeIcons.language, "Changer de langue"),
              _divider(),
              _colorTile(FontAwesomeIcons.file, "Conditions"),
              _divider(),
              _colorTile(FontAwesomeIcons.lock, "Politique de confidentialité"),
              _divider(),
              _colorTile(FontAwesomeIcons.circleInfo, "À propos"),
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
