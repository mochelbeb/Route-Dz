import 'package:responsive_sizer/responsive_sizer.dart';
import '../utils/packs.dart';

class HomePage extends StatelessWidget {
  var type_list = ["type1","type2","type3","type4","type5"]; // la liste des types 

  HomePage({super.key});


  final _controller = TextEditingController();
  // Sort By buttons boolean for switch
  RxBool proximite_btn = true.obs;
  RxBool recent_btn = false.obs;


  // Etat buttons boolean for switch
  RxBool attente_btn = false.obs;
  RxBool enCour_btn = true.obs;
  RxBool terminer_btn = true.obs;
  
  // date buttons boolean for switch
  RxBool hours_btn = false.obs;
  RxBool week_btn = true.obs;


  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    print("width : $w");
    print("80 % width : ${0.8*w}");

    return SafeArea(
      child: Stack(
        children: [
          // ! Map Area
          Align(
            alignment: const AlignmentDirectional(0, 0),
            child: Container(
              width: w,
              height: h * 1,
              child: MapboxMap(
                accessToken: "sk.eyJ1IjoibW9oYW1lZC1pc2xhbSIsImEiOiJjbGY5a2E0bmkyMjU4M3pudHhnOXlnYmFhIn0.19k4OxrqxtMQuQhXnyDO_Q",
                onMapCreated: (c){},
                initialCameraPosition: CameraPosition(
                  target: LatLng(36.38214832844181, 3.8946823228767466),
                  zoom: 14.0, 
                ),
              ),
              // decoration: const BoxDecoration(
              //   color: Color.fromARGB(255, 194, 217, 218),
              // ),
            ),
          ),
          // ! Map Button
          Align(
            alignment: const AlignmentDirectional(0.85, 0.9),
            child: MyCustomButton_widget1(
              borderColor: Colors.transparent,
              borderRadius: 15,
              borderWidth: 1,
              buttonSize: 44,
              fillColor: Colors.white,
              icon: const FaIcon(
                FontAwesomeIcons.solidMap,
                color: Color(0xFF171717),
                size: 20,
              ),
              onPressed: () {},
            ),
          ),
          // ! Search Bar
          Align(
            alignment: const AlignmentDirectional(-0.5, -0.91),
            child: Container(
              width: w * 0.66,
              child: TextFormField(
                controller: _controller,
                onChanged: (_) => EasyDebounce.debounce('_controller',
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
                  suffixIcon: _controller.text.isNotEmpty
                      ? InkWell(
                          onTap: () async {
                            _controller.clear();
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
          ),
          // ! Liste Button
          Align(
            alignment: AlignmentDirectional(-0.8, 0.9),
            child: MyCustomButton_widget2(
              onPressed: () {
                // $$ changement ici 
                Get.to(Liste_Signalement());
              },
              text: 'Liste',
              icon: Icon(
                FontAwesomeIcons.bars,
                color: Colors.black,
                size: 18.sp,
              ),
              options: Button_Option(
                iconColor: Colors.black,
                width: 0.255 * w,
                height: 45,
                color: Colors.white,
                textStyle: TextStyle(
                  fontSize: 17.sp,
                  color: Colors.black,
                  fontFamily: 'Roboto',
                ),
                elevation: 15,
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          // ! Filtre Button
          Align(
            alignment: const AlignmentDirectional(0.87, -0.91),
            child: MyCustomButton_widget1(
              borderColor: Colors.transparent,
              borderRadius: 15,
              borderWidth: 1,
              buttonSize: 48,
              fillColor: Color(0xFF5E81F4),
              icon: const FaIcon(
                FontAwesomeIcons.sliders,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () {
                Get.bottomSheet(
                  BottomSheet(onClosing: (){},builder: ((context) {
                    return Padding(
                        padding: EdgeInsets.all(0.0509*w),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.85,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(splashColor: const Color.fromRGBO(0, 0, 0, 0),focusColor: const Color.fromRGBO(0, 0, 0, 0),hoverColor: const Color.fromRGBO(0, 0, 0, 0),highlightColor: const Color.fromRGBO(0, 0, 0, 0),padding: EdgeInsets.all(0),alignment: AlignmentDirectional.centerStart,onPressed: (){Get.back();}, icon: FaIcon(FontAwesomeIcons.x)),
                                  Container(margin: EdgeInsets.only(left: 25.w),child: Text("Filters",style: Styles.headlineStyle1,)),
                                ],
                              ),
                              SizedBox(height: 0.0509*w,),
                              // ! SORT BY
                              Text("Sort by",style: Styles.subtitle,),
                              // ! buttons
                               Padding(
                                padding: EdgeInsets.all(0.0203 * w),
                                 child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                    Obx(() => ElevatedButton(
                                      onPressed: proximite_btn.value ?(){recent_btn.value = true;proximite_btn.value = false;} : null, 
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0.0,
                                        disabledForegroundColor: Colors.white,
                                        foregroundColor: Colors.black,
                                        disabledBackgroundColor: const Color.fromRGBO(36, 160, 237, 1.0),
                                        backgroundColor: const Color.fromRGBO(204, 204, 204, 1),
                                        fixedSize: Size(0.38*w,50),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.zero,
                                            bottomRight: Radius.zero,
                                            topLeft: Radius.circular(15.0),
                                            bottomLeft: Radius.circular(15.0)
                                          )
                                        )
                                      ),
                                      child: const Text("A proximité"), 
                                    ),
                                    ),
                                    Obx(() => ElevatedButton(
                                      onPressed: recent_btn.value ? (){recent_btn.value = false;proximite_btn.value = true;} : null, 
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0.0,
                                        disabledForegroundColor: Colors.white,
                                        foregroundColor: Colors.black,
                                        disabledBackgroundColor: const Color.fromRGBO(36, 160, 237, 1.0),
                                        backgroundColor: const Color.fromRGBO(204, 204, 204, 1),
                                        fixedSize: Size(0.38*w,50),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.zero,
                                            bottomLeft: Radius.zero,
                                            topRight: Radius.circular(15.0),
                                            bottomRight: Radius.circular(15.0)
                                          )
                                        )
                                      ),
                                      child: const Text("Plus Recent"),
                                    ),
                                    )
                                  ],
                                ),
                              ),
                              // ! Etat
                              SizedBox(height: 0.0509*w),
                              Text("Etat",style: Styles.subtitle,),
                              // ! Buttons
                              Padding(
                                padding: EdgeInsets.all(0.0203*w),
                                 child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                    Obx(() => ElevatedButton(
                                      onPressed: attente_btn.value ? (){
                                       attente_btn.value = false;
                                       enCour_btn.value = true;
                                       terminer_btn.value = true; 
                                      } : null, 
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0.0,
                                        disabledForegroundColor: Colors.white,
                                        foregroundColor: Colors.black,
                                        disabledBackgroundColor: const Color.fromRGBO(36, 160, 237, 1.0),
                                        backgroundColor: const Color.fromRGBO(204, 204, 204, 1),
                                        fixedSize: Size(MediaQuery.of(context).size.width/3 - 30,50),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.zero,
                                            bottomRight: Radius.zero,
                                            topLeft: Radius.circular(15.0),
                                            bottomLeft: Radius.circular(15.0)
                                          )
                                        )
                                      ),
                                      child: const Text("En Attente"),
                                    ),
                                    ),
                                    Obx(() => ElevatedButton(
                                      onPressed: enCour_btn.value ? (){
                                       attente_btn.value = true;
                                       enCour_btn.value = false;
                                       terminer_btn.value = true;
                                      } : null, 
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0.0,
                                        disabledForegroundColor: Colors.white,
                                        foregroundColor: Colors.black,
                                        disabledBackgroundColor: const Color.fromRGBO(36, 160, 237, 1.0),
                                        backgroundColor: const Color.fromRGBO(204, 204, 204, 1),
                                        fixedSize: Size(MediaQuery.of(context).size.width/3 - 30,50),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.zero,
                                            bottomRight: Radius.zero,
                                            topLeft: Radius.zero,
                                            bottomLeft: Radius.zero
                                          )
                                        )
                                      ),
                                      child: const Text("En Cours"),
                                    )
                                    ),
                                    Obx(() => ElevatedButton(
                                      onPressed: terminer_btn.value ? (){
                                       attente_btn.value = true;
                                       enCour_btn.value = true;
                                       terminer_btn.value = false;
                                      } : null, 
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0.0,
                                        disabledForegroundColor: Colors.white,
                                        foregroundColor: Colors.black,
                                        disabledBackgroundColor: const Color.fromRGBO(36, 160, 237, 1.0),
                                        backgroundColor: const Color.fromRGBO(204, 204, 204, 1),
                                        fixedSize: Size(MediaQuery.of(context).size.width/3 - 30,50),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(15.0),
                                            bottomRight: Radius.circular(15.0),
                                            topLeft: Radius.zero,
                                            bottomLeft: Radius.zero
                                          )
                                        )
                                      ),
                                      child: const Text("Terminer"),  
                                    )
                                    ),
                                  ],
                                ),
                              ),
                              // ! Date
                              SizedBox(height: 0.0509*w),
                              Text("Date",style: Styles.subtitle,),
                              // ! Buttons
                              Padding(
                                padding: EdgeInsets.all(0.0203*w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Obx(() => ElevatedButton(
                                      onPressed: hours_btn.value ? (){
                                        hours_btn.value = false;
                                        week_btn.value = true;
                                      } : null,
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0.0,
                                        disabledForegroundColor: Colors.white,
                                        foregroundColor: Colors.black,
                                        disabledBackgroundColor: const Color.fromRGBO(36, 160, 237, 1.0),
                                        backgroundColor: const Color.fromRGBO(204, 204, 204, 1),
                                        fixedSize: Size(0.38*w,50),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.zero,
                                            bottomRight: Radius.zero,
                                            topLeft: Radius.circular(15.0),
                                            bottomLeft: Radius.circular(15.0)
                                          )
                                        )
                                      ),
                                      child: Text("last 24h")
                                    )),
                                    Obx(() => ElevatedButton(
                                      onPressed: week_btn.value ?(){
                                        hours_btn.value = true;
                                        week_btn.value = false;
                                      }: null, 
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0.0,
                                        disabledForegroundColor: Colors.white,
                                        foregroundColor: Colors.black,
                                        disabledBackgroundColor: Color.fromRGBO(36, 160, 237, 1.0),
                                        backgroundColor: Color.fromRGBO(204, 204, 204, 1),
                                        fixedSize: Size(0.38*w,50),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(15.0),
                                            bottomRight: Radius.circular(15.0),
                                            topLeft: Radius.zero,
                                            bottomLeft: Radius.zero
                                          )
                                        )
                                      ),
                                      child: const Text("last week")
                                    )),
                                  ],
                                )
                              ),
                              // ! TYPE
                              SizedBox(height: 0.0509*w),
                              Text("Type",style:Styles.subtitle),
                              // ! buttons
                              Padding(
                                padding: const EdgeInsets.fromLTRB(25,8,25,8),
                                child: DropDownButton(dropdownValues: type_list),
                              ),
                              // ! Apply buttons
                              SizedBox(height: 0.076*w),
                              Padding(
                                padding: EdgeInsets.all(0.0509*w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    OutlinedButton(
                                      onPressed: (){Get.back();}, 
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Colors.black,
                                        backgroundColor: const Color.fromARGB(255, 240, 240, 240),
                                        fixedSize: Size(0.38*w, 50),
                                      ),
                                      child: const Text("Clear"), 
                                    ),
                                    OutlinedButton(
                                      onPressed: (){}, 
                                      style: OutlinedButton.styleFrom(
                                        fixedSize: Size(0.38*w,50),
                                        foregroundColor: const Color.fromRGBO(36, 160, 237, 1),
                                        backgroundColor: const Color.fromARGB(255, 240, 240, 240),
                                      ),
                                      child: const Text("Apply"),                                    
                                    ),
                                  ],
                                ),
                              
                              ),  
                            ],
                          ),
                        ),
                    );
                  }),
                  ),
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)
                    )
                  )
                  );
              },
            ),
          ),
          // ! Location Button
          Align(
            alignment: AlignmentDirectional(0.5, 0.9),
            child: MyCustomButton_widget1(
              borderColor: Colors.transparent,
              borderRadius: 15,
              borderWidth: 1,
              buttonSize: 44,
              fillColor: Colors.white,
              icon: FaIcon(
                FontAwesomeIcons.locationArrow,
                color: Color(0xFF3C3C3C),
                size: 20,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}


// class selectedController extends GetxController{
//   RxInt _sortby = 1.obs;
// }