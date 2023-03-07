import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tariki/pages/info_signalement.dart';

import '../widgets/custom_buttons.dart';

class SignalerForm extends StatelessWidget {
  SignalerForm({super.key});
  final TextEditingController _controllerSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //* title + button
          Container(
            height: 47,
            margin: EdgeInsets.fromLTRB(10,20,10,0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ? Localisation
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text("Localisation",style: TextStyle(fontFamily: "Poppins",fontSize: 21,fontWeight: FontWeight.normal)),
                ),
                // ? Suivant
                TextButton(onPressed: (){print("button clicked");Get.to(Info_supp());}, child: Text("Suivant",style: TextStyle(fontFamily: "Poppins",fontSize: 16,fontWeight: FontWeight.normal)))
              ],
            ),
          ),
          //* Map + buttons
          Container(
            height: height - 67 - 10.h,
            width: width,
            child: Stack(
              children: [
                // ! Map
                Align(
                  alignment: const AlignmentDirectional(0, 0),
                  child: Container(
                    height: height - 57 - 10.h,
                    width: width,
                    child: Center(
                        child: Text(
                      "Map",
                      style: TextStyle(fontSize: 24),
                    )),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 194, 217, 218),
                    ),
                  ),
                ),
                // ! search + button 
                Positioned(
                  top: 10,
                  left: 0,
                  width: width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //* searchbar
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        width: width * 0.764,
                        child: TextFormField(
                          controller: _controllerSearch,
                          onChanged: (_) => EasyDebounce.debounce('_controllerSearch',
                              const Duration(milliseconds: 2000), () => {}),
                          autofocus: false,
                          textCapitalization: TextCapitalization.none,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Search..',
                            hintStyle: TextStyle(fontFamily: "Roboto" ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0x00FFFFFF),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(
                              FontAwesomeIcons.magnifyingGlass,
                              size: 15,
                            ),
                            suffixIcon: _controllerSearch.text.isNotEmpty
                                ? InkWell(
                                    onTap: () async {
                                      _controllerSearch.clear();
                                    },
                                    child: const Icon(
                                      Icons.clear,
                                      color: Color(0xFF757575),
                                      size: 22,
                                    ),
                                  )
                                : null,
                          ),
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFF454545),
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      //* blue button 
                      MyCustomButton_widget1(
                        borderColor: Colors.transparent,
                        borderRadius: 15,
                        borderWidth: 1,
                        buttonSize: 44,
                        fillColor: Color(0xFF5E81F4),
                        icon: Icon(
                          FontAwesomeIcons.sliders,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                // ! se localiser button
                Align(
                  alignment: AlignmentDirectional(0,0.9),
                  child: MyCustomButton_widget2(
                    text: "se Localiser",
                    onPressed: (){},
                    options: Button_Option(
                      elevation: 15,
                      textStyle: TextStyle(fontFamily: "Raleway",fontSize: 16,color: Colors.white,fontWeight: FontWeight.w300),
                      height: 45,
                      width: 0.359 * width,
                      color: Color.fromRGBO(94, 129, 244, 1),
                    ),
                  ))  
              ],
            ),
          )
        ],
      );
  }
}

