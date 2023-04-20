import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/packs.dart';


class SignalerForm extends StatefulWidget {
  const SignalerForm({super.key});

  @override
  State<SignalerForm> createState() => _SignalerFormState();
}

class _SignalerFormState extends State<SignalerForm> {
  final TextEditingController _controllerSearch = TextEditingController();

  @override
  void dispose() {
    _controllerSearch.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:  AppBar(
        title: Text("Localisation",style: TextStyle(fontFamily: "Poppins",fontSize: 21,fontWeight: FontWeight.normal,color: Colors.black87)),
        elevation: 5.0,
        centerTitle: true,
        leading: IconButton(icon: FaIcon(FontAwesomeIcons.xmark,color:Colors.black87),onPressed: (){Get.back();},),
        backgroundColor: Colors.white,
        
      ),
      body: Stack(
        children: [
          // ! Map
          Container(
            width: width*1,
            height: height,
            child: MapboxMap(
                accessToken: "sk.eyJ1IjoibW9oYW1lZC1pc2xhbSIsImEiOiJjbGY5a2E0bmkyMjU4M3pudHhnOXlnYmFhIn0.19k4OxrqxtMQuQhXnyDO_Q",
                onMapCreated: (c){},
                initialCameraPosition: CameraPosition(
                  target: LatLng(36.38214832844181, 3.8946823228767466),
                  zoom: 14.0, 
                ),
              ),
          ),
          // ! search bar + button 
          Positioned(
                  top: 20,
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
                            hintText: 'Rechercher',
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
                        icon: FaIcon(
                          FontAwesomeIcons.sliders,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
          // ! se Localiser
          Align(
                  alignment: AlignmentDirectional(0,0.8),
                  child: MyCustomButton_widget2(
                    text: "se Localiser",
                    onPressed: (){},
                    options: Button_Option(
                      elevation: 15,
                      textStyle: TextStyle(fontFamily: "Poppins",fontSize: 18.sp,color: Colors.white,fontWeight: FontWeight.w500),
                      height: 45,
                      width: 0.359 * width,
                      color: Color.fromRGBO(94, 129, 244, 1),
                    ),
                  ))  
        ],
      ),
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
                        color: Colors.cyan,
                      )
                    )
                  ),
                  onPressed: (){Get.back();},
                  child: Text("Annuler")),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    disabledBackgroundColor:Color.fromARGB(255, 224, 224, 224) ,
                    disabledForegroundColor: Color.fromARGB(255, 129, 129, 129),
                    foregroundColor: Colors.white,
                    textStyle: TextStyle(color: Colors.white),
                    backgroundColor: Color.fromRGBO(33, 150, 243, 1.0),
                    fixedSize: Size(width/2 - 30, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.5),
                      side: BorderSide(
                        color: Colors.cyan,
                      )
                    )
                  ),
                  onPressed:(){Get.to(Info_supp());},
                  child: Text("Suivant")),
              ],
            ),
          ),
        ),
    );    
  }  
}