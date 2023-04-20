import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../widgets/custom_buttons.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:gap/gap.dart';

class MyClass {
  String titre;
  String localisation;
  String discription;
  MyClass({
    required this.titre,
    required this.localisation,
    required this.discription,
  });
}

class Liste_Signalement extends StatelessWidget {
  final _controller = TextEditingController();
  
  List<AssetImage> images = [
    AssetImage("lib/assets/pn1.png"),
    AssetImage("lib/assets/pn2.png"),
    AssetImage("lib/assets/pn3.png"),
    AssetImage("lib/assets/pn1.png"),
    AssetImage("lib/assets/pn2.png"),
    AssetImage("lib/assets/pn3.png"),
    AssetImage("lib/assets/pn1.png"),
    AssetImage("lib/assets/pn2.png"),

  ];

  final List<MyClass> itemlist = [
    MyClass(
      titre: 'TYPE 1',
      discription: 'discription 1',
      localisation: 'localisation 1',
    ),
    MyClass(
      titre: 'TYPE 2',
      discription: 'discription 2',
      localisation: 'localisation 2',
    ),
    MyClass(
      titre: 'TYPE 3',
      discription: 'discription 3',
      localisation: 'localisation 3',
    ),
    MyClass(
      titre: 'TYPE 4',
      localisation: 'localisation 4',
      discription: 'discription 4',
    ),
    MyClass(
      titre: 'TYPE 5',
      localisation: 'localisation 5',
      discription: 'discription 5',
    ),
    MyClass(
      titre: 'TYPE 6',
      localisation: 'localisation 6',
      discription: 'discription 6',
    ),
    MyClass(
      titre: 'TYPE 7',
      discription: 'discription 7',
      localisation: 'localisation 7',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.white,
        elevation: 5,
        leading: IconButton(
          icon: FaIcon(
            FontAwesomeIcons.angleLeft ,
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
                padding: const EdgeInsets.only(left:10.0 , right: 10.0,bottom: 15.0),
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
                            hintStyle: TextStyle(fontFamily: "Roboto"),
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
                        icon: FaIcon(
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
                  itemCount: 7,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
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
                                margin: EdgeInsets.only(top: 12.5,left: 12.2),
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(image: images[index],fit: BoxFit.fill))
                                ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top:10.0),
                                  child: ListTile(
                                    title: Text(
                                      itemlist[index].titre,
                                      style: TextStyle(fontSize: 20.sp),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                      Row(
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.locationDot,
                                            color:
                                                Color.fromARGB(255, 35, 98, 68),
                                            size: 15,
                                          ),
                                          const Gap(5),
                                          Expanded(
                                            child: Text(
                                              itemlist[index].localisation,
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 35, 98, 68)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(itemlist[index].discription),
                                    ]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
