import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tariki/components/my_button.dart';
import 'package:tariki/components/my_textfield.dart';
import 'package:tariki/pages/signup.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
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


              Text(
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
              // username textfield

              MyTextField(
                controller: usernameController,
                hintText: 'Email',
                obscureText: false,
              ),
              const Gap(10),
              // password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Mot de passe',
                obscureText: true,
              ),
              const Gap(10),   
              // forgot password?
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
              // sign in button
              MyButton(onTap: signUserIn,),
              const Gap(15),
              /* or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Ou continuer avec',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(10),
              // google + apple sign in buttons
             // _colorTile('lib/images/google.png',"Continuer avec Google"),
              //const Gap(10),
            //  _colorTile('lib/images/facebook-logo-png-23.png',"Continuer avec Facebook"),
*/

              const Gap(15),
              // not a member? register now
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
/*Widget _colorTile(String imagePath, String text) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 0),
    margin:EdgeInsets.symmetric(horizontal: 20),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white),
      borderRadius: BorderRadius.circular(50),
      color: Colors.grey[200],
    ),
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 3),
      leading: Image.asset(
        imagePath,
        height: 40,
      ),
      title: Text(
        text,
        ),
    ),
  );
 }*/
}
