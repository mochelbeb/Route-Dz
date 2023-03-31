import '../utils/packs.dart';

class MyProfilePage extends StatefulWidget {
  MyProfilePage({Key? key}) : super(key: key);
  @override
  MyProfilePageState createState() => new MyProfilePageState();
}

class MyProfilePageState extends State<MyProfilePage> {
    late bool _isChecked;
     @override
     void initState() {
      super.initState();
      _isChecked = false;
      }
      @override
      Widget build(BuildContext context) {
        final _width = MediaQuery.of(context).size.width;
        final _height = MediaQuery.of(context).size.height;
        return  Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            //elevation: 5,
            leading: IconButton(icon: FaIcon(FontAwesomeIcons.chevronLeft,color: Colors.black,),onPressed: (){Get.back();},),
            title: Text("Mon profile" , style: TextStyle(fontFamily: "Raleway",fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600),),
            centerTitle: true,
            actions: [
              TextButton(
                onPressed: (){Get.back();},
                child: const Text("Enregistrer")
              )
            ]
          ),
          body: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: _height / 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      const Gap(10),

                      CircleAvatar(
                        /*backgroundImage:
                        const AssetImage("assets/profile_img.jpeg"),*/
                        radius: _height / 10,
                      ),

                      const Gap(20),

                      const Text("Modifier votre photo",style: TextStyle(color: Colors.blue,fontSize: 18.0,fontWeight: FontWeight.w600,),),
                      
                      const Gap(20),

                      const Divider(),

                      const Gap(20),
                      
                      const Text("Vos informations personnel ",style: TextStyle(color: Colors.black,fontSize: 18.0,fontWeight: FontWeight.w500,),),
                      
                      const Gap(30),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          children: [

                            Row(
                              children:  [
                                const Text("Nom",style: TextStyle(color: Colors.black,fontSize: 18.0,),),
                                const SizedBox(width: 80,),
                                const Text("Akbi",style: TextStyle(color: Colors.black,fontSize: 18.0,),), 
                              ],
                            ),

                            const Gap(20),

                            Row(
                              children: [
                                const Text("Prénom",style: TextStyle(color: Colors.black,fontSize: 18.0,),), 
                                const SizedBox(width: 55,),
                                const Text("Nour el houda",style: TextStyle(color: Colors.black,fontSize: 18.0,),), 
                              ],
                            ),

                            const Gap(20),

                            Row(
                              children: [
                                const Text("Email",style: TextStyle(color: Colors.black,fontSize: 18.0,),), 
                                const SizedBox(width: 72,),                                            
                                const Text("Nourakbi@gmail.com",style: TextStyle(color: Colors.black,fontSize: 18.0,),), 
                              ],
                            ),

                            const Gap(20),

                            Row(
                              children: [
                                const Text("Mot de passe",style: TextStyle(color: Colors.black,fontSize: 18.0,),),
                                const SizedBox(width: 10,),
                                const Text("*********20",style: TextStyle(color: Colors.black,fontSize: 18.0,),),  
                              ],
                            ),

                            const Gap(15),

                            Row(
                              children: [
                                Checkbox(
                                  value: _isChecked,
                                  onChanged: (checked){
                                    setState(() {
                                      _isChecked = checked as bool;
                                      }
                                    );
                                  },
                                ),
                                Text("Recevoir des notification"),
                              ],
                            ),

                            
                          ],
                        ),
                      )                 
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }
    }