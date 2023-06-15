import 'package:RouteDz/Client/Report_handle/Blackpoint_services.dart';
import 'package:RouteDz/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../components/Blackpoint.dart';
import '../services/service.dart';
import '../utils/app_styles.dart';
import '../widgets/custom_buttons.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:gap/gap.dart';


class Liste_Signalement extends StatefulWidget {
  const Liste_Signalement({super.key});

  @override
  State<Liste_Signalement> createState() => _Liste_SignalementState();
}

class _Liste_SignalementState extends State<Liste_Signalement> {


  String selectedValue = "";
  // Etat buttons boolean for switch
  RxBool attente_btn = true.obs;
  RxBool enCour_btn = true.obs;
  RxBool terminer_btn = true.obs;
  
  // date buttons boolean for switch
  RxBool date_btn = true.obs;

  var type_list = ["Selectionner un type","Nid de poule","Erosion","Déformation","Fissure","Manque d'éclairage","Mauvaise signalisation","bordures dégradées","Dos-d'âne non conforme"]; // la liste des types 




  final _controller = TextEditingController();
  final _pictureController = PageController(viewportFraction: 0.8);

  late List<BlackPoint> blackPoints;
  final List<String> adress_pn = Get.find();
  late RxList<BlackPoint> blackpoint_current;
  late List<BlackPoint> myList;

  var commentController;

  @override
  void initState(){
    commentController = TextEditingController();
    blackPoints = Get.find();
    blackpoint_current = blackPoints.obs;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void filterBy(int? n , String? type , String? etat){
    myList = blackPoints;
    if(n != null){
      myList.sort((a,b){
        var adate = a.date;
        var bdate = b.date;
        return adate.compareTo(bdate);
      });
      blackpoint_current.value = myList;
    } else if (type != null){
      Logger().i("type : $type");
      myList = blackPoints.where((element) => element.type == type).toList();
      blackpoint_current.value = myList;
    } else if (etat != null){
      myList = blackPoints.where((element) => element.etat == etat).toList();
      blackpoint_current.value = myList;
    } else {
      blackpoint_current.value = blackPoints;
    }
  }


  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 5,
        leading: IconButton(
          icon: const FaIcon(
            FontAwesomeIcons.angleLeft,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "Liste des signalements ",
          style: TextStyle(
            fontSize: 21.sp,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, bottom: 15.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: w * 0.7,
                        child: TextFormField(
                          controller: _controller,
                          onChanged: (_) => EasyDebounce.debounce('_controller',
                              const Duration(milliseconds: 2000), () => {}),
                          autofocus: false,
                          textCapitalization: TextCapitalization.none,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Search..',
                            hintStyle: const TextStyle(fontFamily: "Roboto"),
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
                            fillColor: Color.fromRGBO(230, 230, 230, 1),
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
                      MyCustomButton_widget1(
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
                                          Container(margin: EdgeInsets.only(left: 25.w),child: Text("Filtre",style: Styles.headlineStyle1,)),
                                        ],
                                      ),
                                      SizedBox(height: 0.0509*w,),
                                      // ! buttons
                                      
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
                                                date_btn.value = true;
                                                enCour_btn.value = true;  
                                                attente_btn.value = false;
                                                terminer_btn.value = true;
                                                selectedValue = "";
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
                                                date_btn.value = true;
                                                enCour_btn.value = false;  
                                                attente_btn.value = true;
                                                terminer_btn.value = true;
                                                selectedValue = "";

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
                                                                     
                                                date_btn.value = true;
                                                enCour_btn.value = true;  
                                                attente_btn.value = true;
                                                terminer_btn.value = false;
                                                selectedValue = "";

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
                                              child: const Text("Terminé"),  
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
                                        child: 
                                            Obx(() => ElevatedButton(
                                              onPressed: date_btn.value ? (){
                                                date_btn.value = false;
                                                enCour_btn.value = true;  
                                                attente_btn.value = true;
                                                terminer_btn.value = true;
                                                selectedValue = "";

                                              } : null,
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0.0,
                                                disabledForegroundColor: Colors.white,
                                                foregroundColor: Colors.black,
                                                disabledBackgroundColor: const Color(0xff5e81f4),
                                                backgroundColor: const Color.fromARGB(255, 240, 240, 240),
                                                fixedSize: Size(w,50),
                                                shape: const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.only(
                                                    topRight: Radius.zero,
                                                    bottomRight: Radius.zero,
                                                    topLeft: Radius.circular(15.0),
                                                    bottomLeft: Radius.circular(15.0)
                                                  )
                                                )
                                              ),
                                              child: Text("Du plus recent au plus ancien"),
                                            )),
                                            
                                      ),
                                      // ! TYPE
                                      SizedBox(height: 0.0509*w),
                                      Text("Type",style:Styles.subtitle),
                                      // ! buttons
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(25,8,25,8),
                                        child: DropDownButton(dropdownValues: type_list,onSelectedValue: (v){
                                          selectedValue = v;
                                          date_btn.value = true;
                                          enCour_btn.value = true;  
                                          attente_btn.value = true;
                                          terminer_btn.value = true;
                                          
                                          },),
                                      ),
                                      // ! Apply buttons
                                      SizedBox(height: 0.076*w),
                                      Padding(
                                        padding: EdgeInsets.all(0.0509*w),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            OutlinedButton(
                                              onPressed: (){
                                                date_btn.value = true;
                                                enCour_btn.value = true;  
                                                attente_btn.value = true;
                                                terminer_btn.value = true;
                                                selectedValue = "";
                                                blackpoint_current.value = blackPoints;
                                              }, 
                                              style: OutlinedButton.styleFrom(
                                                foregroundColor: Colors.black,
                                                backgroundColor: const Color.fromARGB(255, 240, 240, 240),
                                                fixedSize: Size(0.38*w, 50),
                                              ),
                                              child: const Text("Supprimer"), 
                                            ),
                                            OutlinedButton(
                                              onPressed: (){
                                                Logger().i(selectedValue);
                                                if (!enCour_btn.value){
                                                  filterBy(null, null, "En cours");
                                                } else if (!attente_btn.value){
                                                  filterBy(null, null, "En attente");
                                                } else if (!terminer_btn.value){
                                                  filterBy(null, null, "Terminé");
                                                } else if (!date_btn.value){
                                                  filterBy(1, null, null);
                                                } else if (selectedValue != ""){
                                                  filterBy(null, selectedValue, null);
                                                }
                                                Get.back();
                                              }, 
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
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                    height: h * 0.75,
                    child: Obx(()=> ListView.builder(
                      itemCount: blackpoint_current.length,
                      itemBuilder: (BuildContext context, int index){
                        return GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        backgroundColor: Color.fromARGB(255, 255, 255, 255),
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          RxBool checkApprouved = CheckUserApprouved(FirebaseAuth.instance.currentUser, blackpoint_current[index]).obs;
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
                                            child: blackpoint_current[index].pictures == null
                                              ? blackpoint_current[index].approuvedBy == null || blackpoint_current[index].approuvedBy!.isEmpty || blackpoint_current[index].approuvedBy!.length < 5
                                                ? Image.asset('lib/assets/warning.png',fit: BoxFit.fill,)
                                                : Image.asset('lib/assets/alert.png',fit: BoxFit.contain,)
                                              : PageView.builder(
                                                controller: _pictureController,
                                                itemCount: blackpoint_current[index].pictures!.length,
                                                itemBuilder: (context , i){
                                                  return AnimatedBuilder(
                                                    animation: _pictureController, 
                                                    builder: ((context, child) {
                                                      return SizedBox(
                                                        child: child,
                                                      );
                                                  
                                                    }),
                                                    child:Image.network(
                                                      blackpoint_current[index].pictures![i],
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
                                        blackpoint_current[index].type,
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
                                              text: adress_pn[index]),
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
                                                    blackpoint_current[index].description),
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
                                                FirestoreService.ApprouverBlackPoint(FirebaseAuth.instance.currentUser , blackpoint_current[index]);
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
                                            onPressed:(){}
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
                                                    height: h*0.73,
                                                    child :ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: blackpoint_current[index].comments == null || blackpoint_current[index].comments!.isEmpty ? null : blackpoint_current[index].comments!.length,
                                                    itemBuilder: (BuildContext context, int i){
                                                      return blackpoint_current[index].comments == null || blackpoint_current[index].comments!.isEmpty ?
                                                        null
                                                        :ListTile(
                                                          title: Text(blackpoint_current[index].comments![i]),
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
                                                      IconButton(icon: FaIcon(FontAwesomeIcons.chevronRight), onPressed: (){}),
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
                          },
                          child: Card(
                            color: Colors.white,
                            elevation: 10.0,
                            clipBehavior: Clip.hardEdge,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            margin: EdgeInsets.all(10),
                            child: Container(
                              height: 125,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      height: 100,
                                      margin:
                                          EdgeInsets.only(top: 12.5, left: 12.2),
                                      width: 150,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          image: DecorationImage(
                                              image: blackpoint_current[index].pictures == null || blackpoint_current[index].pictures!.isEmpty
                                                ? 
                                                blackpoint_current[index].approuvedBy == null || blackpoint_current[index].approuvedBy!.isEmpty || blackpoint_current[index].approuvedBy!.length < 5
                                                  ? AssetImage("lib/assets/warning.png")
                                                  : AssetImage("lib/assets/alert.png")
                                                : CachedNetworkImageProvider(blackpoint_current[index].pictures![0]) as ImageProvider,
                                              fit: BoxFit.contain))),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: ListTile(
                                        title: Text(
                                          blackpoint_current[index].type,
                                          style: TextStyle(fontSize: 20.sp),
                                        ),
                                        subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                    FontAwesomeIcons.locationDot,
                                                    color: Color.fromARGB(
                                                        255, 35, 98, 68),
                                                    size: 15,
                                                  ),
                                                  const Gap(5),
                                                  Expanded(
                                                    child: Text(
                                                      adress_pn[index],
                                                      style: const TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 35, 98, 68)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(blackpoint_current[index].description),
                                            ]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}


bool CheckUserApprouved(User? currentUser , BlackPoint pn) {
  List<String>? approuved = pn.approuvedBy;
  
  if(approuved != null && currentUser != null){
    for (String item in approuved){
      if (item == currentUser.uid){
        return true;
      }
    }
  }
  return false;
}
