import 'dart:io';
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

  RxBool listButton = false.obs;

  RxBool SymbolsAdded = false.obs;

  late TextEditingController _controller;
  MapboxMapController? mapController;
  late TextEditingController commentController;


  List<Symbol> symbol_list = [];
  List<BlackPoint> BlackPoints = [];
  List<String> adress = [];
  List<File>? resultList;

  Future<void> _pick_BP_images(String docId) async {
  // show bottomSheet to make choice between camera and gallery
    Get.bottomSheet(
      BottomSheet(onClosing: (){}, builder: (context){
        return Container(
          height: 130,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(100, 50),
                ),
                onPressed: ()async{
                  List<File?> result = await Service.pickImageFrom("camera");
                  Logger().i("GET IMAGES FROM CAMERA : $result");
                  if(result.isNotEmpty){
                    resultList = result as List<File>;
                    Logger().i("PHOTO UPLOADED : $resultList");
                    var unpload = await FirestoreService.uplaod(resultList! , docId);
                  }
                  Get.offAll(MyHomePage());

              }, child: Text("Camera")),
              ElevatedButton(
                onPressed: ()async{
                  Get.back();
                  var result = await Service.pickImageFrom("Gallery");
                  Logger().i("GET IMAGES FROM GALLERY : $result");
                  if(result.isNotEmpty){
                    resultList = result as List<File>;
                    Logger().i("PHOTO UPLOADED : $resultList");
                    var unpload = await FirestoreService.uplaod(resultList! , docId);
                  }
                  Get.offAll(MyHomePage());

              }, child: Text("Galerie")),
            ],
          ),
        );
      })
    );    
  }



  
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
      symbol_list.add(new_sym);
      mapController!.addSymbol(new_sym.options, {'id' : new_sym.id});
    });

    BlackPoints.forEach((pn) async {
      String ad = await Service.getStateAndProvinceFromLatLng(pn.coordinate.latitude, pn.coordinate.longitude);
      adress.add(ad);
    });   
    
    final List<String> _adress_data = Get.put(adress);
    final List<BlackPoint> _data = Get.put(BlackPoints);

    listButton.value = true;
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
    commentController = TextEditingController();
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
                        builder: (context) {
                          RxBool checkApprouved = CheckUserApprouved(FirebaseAuth.instance.currentUser, blackPoint_tapped).obs;
                          return SizedBox(
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
                                              ? blackPoint_tapped.approuvedBy == null || blackPoint_tapped.approuvedBy!.isEmpty || blackPoint_tapped.approuvedBy!.length < 5
                                                ? Image.asset('lib/assets/warning.png',fit: BoxFit.fill,)
                                                : Image.asset('lib/assets/alert.png',fit: BoxFit.contain,)
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
                                        style: const TextStyle(
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
                                        const Text(
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
                                              text: adresse_Tapped,),
                                          enabled: false,
                                          decoration: const InputDecoration(
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(),
                                          ),
                                          textInputAction: TextInputAction.next,
                                          keyboardType: TextInputType.text,
                                          autofocus: true,
                                          obscureText: false,
                                        ),
                                        const Gap(20),
                                        const Text(
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
                                            decoration: const InputDecoration(
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
                                              onPressed: FirebaseAuth.instance.currentUser != null 
                                              ? () {
                                                FirestoreService.ApprouverBlackPoint(FirebaseAuth.instance.currentUser , blackPoint_tapped);
                                                checkApprouved.value = true;
                                                Get.offAll(()=>MyHomePage());
                                              }
                                              : null,
                                              icon: const Icon(
                                                FontAwesomeIcons.circleCheck,
                                                color: Color.fromARGB(
                                                    255, 35, 98, 68),
                                                size: 25,
                                              ),
                                            ),
                                          const Gap(77),
                                          IconButton(
                                            icon: const Icon(
                                              FontAwesomeIcons.image,
                                              color: Color.fromARGB(
                                                  255, 35, 98, 68),
                                              size: 25,
                                            ),
                                            onPressed:() async {
                                              var response = await _pick_BP_images(blackPoint_tapped.id!);
                                              
                                            } // ** Illuster avec des images ** // 
                                          ),


                                          const Gap(70),
                                          IconButton(
                                            onPressed: () {
                                              // show dialog box that shows the List of comments and text field to add a comment and a button to add the comment
                                              showDialog(context: context, builder: (context){
                                                return AlertDialog(
                                                  title: const Text("Commentaires"),
                                                  content: Column(
                                                  children: [
                                                  SizedBox(
                                                    width: 400,
                                                    height: MediaQuery.of(context).size.height*0.73,
                                                    child :ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: blackPoint_tapped.comments == null || blackPoint_tapped.comments!.isEmpty ? null : blackPoint_tapped.comments!.length,
                                                    itemBuilder: (BuildContext context, int i){
                                                      return blackPoint_tapped.comments == null || blackPoint_tapped.comments!.isEmpty ?
                                                        null
                                                        :ListTile(
                                                          title: Text(blackPoint_tapped.comments![i]),
                                                        );
                                                    }
                                                  )),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 200,
                                                        child: TextField(
                                                          controller: commentController,
                                                          decoration: const InputDecoration(
                                                          hintText: "Ajouter un commentaire",
                                                          ),
                                                                                                          ),
                                                      ),
                                                      const Gap(10),
                                                      IconButton(
                                                        icon: FaIcon(FontAwesomeIcons.chevronRight),
                                                        onPressed: (){
                                                          FirestoreService.addCommentToBlackPoint(blackPoint_tapped, commentController.text);
                                                          if ( blackPoint_tapped.comments == null){
                                                            blackPoint_tapped.comments = [];
                                                            blackPoint_tapped.comments!.add(commentController.text);
                                                          }
                                                          else{
                                                            blackPoint_tapped.comments!.add(commentController.text);
                                                          }
                                                          commentController.clear();
                                                          Get.offAll(()=>MyHomePage());
                                                        }),
                                                    ],
                                                  )
                                                ],));
                                              });
                                            },
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
                                            const Gap(60),
                                            const Text(
                                              "Illustrer",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            const Gap(50),
                                            const Text(
                                              "Commenter",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ))
                                      ],
                                    ),
                                  ],
                                )));});
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
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
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
            child: Obx(() => MyCustomButton_widget2(
              onPressed: listButton.value ?  () {
                // $$ changement ici 
                Get.to(Liste_Signalement());
              }
              : null,
              text: 'Liste',
              icon: Icon(
                FontAwesomeIcons.bars,
                color: Colors.black,
                size: 18.sp,
              ),
              options: Button_Option(
                disabledColor : Colors.grey,
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
            )),
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