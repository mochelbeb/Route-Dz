import 'package:RouteDz/Client/Auth/handle.dart';
import 'package:RouteDz/controllers/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../Client/Auth/Auth.dart';
import '../utils/packs.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController repeatPasswordcontroller;

  late bool _isChecked;
  RxBool isLoading = false.obs;
  
  
  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    repeatPasswordcontroller.dispose();
    passwordController.dispose();
    super.dispose();
  }
  
  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    emailController = TextEditingController();
    repeatPasswordcontroller = TextEditingController();
    _isChecked = false;
  }
  
  
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: SingleChildScrollView(
            reverse: true,
            //padding: EdgeInsets.all(10),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(40),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Text(
                  'Bienvenu !\nVeuillez créer \nUn compte  ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 23.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                    height: 1.25,
                  ),
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
                    Checkbox(
                      value: _isChecked, 
                      onChanged: (checked){
                        setState(() {
                          _isChecked = checked as bool;
                        });
                      },
                    ),
                    const Text("Vous acceptez les conditions d'utilisation \net la politique de confidentialité."),
                  ],
                ),
              ),

              const Gap(15),

              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: 
                Obx(()=>OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Color(0xFF5E81F4),
                      fixedSize: Size(width - 70, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      )
                    ),
                    onPressed: () async {
                      isLoading.value = true;
                      bool validation = OnPressSignupHandle(emailController.text, passwordController.text, repeatPasswordcontroller.text);
                      if (validation && _isChecked){
                        UserCredential? new_user = await SignupWithInfos(usernameController.text,emailController.text,passwordController.text);
                        isLoading.value = false;
                      }
                      else if(!_isChecked){
                        Get.defaultDialog(
                          content: Text("Veillez acceptez les conditionds d'utilisation \net de la politique de confidentialité"),
                          cancel: TextButton(onPressed: (){Get.back();}, child: Text("retour"))
                        );
                      }
                      else{
                        Get.defaultDialog(
                          content: Text("Mot de pass invalid"),
                          cancel: TextButton(onPressed: (){Get.back();}, child: Text("retour"))
                        );
                      }
                    },
                    child: isLoading.value
                    ? CircularProgressIndicator(color: Colors.white,)
                    : Text("S'inscrire" , style:TextStyle( color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600,),
                ),
              )),
              ),
          ],
        ),
      ),
    ),
  );
  }
}