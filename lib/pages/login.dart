import 'package:firebase_auth/firebase_auth.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../Client/Auth/Auth.dart';
import '../utils/packs.dart';


class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // controllers var
  RxBool isLoading = false.obs; 

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    
    print(isLoading.value);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: SingleChildScrollView(
            reverse: true,
            //padding: EdgeInsets.all(10),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Text(
                  'Bonjour !\nVeuillez-vous \nConnecter ',
                   style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                    height: 1.25,
                  ),
                ),
              ),

              const Gap(20),

              MyTextField(
                controller: emailController,
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
                    GestureDetector(
                      onTap: () {
                        if (emailController.text.isEmpty) {
                          Get.snackbar('Erreur', 'Veuillez entrer votre email',snackPosition: SnackPosition.BOTTOM);
                          return;
                        }else{
                          FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
                          Get.snackbar('Succès', 'Un email de réinitialisation de mot de passe a été envoyé à votre adresse email',snackPosition: SnackPosition.BOTTOM);
                        }
                      },
                      child:Text(
                      'Mot de passe oublié ?',
                      style: TextStyle(color: Colors.grey[600],fontSize: 16.sp),
                    )),
                  ],
                ),
              ),

              const Gap(15),

              Padding(
                padding: const EdgeInsets.only(left: 25.0),

                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Color(0xff5e81f4),
                      fixedSize: Size(width - 70, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      )
                    ),
                    onPressed: () async {
                      isLoading.value = true;
                      UserCredential? user = await loginWithEmail(emailController.text,passwordController.text);
                      isLoading.value = false;
                    },
                    child: isLoading.value
                    ? CircularProgressIndicator(color: Colors.white,)
                    : Text("Se connecter" , 
                            style: TextStyle( color: Colors.white,fontSize: 18.sp,fontWeight: FontWeight.w600,), ),
                    ),
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
                          color: Colors.grey[700],
                          fontSize: 15.5.sp
                          ),
                          ),
                      const SizedBox(width: 4),
                      InkWell(
                         onTap: () {
                          Get.to(SignupPage());
                       },
                          child:  Text(
                        'Inscrivez vous',
                        style: TextStyle(
                          color: const Color(0xff5e81f4),
                          fontSize: 15.5.sp,
                          fontWeight: FontWeight.bold,
                          //decoration: TextDecoration.underline,
                          ),
                        ),
                      )
                    ],
                  ),

              const Gap(10),

              InkWell(
                onTap: (){
                  Get.to(MyHomePage());
                },
                child:  Text(
                  'Continuer sans compte',
                  style: TextStyle(
                    color: Color.fromARGB(255, 47, 96, 139),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    //decoration: TextDecoration.underline,
                    ),
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
