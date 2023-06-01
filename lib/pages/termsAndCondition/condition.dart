
import 'package:RouteDz/utils/packs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/gestures.dart';

class conditionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 5.0,
        leading: IconButton(onPressed: (){Get.back();},icon: FaIcon(FontAwesomeIcons.angleLeft,color: Colors.black,),),
    
        title: Text("Conditions d'utilisation" , style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '1. Acceptation des Conditions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'En utilisant l\'application Route DZ (ci-après dénommée "l\'Application"), vous acceptez les présentes Conditions d\'utilisation (ci-après dénommées "les Conditions"). Veuillez les lire attentivement avant d\'utiliser l\'Application. Si vous n\'acceptez pas les Conditions, vous ne pouvez pas utiliser l\'Application.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),
            Text(
              '2. Utilisation de l\'Application',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Vous vous engagez à utiliser l\'Application de manière légale et en conformité avec toutes les lois et réglementations applicables. Vous ne devez pas utiliser l\'Application d\'une manière qui pourrait causer des dommages à l\'Application, à d\'autres utilisateurs ou à des tiers.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),
            Text(
              '3. Propriété Intellectuelle',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Tous les droits de propriété intellectuelle relatifs à l\'Application, y compris, mais sans s\'y limiter, les marques, les logos, les textes, les images, les vidéos, les sons et les codes source, sont la propriété de [Nom de l\'entreprise] ou de ses concédants de licence. Vous n\'êtes pas autorisé à utiliser, copier, reproduire, distribuer, afficher, modifier ou transmettre de quelque manière que ce soit le contenu de l\'Application sans l\'autorisation écrite préalable de [Nom de l\'entreprise].',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),
            Text(
              '4. Confidentialité',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'La collecte, l\'utilisation et la divulgation de vos données personnelles par l\'Application sont régies par notre Politique de Confidentialité. En utilisant l\'Application, vous acceptez les termes de notre Politique de Confidentialité.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),
            Text(
              '5. Loi Applicable et Juridiction',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Les présentes Conditions sont régies par les lois de [Pays/Région]. Tout litige découlant des présentes Conditions sera résolu exclusivement par les tribunaux compétents de [Ville/Pays/Région]. Vous acceptez de vous soumettre à la compétence exclusive de ces tribunaux pour tout litige découlant des présentes Conditions.',
              style: TextStyle(fontSize: 16),
),
SizedBox(height: 16.0),
Text(
'6. Modifications des Conditions',
style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
),
SizedBox(height: 8.0),
Text(
"[Nom de l'entreprise] se réserve le droit de modifier, de mettre à jour ou de supprimer les présentes Conditions à tout moment et sans préavis. Il est de votre responsabilité de consulter régulièrement les Conditions pour prendre connaissance des modifications éventuelles. En continuant à utiliser l'Application après toute modification des Conditions, vous acceptez les nouvelles Conditions modifiées.",
style: TextStyle(fontSize: 16),
),
SizedBox(height: 16.0),
Text(
'7. Résiliation',
style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
),
SizedBox(height: 8.0),
Text(
"[Nom de l'entreprise] se réserve le droit de résilier votre accès à l'Application à tout moment et pour quelque raison que ce soit, y compris, mais sans s'y limiter, en cas de violation des présentes Conditions. En cas de résiliation, les droits et obligations qui, par leur nature, devraient survivre à la résiliation, continueront de s'appliquer, y compris les dispositions relatives à la propriété intellectuelle, la confidentialité et la loi applicable.",
style: TextStyle(fontSize: 16),
),
SizedBox(height: 16.0),
Text(
'8. Contact',
style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
),
SizedBox(height: 8.0),
Text(
'Si vous avez des questions, des commentaires ou des préoccupations concernant les présentes Conditions, veuillez nous contacter à [adresse e-mail ou autre moyen de contact].',
style: TextStyle(fontSize: 16),
),
],
),
),
);
}
}
