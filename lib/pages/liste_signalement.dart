import 'package:RouteDz/Client/Report_handle/Blackpoint_services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../components/Blackpoint.dart';
import '../services/service.dart';
import '../widgets/custom_buttons.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:gap/gap.dart';


class Liste_Signalement extends StatefulWidget {
  const Liste_Signalement({super.key});

  @override
  State<Liste_Signalement> createState() => _Liste_SignalementState();
}

class _Liste_SignalementState extends State<Liste_Signalement> {


  final _controller = TextEditingController();
  final _pictureController = PageController(viewportFraction: 0.8);

  late List<BlackPoint> blackPoints;
  final List<String> adress_pn = Get.find();

  @override
  void initState(){
    blackPoints = Get.find();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                    height: h * 0.75,
                    child: ListView.builder(
                      itemCount: blackPoints.length,
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
                          RxBool checkApprouved = CheckUserApprouved(FirebaseAuth.instance.currentUser, blackPoints[index]).obs;
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
                                            child: blackPoints[index].pictures == null
                                              ? Image.asset(
                                                'lib/assets/warning.png',
                                                fit: BoxFit.fill,
                                              )
                                              : PageView.builder(
                                                controller: _pictureController,
                                                itemCount: blackPoints[index].pictures!.length,
                                                itemBuilder: (context , i){
                                                  return AnimatedBuilder(
                                                    animation: _pictureController, 
                                                    builder: ((context, child) {
                                                      return SizedBox(
                                                        child: child,
                                                      );
                                                  
                                                    }),
                                                    child:Image.network(
                                                      blackPoints[index].pictures![i],
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
                                        blackPoints[index].type,
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
                                                    blackPoints[index].description),
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
                                              onPressed: () {
                                                FirestoreService.ApprouverBlackPoint(FirebaseAuth.instance.currentUser , blackPoints[index]);
                                                checkApprouved.value = true;
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
                                              image: blackPoints[index].pictures == null
                                                ? AssetImage("lib/assets/warning.png")
                                                : CachedNetworkImageProvider(blackPoints[index].pictures![0]) as ImageProvider,
                                              fit: BoxFit.contain))),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: ListTile(
                                        title: Text(
                                          blackPoints[index].type,
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
                                              Text(blackPoints[index].description),
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
                  ),
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
