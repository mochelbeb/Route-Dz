import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../services/service.dart';
import '../utils/packs.dart';

class MyProfilePage extends StatefulWidget {
  MyProfilePage({Key? key}) : super(key: key);
  @override
  MyProfilePageState createState() => new MyProfilePageState();
}

class MyProfilePageState extends State<MyProfilePage> {
    RxBool _ImageSelected = false.obs;
    RxBool _onSaving = false.obs;
    File? _profileImage;
    late bool _isChecked;
    late TextEditingController _nameController;

    String? NetworkPhoto;
    
     @override
     void initState() {
      super.initState();
      _nameController = TextEditingController();
      _nameController.text = FirebaseAuth.instance.currentUser!.displayName as String;
      if (user!.photoURL != null){
        NetworkPhoto = user!.photoURL;
      }
      _isChecked = false;
      }

      _pickImage() async {
      File? image = await Service.pickImage();
      
      if (image != null){
        _ImageSelected.value = false;
        _ImageSelected.value = true;
        _profileImage = image;
        NetworkPhoto = null;
      } 
      }


    User? user = FirebaseAuth.instance.currentUser;


      @override
      Widget build(BuildContext context) {
        final _width = MediaQuery.of(context).size.width;
        final _height = MediaQuery.of(context).size.height;
        return  Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            leading: IconButton(icon: FaIcon(FontAwesomeIcons.chevronLeft,color: Colors.black,),onPressed: (){Get.back();},),
            title: Text("Mon profile" , style: TextStyle(fontFamily: "Raleway",fontSize: 20.sp,color: Colors.black,fontWeight: FontWeight.w600),),
            centerTitle: true,
            actions: [
              TextButton(
                onPressed: ()async{
                  if (_nameController.text != user!.displayName){
                    await user!.updateDisplayName(_nameController.text);
                  } else if (_profileImage != null){
                    _onSaving.value = true;
                    String? uploadImage = await Service.uploadPhotoToCloud(user!.uid, _profileImage!.path);
                    await user!.updatePhotoURL(uploadImage);
                  } 
                  _onSaving.value = false;
                  Get.back();
                },
                child: const Text("Enregistrer")
              )
            ]
          ),
          body: Obx(() => Stack(
            children: <Widget>[
              _onSaving.value
                ? const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                )
                : const Align(),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: _height / 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      const Gap(10),

                      Obx(() => GestureDetector(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          backgroundImage: NetworkPhoto != null
                          ? CachedNetworkImageProvider(NetworkPhoto!)
                          : (_ImageSelected.value && _profileImage!= null)
                           ? FileImage(_profileImage!) as ImageProvider
                           : null, 
                          radius: _height / 10,
                          child: _ImageSelected.value || _profileImage != null || NetworkPhoto != null
                          ? null
                          : FaIcon(FontAwesomeIcons.user)
                        ),
                      )
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
                                 Text("Nom",style: TextStyle(color: Colors.black,fontSize: 18.0,),),
                                 SizedBox(width: 90,),
                                 //Text("Akbi",style: TextStyle(color: Colors.black,fontSize: 18.0,),), 
                                 SizedBox(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width /2,
                                   child: TextField(
                                    controller: _nameController,
                                 
                                   ),
                                 )
                              ],
                            ),

                            const Gap(20),


                            Row(
                              children: [
                                 Text("Email",style: TextStyle(color: Colors.black,fontSize: 18.0,),), 
                                 SizedBox(width: 82,),                                            
                                 Text(FirebaseAuth.instance.currentUser!.email!,style: TextStyle(color: Colors.black,fontSize: 18.0,),), 
                              ],
                            ),

                            const Gap(20),

                            Row(
                              children: [
                                 Text("Mot de passe",style: TextStyle(color: Colors.black,fontSize: 18.0,),),
                                 SizedBox(width: 20,),
                                 Text("***********",style: TextStyle(color: Colors.black,fontSize: 18.0,),),  
                                 SizedBox(width: 20,),
                                 TextButton(onPressed: (){}, child: Text("Modifier",style: TextStyle(fontSize: 18.sp),)),
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
        ));
      }
    }