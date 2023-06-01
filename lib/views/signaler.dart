import 'package:RouteDz/Client/Report_handle/Blackpoint_services.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../components/Blackpoint.dart';
import '../services/service.dart';
import '../utils/packs.dart';

class SignalerForm extends StatefulWidget {
  const SignalerForm({super.key});

  @override
  State<SignalerForm> createState() => _SignalerFormState();
}

class _SignalerFormState extends State<SignalerForm> {
  final TextEditingController _controllerSearch = TextEditingController();
  MapboxMapController? map_controller;
  

  Position? location;
  
  late List<String> wilayas;
  List<String> filteredItems = [];

  RxBool _islocated = false.obs;
  
  bool _isFocused = false;



  _onMapCreated(MapboxMapController controller)async{
    map_controller = controller;
    Future.delayed(Duration(seconds: 3));
    final ByteData bytes = await rootBundle.load("lib/assets/location.png");
    final Uint8List list = bytes.buffer.asUint8List();
    map_controller!.addImage("location-15",list);
  }


  
  void _updateLocation() {
    if (map_controller != null){
      map_controller!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(location!.latitude, location!.longitude),zoom: 14.0)
        )
      );
      map_controller!.addSymbol(SymbolOptions(
        geometry: LatLng(location!.latitude, location!.longitude),
        iconImage: "location-15",
        iconSize: 0.15,
      ));
    }
    _islocated.value = true;
  }


  Future<void> _loadStates()async{
    final states = await Service.getStateCode();
    setState(() {
      this.wilayas = states;
    });
    print(wilayas);
  }

  @override
  void dispose() {
    _controllerSearch.dispose();
    super.dispose();
  }
  @override
  void initState(){
    super.initState();
    _loadStates();
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
                onMapCreated: _onMapCreated,
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
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            width: width * 0.764,
                            child: TextFormField(
                              onTap: (){
                                setState(() {
                                  _isFocused = true;
                                  filterList("");
                                });
                              },
                              onEditingComplete: (){
                                setState(() {
                                  _isFocused = false;
                                });
                              },
                              controller: _controllerSearch,
                              onChanged: (text) => EasyDebounce.debounce('_controllerSearch',
                                  const Duration(milliseconds: 2000), () => {
                                      if (text.isEmpty) {
                                        setState(() {
                                          filteredItems.clear();
                                          filterList("");
                                        })
                                      } else {
                                        filterList(text)
                                      }
                                  }),
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
                        ],
                      ),
                    ],
                  ),
                ),
           Positioned(
              top: 70,
              left: 0,
              right: 0,
              child: Visibility(
                visible: _isFocused ? true : false,
                child: Container(
                  width: width,
                  margin: EdgeInsets.fromLTRB(50, 0, 60, 0),
                  height: 150,
                  color: Colors.white,
                  child: ListView.builder(
                      itemCount: filteredItems.length,
                      itemBuilder: (c, i) {
                        return ListTile(
                          title: Text(filteredItems[i]),
                         
                          onTap: (){
                            _controllerSearch.text = filteredItems[i];
                            setState(() {
                              _isFocused = false;
                            });
                          },
                        );
                      }),
                ),
              )),
          // ! se Localiser
          Align(
            alignment: AlignmentDirectional(0,0.8),
            child: MyCustomButton_widget2(
              text: "se Localiser",
              onPressed: ()async{
              bool checkGPS = await gpsCheck(context);
                if (checkGPS){
                  location = await Service.GetCurrentPosition(context);
                  if(location != null){
                    final Position _positionData = Get.put(location!); 
                    _updateLocation();
                  }
                }else{
                  _showActivateGPSDialog(context);
                  setState(() {
                    
                  });
                }
                
              },
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
                        color: Color(0xff5e81f4),
                      )
                    )
                  ),
                  onPressed: (){Get.back();},

                  child: Text("Annuler",style: TextStyle(color: Color(0xff5e81f4)),)),
                Obx (() => OutlinedButton(
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
                  onPressed: _islocated.isFalse ? null : (){Get.to(Info_supp());},
                  child: Text("Suivant")),)
              ],
            ),
          ),
        ),
    );    
  }


  void filterList(String query) {
    List<String> tempList = [];
    if (query=="") {
      tempList.addAll(wilayas);
    } else if (query.isNotEmpty) {
      for (int i = 0; i < wilayas.length; i++) {
        if (wilayas[i].toLowerCase().contains(query.toLowerCase())) {
          tempList.add(wilayas[i]);
        }
      }
    } 
    setState(() {
      filteredItems.clear();
      filteredItems.addAll(tempList);
    });
  }  
}

gpsCheck(BuildContext context) async {
    bool serviceEnabled;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    return serviceEnabled;
}


void _showActivateGPSDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Activate GPS'),
        content: Text('Please activate GPS to use this feature.'),
        actions: [
          TextButton(
            child: Text('Open Settings'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              Geolocator.openLocationSettings(); // Open device settings
            },
          ),
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ],
      );
    },
  );
}