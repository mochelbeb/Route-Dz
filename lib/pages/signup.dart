import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tariki/components/my_button.dart';
import 'package:tariki/components/my_textfield.dart';


class SignupPage extends StatelessWidget {
  SignupPage({super.key});
  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: SingleChildScrollView(
            reverse: true,
            padding: EdgeInsets.all(10),
            child: Column(
            children: [
              const Gap(40),
              Text(
                'Bienvenu !\nVeuillez créer                \nUn compte  ',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                  height: 1.25,
                ),
                
              ),
              const Gap(20),
              // username textfield
                                          MyTextField(
                controller: usernameController,
                hintText: 'Nom',
                obscureText: false,
              ),
                            const Gap(10),
MyTextField(
                controller: usernameController,
                hintText: 'Prénom',
                obscureText: false,
              ),

              const Gap(10),
              MyTextField(
                controller: usernameController,
                hintText: 'Email',
                obscureText: false,
              ),
              const Gap(15),
              // password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Mot de passe',
                obscureText: true,
              ),
              const Gap(10),   
              // forgot password?

              const Gap(15),
              // sign in button
              MyButton(
                onTap: signUserIn,),
              const Gap(15),

              const Gap(15),
              /* not a member? register now
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
            
            ),*/
          ],
        ),
      ),
    ),
  );
}

}
