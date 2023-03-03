import 'package:flutter/material.dart';
import 'package:tariki/utils/app_styles.dart';

import '../widgets/custom_buttons.dart';

class SignalerForm extends StatelessWidget {
  SignalerForm({super.key});
  List<String> type_list  = ["type1","type2","type3","type4","type5"];

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
        child: Container(
          width: w,
          height: h,
          margin: EdgeInsets.only(top: 100),
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
            Container(
              height: 0.332 * h,
              width: w,
              margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.black12
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
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: "Ajouter une breve description du point noir et l'adresse .. etc ",
                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 1.5),borderRadius: BorderRadius.all(Radius.circular(15)))
                ),
                keyboardType: TextInputType.text,
            
              ),
            ),
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
    );
  }
}