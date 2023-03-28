import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tariki/components/my_textfield.dart';


class SignupPage extends StatelessWidget {
  SignupPage({super.key});
  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: SingleChildScrollView(
            reverse: true,
            padding: EdgeInsets.all(10),
            child: Column(
            children: [
              const Gap(40),
              const Text(
                'Bienvenu !\nVeuillez créer                \nUn compte  ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                  height: 1.25,
                ),
              ),

              const Gap(20),

              MyTextField(
                controller: usernameController,
                hintText: "Nom d'utilisateur",
                obscureText: false,
              ),

              const Gap(10),

              MyTextField(
                controller: usernameController,
                hintText: 'Email',
                obscureText: false,
              ),

              const Gap(10),

              MyTextField(
                controller: passwordController,
                hintText: 'Mot de passe',
                obscureText: true,
              ),

              const Gap(10),

              MyTextField(
                controller: passwordController,
                hintText: 'Confirmer le mot de passe',
                obscureText: true,
              ),

              const Gap(10),   

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Checkbox(value: false, onChanged: (checked){
                      print(checked);
                    },
                    ),
                    Text("Vous acceptez les conditions d'utilisation et la \npolitique de confidentialité."),
                  ],
                ),
              ),

              const Gap(15),

              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    backgroundColor: Color(0xFF5E81F4),
                    fixedSize: Size(width - 70, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    )
                  ),
                  onPressed: (){},
                  child: Text("S'inscrire" , style:TextStyle( color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600,),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}
