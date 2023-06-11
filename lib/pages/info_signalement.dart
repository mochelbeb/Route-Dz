import 'dart:io';

import 'package:RouteDz/Client/Report_handle/Blackpoint_services.dart';
import 'package:RouteDz/components/Blackpoint.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../services/service.dart';
import '../utils/packs.dart';



class Info_supp extends StatefulWidget {
  const Info_supp({super.key});

  @override
  State<Info_supp> createState() => _Info_suppState();
}

class _Info_suppState extends State<Info_supp> {

  User? currentUser = FirebaseAuth.instance.currentUser;


  final _controllerDescription = TextEditingController();
  final PageController _pageController = PageController(viewportFraction: 0.8);
  List<String> type_list  = ["Nid-de-poule","Erosion","Déformation","Manque d'éclairage","Manque de Signalisation"];
  late bool _isButtonDisable;
  String _selectedItem = "";
  List<File>? resultList;

  RxBool _PictureSelected = true.obs;

  List<BlackPoint> pointNoirs = Get.find();

  Position location = Get.find();


  @override
  void dispose() {
    _pageController.dispose();
    _controllerDescription.dispose();
    super.dispose();
  }
  @override
  void initState() {
    _selectedItem = type_list[0];
    _isButtonDisable = true;
    super.initState();
  }

  Future<void> _pick_BP_images() async {
    resultList = await Service.pickMultiImage();
    if (resultList != null){
      _PictureSelected.value = true;
      _PictureSelected.value = false;
    } else{
      _PictureSelected.value = false;
      _PictureSelected.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, -1.0),
                blurRadius: 6.0,
              )
            ]
          ),
          height: 60,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    fixedSize: Size(width/2 - 30, 40.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.5),
                      side: BorderSide(
                        width: 3.0,
                        color: Color(0xff5e81f4),
                      )
                    )
                  ),
                  onPressed: (){Get.back();},
                  child: Text("Annuler",style: TextStyle(color: Color(0xff5e81f4)),)),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    disabledBackgroundColor:Color.fromARGB(255, 224, 224, 224) ,
                    disabledForegroundColor: Color.fromARGB(255, 129, 129, 129),
                    foregroundColor: Colors.white,
                    textStyle: TextStyle(color: Colors.white),
                    backgroundColor: Color(0xff5e81f4),
                    fixedSize: Size(width/2 - 30, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.5),
                      side: BorderSide(
                        color: Color(0xff5e81f4),
                      )
                    )
                  ),
                  onPressed: _isButtonDisable ? null : () async {
                    BlackPoint new_bp = BlackPoint(coordinate: LatLng(location.latitude, location.longitude), date: DateTime.now(), type: _selectedItem, pictures: null, description: _controllerDescription.text, comments: null ,etat: "En Attente" , approuvedBy: [currentUser!.uid]);
                    
                    await FirestoreService.addBN(context , new_bp , resultList);

                    Get.delete<List<BlackPoint>>();
                    Get.delete<List<String>>();
                    
                    Get.defaultDialog(
                      title: "Point noir ajouté avec Succée",
                      content: Text("Point noir a été ajouté avec succés \nMerci de nous avoir aidés à rendre la route meilleure."),
                      actions: [
                        TextButton(
                          onPressed: (){
                            Get.offAll(()=> MyHomePage());
                          
                        }, child: Text("OK"))
                      ]
                    );

                  },
                  child: Text("Envoyer")),
              ],
            ),
          ),
        ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 5,
        leading: IconButton(icon: FaIcon(FontAwesomeIcons.xmark,color: Colors.black,),onPressed: (){Get.back();},),
        title: Text("Ajouter Point Noir" , style: TextStyle(fontFamily: "Raleway",fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Get.defaultDialog(
              title: "Informations",
              content: Column(
                children: [
                  Text("1- il est important d'avoir une description claire de l'emplacement du point noir."),
                  Text("2- Vous pouvez ajouter jusqu'à 10 photos du point noir."),
                  Text("3- Si vous ne trouvez pas le type approprié, choisissez \"Autre\" et fournissez une description détaillée "),
                ],
              ),
              cancel: TextButton(onPressed: (){Get.back();}, child: Text("Retoure"))
            );
          }, icon: FaIcon(FontAwesomeIcons.circleInfo,color: Colors.black,))
        ],
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
              width: width,
              height: height,
              margin: EdgeInsets.only(top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //* title
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text("Signalement d'un point noir:",style:TextStyle(fontFamily: "Poppins",fontSize: 18.sp,)),
                ),
                SizedBox(height: 2.35.h,),
                //* Image 
                GestureDetector(
                  onTap: (){
                    _pick_BP_images();
                  },
                  child: Obx(()=>Container(
                    height: 0.332 * height,
                    width: width,
                    margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.black12
                    ),
                    child: _PictureSelected.value
                    ? Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children : [
                        FaIcon(FontAwesomeIcons.camera,),
                        Text("Ajouter des photos",style: TextStyle(fontFamily: "Roboto"),)
                            ]),
                    )
                    : PageView.builder(
                        controller: _pageController,
                        itemCount: resultList!.length,
                        itemBuilder: (context, index) {
                          return AnimatedBuilder(
                            animation: _pageController,
                            builder: (context, child) {
                              double value = 1;
                              if (_pageController.position.haveDimensions) {
                                value = _pageController.page! - index;
                                value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                              }
                              return Center(
                                child: SizedBox(
                                  height: Curves.easeInOut.transform(value) * 200,
                                  width: Curves.easeInOut.transform(value) * 300,
                                  child: child,
                                ),
                              );
                            },
                            child: Image.file(
                              resultList![index],
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                  ),
                )),
                SizedBox(height: 2.35.h,),
                //* Type Text
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text("Choisir un type :", style: Styles.textStyle),
                ),
                //* Type Dropdown
                SizedBox(height: 2.35.h,),
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  child: DropDownButton(
                    dropdownValues: type_list,
                    onSelectedValue: (value){
                      setState(() {
                        _selectedItem = value;
                      });
                    },
                    ),
                ),
                //* Description text
                SizedBox(height: 2.35.h,),
                Padding(padding: EdgeInsets.only(left: 15),child: Text("Ajouter une description : ",style: Styles.textStyle,),),
                //* Description Text Area
                SizedBox(height: 2.35.h,),
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  child: TextField(
                    controller: _controllerDescription,
                    onChanged: (value){
                      setState(() {
                        if (value.isEmpty){
                          _isButtonDisable = true;
                        }
                        else _isButtonDisable = false;
                      });
                    },
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Ajouter une breve description du point noir et l'adresse .. etc ",
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 1.5),borderRadius: BorderRadius.all(Radius.circular(15)))
                    ),
                    keyboardType: TextInputType.text,
                
                  ),
                ),
              ],
          ),
        ),
      ),
    );
  }
}
