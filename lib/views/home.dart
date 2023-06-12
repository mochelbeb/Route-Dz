import 'dart:typed_data';

import 'package:RouteDz/Client/Report_handle/Blackpoint_services.dart';
import 'package:RouteDz/components/Blackpoint.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../services/service.dart';
import '../utils/packs.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var logger = Logger();

  var type_list = ["Nid-de-Poule","Erosion","transformation","Manque d'eclairage","Manque de Signalization"]; // la liste des types 


  RxBool SymbolsAdded = false.obs;

  late TextEditingController _controller;
  MapboxMapController? mapController;

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

  List<Symbol> symbol_list = [];
  List<BlackPoint> BlackPoints = [];
  List<String> adress = [];
  
  PageController _pictureController = PageController(viewportFraction: 0.8);

  void _onMapCreated(MapboxMapController controller)async{
    mapController = controller;
  }

  AddBlackPoints()async{
    final ByteData warning = await rootBundle.load("lib/assets/warning.png");
    final Uint8List list = warning.buffer.asUint8List();

    final ByteData alert = await rootBundle.load("lib/assets/alert.png");
    final Uint8List list2 = alert.buffer.asUint8List();

    mapController!.addImage("warning-15",list);
    mapController!.addImage("alert-15",list2);
    
    BlackPoints = await FirestoreService.getBlackPoints();
    BlackPoints.forEach((pn) {
      logger.i("pn id : ${pn.id}");
      Symbol new_sym;
      if(pn.approuvedBy != null && pn.approuvedBy!.length >= 5){
        new_sym = Symbol(
          pn.id as String,
          SymbolOptions(
          geometry: LatLng(pn.coordinate.latitude, pn.coordinate.longitude),
          iconImage: "alert-15",
          iconSize: pn.approuvedBy!.length >= 10 ? 0.25 : 0.2,
        ));
      }
      else{
        new_sym = Symbol(
        pn.id as String,
        SymbolOptions(
        geometry: LatLng(pn.coordinate.latitude, pn.coordinate.longitude),
        iconImage: "warning-15",
        iconSize: 0.15,
      ));
      }
      
      logger.e("new symbol id : ${new_sym.id}");
      symbol_list.add(new_sym);
      mapController!.addSymbol(new_sym.options, {'id' : new_sym.id});
    });

    BlackPoints.forEach((pn) async {
      String ad = await Service.getStateAndProvinceFromLatLng(pn.coordinate.latitude, pn.coordinate.longitude);
      adress.add(ad);
    });   
    print("adress : $adress");
    
    final List<String> _adress_data = Get.put(adress);
    final List<BlackPoint> _data = Get.put(BlackPoints);
    mapController!.onSymbolTapped.add((element){
      _onSymbolTapped(element);
    });  
  }

  _zoomChanges(){
    if(mapController != null){
      double zoom = mapController!.cameraPosition!.zoom;
      double symbolSize = BlackPoint.calculateSymbolSize(zoom);

      symbol_list.forEach((symbol) {
        mapController!.updateSymbol(symbol, SymbolOptions(
          iconSize: symbolSize
        ));
      });
    }
  }

  @override
  void initState(){
    super.initState();
    _controller = TextEditingController();
    Future.delayed(const Duration(seconds: 2), (){
      AddBlackPoints();
    });
  }

  void _onSymbolTapped(Symbol s){
    BlackPoint? blackPoint_tapped = FirestoreService.findBlackPointFromSymbol(s, BlackPoints);
    if(blackPoint_tapped != null){
      String adresse_Tapped = adress[BlackPoints.indexOf(blackPoint_tapped)];
      RxBool checkApprouved = CheckUserApprouved(FirebaseAuth.instance.currentUser, blackPoint_tapped).obs;

      showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        context: context,
        isScrollControlled: true,
        builder: (context) => SizedBox(
          height: 700,
          child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
          children: [
            const Gap(10),
            Container(
              width: 400.0,
              height: 200.0,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    width: 2.0,
                  ),
                  borderRadius:
                      BorderRadius.circular(20)),
              child: PageView(
                children: <Widget>[
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(20),
                    child: blackPoint_tapped.pictures == null
                  ? blackPoint_tapped.approuvedBy!.length < 5
                   ? Image.asset(
                    'lib/assets/warning.png',
                    fit: BoxFit.fill,
                  )
                   : Image.asset(
                    'lib/assets/alert.png',
                    fit: BoxFit.contain,
                   )
                  : PageView.builder(
                    controller: _pictureController,
                    itemCount: blackPoint_tapped.pictures!.length,
                    itemBuilder: (context , i){
                      return AnimatedBuilder(
                        animation: _pictureController, 
                        builder: ((context, child) {
                          return SizedBox(
                            child: child,
                          );
                      
                        }),
                        child:Image.network(
                          blackPoint_tapped.pictures![i],
                          fit: BoxFit.contain,
                        ));
                    }
                  )
              ),
            ],
          ),
        ),
        const Gap(20),
        Center(
          child: Text(
            blackPoint_tapped.type,
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        const Gap(20),
        Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              "Localisation",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 23,
              ),
            ),
            TextField(
              minLines: 1,
              maxLines: 2,
              controller: TextEditingController(
                  text: adresse_Tapped),
              enabled: false,
              decoration: InputDecoration(
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              autofocus: true,
              obscureText: false,
            ),
            const Gap(20),
            Text(
              "Description",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 23,
              ),
            ),
            SizedBox(
              child: TextField(
                readOnly: true,
                minLines: 3,
                maxLines: 7,
                controller: TextEditingController(
                    text:
                        blackPoint_tapped.description),
                enabled: false,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
                textInputAction:
                    TextInputAction.next,
                keyboardType: TextInputType.text,
                autofocus: true,
                obscureText: false,
              ),
            ),
            const Gap(30),
             Obx(()=>Row(
              children: [
              const Gap(35),
              checkApprouved.value
              
              ? const IconButton(
                  onPressed: null,
                  icon: Icon(
                    FontAwesomeIcons.solidCircleCheck,
                    color: Color.fromARGB(
                        255, 35, 98, 68),
                    size: 25,
                  ),
                )
              : IconButton(
                  onPressed: () {
                    FirestoreService.ApprouverBlackPoint(FirebaseAuth.instance.currentUser , blackPoint_tapped);
                    checkApprouved.value = true;
                    Get.delete<List<BlackPoint>>();
                    Get.offAll(()=>MyHomePage());
                  },
                  icon: const Icon(
                    FontAwesomeIcons.circleCheck,
                    color: Color.fromARGB(
                        255, 35, 98, 68),
                    size: 25,
                  ),
                ),
              const Gap(180),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  FontAwesomeIcons.comment,
                  color: Color.fromARGB(
                      255, 35, 98, 68),
                  size: 25,
                ),
              ),
            ])),
            const Gap(15),
             Obx(()=>Row(
             children: [
              const Gap(25),
              checkApprouved.value
              ? const Text(
                  "Approuvé",
                  style: TextStyle(fontSize: 16),
                )
              : const Text(
                  "Approuver",
                  style: TextStyle(fontSize: 16),
                ),
              const Gap(150),
              const Text(
                "Commenter",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ))
          ],
        ),
      ],
    ))));
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
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
                accessToken: "pk.eyJ1IjoibW9oYW1lZC1pc2xhbSIsImEiOiJjbGY5anVqd2UwcDF5NDFvMmJkZ2FrY3lpIn0.ezIz0mx77wVotsq9Z8C0qg",
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: LatLng(36.38214832844181, 3.8946823228767466),
                  zoom: 14.0, 
                ),
              )
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
                              Text("Trié par",style: Styles.subtitle,),
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
                                        disabledBackgroundColor: const Color(0xff5e81f4),
                                        backgroundColor: const Color.fromARGB(255, 240, 240, 240),
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
                                        disabledBackgroundColor: const Color(0xff5e81f4),
                                        backgroundColor: const Color.fromARGB(255, 240, 240, 240),
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
                                        disabledBackgroundColor: const Color(0xff5e81f4),
                                        backgroundColor: const Color.fromARGB(255, 240, 240, 240),
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
                                        disabledBackgroundColor: const Color(0xff5e81f4),
                                        backgroundColor: const Color.fromARGB(255, 240, 240, 240),
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
                                        disabledBackgroundColor: const Color(0xff5e81f4),
                                        backgroundColor: const Color.fromARGB(255, 240, 240, 240),
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
                                        disabledBackgroundColor: const Color(0xff5e81f4),
                                        backgroundColor: const Color.fromARGB(255, 240, 240, 240),
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
                                      child: Text("dernières 24h")
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
                                        disabledBackgroundColor: Color(0xff5e81f4),
                                        backgroundColor: Color.fromARGB(255, 240, 240, 240),
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
                                      child: const Text("la semaine passée")
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
                                child: DropDownButton(dropdownValues: type_list,onSelectedValue: (v){},),
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
                                      child: const Text("Supprimer"), 
                                    ),
                                    OutlinedButton(
                                      onPressed: (){}, 
                                      style: OutlinedButton.styleFrom(
                                        fixedSize: Size(0.38*w,50),
                                        backgroundColor: const Color(0xff5e81f4),
                                        foregroundColor: const Color.fromARGB(255, 240, 240, 240),
                                      ),
                                      child: const Text("Appliquer"),                                    
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