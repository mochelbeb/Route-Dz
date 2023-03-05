import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tariki/utils/app_styles.dart';

import '../widgets/custom_buttons.dart';

class Info_supp extends StatelessWidget {
  Info_supp({super.key});
  List<String> type_list  = ["type1","type2","type3","type4","type5"];

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Info Supplimentaires" , style: TextStyle(fontFamily: "Raleway",fontSize: 16,fontWeight: FontWeight.bold),),
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
          }, icon: FaIcon(FontAwesomeIcons.circleInfo))
        ],
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
          child: Container(
            width: w,
            height: h,
            margin: EdgeInsets.only(top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* title
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text("Signalement d'un point noir:",style:Styles.headlineStyle1),
              ),
              SizedBox(height: 20,),
              //* Image 
              GestureDetector(
                onTap: (){
                  Get.defaultDialog(
                    title: "Ajouter des Photos",
                    content: Text("Ajouter des photos de votre point noir ici"),
                    confirm: TextButton(onPressed: (){Get.back();},
                    child: Text("Confirmer")));
                },
                child: Container(
                  height: 0.332 * h,
                  width: w,
                  margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.black12
                  ),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children : [
                      FaIcon(FontAwesomeIcons.camera,),
                      Text("Ajouter des photos",style: TextStyle(fontFamily: "Roboto"),)
                          ]),
                  ),
                  
                ),
              ),
              SizedBox(height: 20,),
              //* Type Text
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text("Choisir un type :", style: Styles.textStyle),
              ),
              //* Type Dropdown
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: DropDownButton(dropdownValues: type_list),
              ),
              //* Adresse text
              SizedBox(height: 20,),
              Padding(padding: EdgeInsets.only(left: 15),child: Text("Ajouter une description : ",style: Styles.textStyle,),),
              //* Adresse Text Area
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: TextField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Ajouter une breve description du point noir et l'adresse .. etc ",
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 1.5),borderRadius: BorderRadius.all(Radius.circular(15)))
                  ),
                  keyboardType: TextInputType.text,
              
                ),
              ),
              //* Envoyer Button
              SizedBox(height: 20,),
              Center(
                child: MyCustomButton_widget2(
                  text: "Envoyer",
                  options: Button_Option(width: 0.36*w,height: 45, textStyle: Styles.textStyle_revese,color: Color.fromRGBO(94, 129, 244, 1.0)),
                  onPressed: (){},
                  ),
              )            
            ],
        ),
          ),
      ),
    );
  }
}