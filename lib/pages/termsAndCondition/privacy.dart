import 'package:RouteDz/utils/packs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/gestures.dart';

class privacyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                backgroundColor: Colors.white,
        title: Text("Politique de Confidentialité" , style: TextStyle(color: Colors.black),),
        elevation: 5.0,
        leading: IconButton(onPressed: (){Get.back();},icon: FaIcon(FontAwesomeIcons.angleLeft,color: Colors.black,),),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Politique de Confidentialité et de Confidentialité pour l\'Application Mobile Route DZ',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Chez Route DZ, nous nous engageons à protéger la confidentialité et la confidentialité des informations personnelles de nos utilisateurs. Cette politique de confidentialité et de confidentialité décrit comment nous collectons, utilisons et protégeons les informations que vous nous fournissez via notre application mobile, conçue pour les réparations de problèmes routiers. En utilisant notre application, vous reconnaissez et acceptez les pratiques décrites dans cette politique.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Collecte d\'informations',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Nous collectons les types d\'informations suivants auprès de nos utilisateurs :',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              '- Informations de localisation : Pour fournir des services de réparation de problèmes routiers, notre application peut collecter vos informations de localisation, y compris les données GPS et d\'autres technologies basées sur la localisation.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              '- Informations personnelles : Nous pouvons collecter des informations personnelles telles que votre nom, vos coordonnées et les détails de votre véhicule lorsque vous soumettez une demande de réparation ou utilisez certaines fonctionnalités de notre application.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              '- Contenu généré par l\'utilisateur : Nous pouvons collecter le contenu que vous soumettez volontairement à notre application, tel que des commentaires, des descriptions et des photos liées aux problèmes routiers nécessitant une réparation.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Utilisation des informations',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Nous utilisons les informations collectées auprès de nos utilisateurs aux fins suivantes :',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              "- Fournir et améliorer nos services : Nous utilisons vos informations pour traiter et exécuter vos demandes de réparation, communiquer avec vous sur l'état de votre réparation et améliorer en continu la qualité et l'efficacité de nos services de réparation des problèmes routiers.",
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              '- Personnalisation de l\'expérience utilisateur : Nous utilisons vos informations pour personnaliser votre expérience utilisateur, telle que l\'affichage de contenus pertinents en fonction de votre localisation et de vos préférences.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              '- Communication : Nous utilisons vos informations pour vous contacter, répondre à vos questions, vous fournir des informations importantes sur notre application et vous envoyer des notifications liées à votre demande de réparation.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Partage d\'informations',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Nous ne partageons pas vos informations personnelles avec des tiers, sauf dans les cas suivants :',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              '- Fournisseurs de services : Nous pouvons partager vos informations avec des fournisseurs de services tiers pour nous aider à fournir et améliorer nos services, tels que les prestataires de services de localisation, les fournisseurs d\'hébergement, les prestataires de messagerie et les services de support client.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              '- Conformité légale : Nous pouvons divulguer vos informations si nous sommes légalement tenus de le faire, par exemple pour se conformer à une demande de la loi ou pour protéger nos droits légaux.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Sécurité des informations',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Nous mettons en place des mesures de sécurité appropriées pour protéger vos informations contre la perte, l\'utilisation abusive, l\'accès non autorisé, la divulgation, l\'altération ou la destruction non autorisée. Cependant, veuillez noter qu\'aucune méthode de transmission sur Internet ou de stockage électronique n\'est sécurisée à 100% et nous ne pouvons pas garantir la sécurité absolue de vos informations.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Vos choix',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Vous pouvez choisir de ne pas nous fournir certaines informations personnelles, mais cela peut affecter votre utilisation de certaines fonctionnalités de notre application. Vous pouvez également ajuster les paramètres de confidentialité de votre appareil mobile pour limiter la collecte de vos informations de localisation.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Modifications de la politique de confidentialité',
              style: TextStyle(fontSize: 16.0,
              fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Nous pouvons mettre à jour cette politique de confidentialité de temps à autre. Toute modification de cette politique sera publiée dans notre application avec la date d\'entrée en vigueur. Nous vous encourageons à consulter régulièrement cette politique pour vous tenir informé des changements éventuels.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Consentement',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'En utilisant notre application, vous consentez à la collecte, l\'utilisation et le partage de vos informations conformément à cette politique de confidentialité.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Nous contacter',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Si vous avez des questions, des commentaires ou des préoccupations concernant cette politique de confidentialité, veuillez nous contacter à l\'adresse suivante : [email protected]',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Dernière mise à jour : 20 avril 2023',
              style: TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
