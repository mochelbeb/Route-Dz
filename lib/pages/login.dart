import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tariki/components/my_textfield.dart';
import 'package:tariki/pages/signup.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
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
              const Text(
                'Bonjour !\nVeuillez-vous                \nConnecter ',
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

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Mot de passe oublié ?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
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
                  child: Text("Se connecter" , 
                  style: TextStyle( color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600,), ),
                  ),

              const Gap(15),

              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                         "Vous n'avez pas de compte ?",
                          style: TextStyle(
                          color: Colors.grey[700]
                          ),
                          ),
                      const SizedBox(width: 4),
                      InkWell(
                         onTap: () {
                           Navigator.push(
                                    context,
                          MaterialPageRoute(builder: (context) =>  SignupPage()),
                         );
                       },
                          child: const Text(
                        'Inscrivez vous',
                        style: TextStyle(
                          color: Color(0xFF5E81F4),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          ),
                        ),
                      )
                    ],
                  ),

              const Gap(10),

              const Text(
                'Continuer sans compte',
                style: TextStyle(
                  color: Color.fromARGB(255, 47, 96, 139),
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
}
