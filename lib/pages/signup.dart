import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/packs.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  late bool _isChecked;
  
  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  
  @override
  void initState() {
    super.initState();
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
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Color(0xFF5E81F4),
                      fixedSize: Size(width - 70, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      )
                    ),
                    onPressed: (){
                      Get.to(MyHomePage());
                    },
                    child: Text("S'inscrire" , style:TextStyle( color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600,),
                ),
                          ),
              ),
          ],
        ),
      ),
    ),
  );
  }
}