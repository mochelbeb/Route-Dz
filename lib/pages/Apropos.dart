import 'package:RouteDz/utils/packs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/gestures.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 5.0,
        leading: IconButton(onPressed: (){Get.back();},icon: FaIcon(FontAwesomeIcons.angleLeft,color: Colors.black,),),
        title: const Text('À propos de Route Dz',style: TextStyle(color: Colors.black),),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'À propos de Route Dz',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Route Dz est une application mobile gratuite conçue pour aider les utilisateurs à signaler les points noirs et les dégradations sur les routes en Algérie. L\'application a été créée pour répondre au besoin croissant de fournir aux utilisateurs des informations précises et en temps réel sur l\'état des routes et des autoroutes.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Fonctionnalités',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text('- Signalement de points noirs et de dégradations sur les routes en Algérie.'),
            Text('- Prise de photos pour accompagner les signalements.'),
            Text('- Visualisation des signalements sur une carte interactive.'),
            Text('- Mises à jour régulières pour garantir une expérience utilisateur optimale.'),
            SizedBox(height: 16.0),
            Text(
              'Exigences techniques',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text('- Smartphone ou tablette Android 5.0 ou ultérieur.'),
            Text('- L\'application peut être téléchargée gratuitement à partir du Google Play Store.'),
            SizedBox(height: 16.0),
            Text(
              'Développeurs',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Route Dz a été développé par une équipe de développeurs passionnés et expérimentés qui se sont engagés à fournir aux utilisateurs une expérience utilisateur optimale. Pour toute question ou préoccupation, veuillez nous contacter à l\'adresse suivante :',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "Email : ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0
                    )    
                  ),
                  TextSpan(
                    text: "support@routedz.com",
                    style: const TextStyle(fontSize: 16.0,color: Color.fromRGBO(13, 125, 196, 1)),
                    recognizer: TapGestureRecognizer()..onTap = (){}    
                  )
                ]
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Nous sommes également présents sur les réseaux sociaux :',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "Facebook : ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0
                    )    
                  ),
                  TextSpan(
                    text: "https://www.facebook.com/routedz/",
                    style: const TextStyle(fontSize: 16.0,color: Color.fromRGBO(13, 125, 196, 1)),
                    recognizer: TapGestureRecognizer()..onTap = (){}    
                  )
                ]
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "Twitter : ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0
                    )    
                  ),
                  TextSpan(
                    text: "https://twitter.com/routedz/",
                    style: const TextStyle(fontSize: 16.0,color: Color.fromRGBO(13, 125, 196, 1)),
                    recognizer: TapGestureRecognizer()..onTap = (){}    
                  )
                ]
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "Instagram : ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0
                    )    
                  ),
                  TextSpan(
                    text: "https://www.instagram.com/routedz/",
                    style: const TextStyle(fontSize: 16.0,color: Color.fromRGBO(13, 125, 196, 1)),
                    recognizer: TapGestureRecognizer()..onTap = (){}    
                  )
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}
