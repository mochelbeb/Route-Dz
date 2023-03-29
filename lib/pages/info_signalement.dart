import 'package:responsive_sizer/responsive_sizer.dart';
import '../utils/packs.dart';



class Info_supp extends StatefulWidget {
  const Info_supp({super.key});

  @override
  State<Info_supp> createState() => _Info_suppState();
}

class _Info_suppState extends State<Info_supp> {
  final _controllerDescription = TextEditingController();
  List<String> type_list  = ["type1","type2","type3","type4","type5"];
  late bool _isButtonDisable;


  @override
  void dispose() {
    _controllerDescription.dispose();
    super.dispose();
  }
  @override
  void initState() {
    _isButtonDisable = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
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
                  child: Text("Cancel")),
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
                  onPressed: _isButtonDisable ? null : (){},
                  child: Text("Submit")),
              ],
            ),
          ),
        ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 5,
        leading: IconButton(icon: FaIcon(FontAwesomeIcons.xmark,color: Colors.black,),onPressed: (){Get.back();},),
        title: Text("Ajouter Point Noir" , style: TextStyle(fontFamily: "Raleway",fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Get.defaultDialog(
              title: "Informations",
              content: Column(
                children: [
                  Text("1- il est important d'avoir une description claire de l'emplacement du point noir."),
                  Text("2- Vous pouvez ajouter jusqu'à 10 photos du point noir."),
                  Text("3- Si vous ne trouvez pas le type approprié, choisissez \"Autre\" et fournissez une description détaillée "),
                ],
              ),
              cancel: TextButton(onPressed: (){Get.back();}, child: Text("Retoure"))
            );
          }, icon: FaIcon(FontAwesomeIcons.circleInfo,color: Colors.black,))
        ],
      ),
      body: Container(
            width: width,
            height: height,
            margin: EdgeInsets.only(top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* title
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text("Signalement d'un point noir:",style:TextStyle(fontFamily: "Poppins",fontSize: 18.sp,)),
              ),
              SizedBox(height: 2.35.h,),
              //* Image 
              GestureDetector(
                onTap: (){
                  Get.defaultDialog(
                    title: "Ajouter des Photos",
                    content: Text("Ajouter des photos de votre point noir ici"),
                    confirm: TextButton(onPressed: (){Get.back();},
                    child: Text("Confirmer")));
                },
                child: Container(
                  height: 0.332 * height,
                  width: width,
                  margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.black12
                  ),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children : [
                      FaIcon(FontAwesomeIcons.camera,),
                      Text("Ajouter des photos",style: TextStyle(fontFamily: "Roboto"),)
                          ]),
                  ),
                  
                ),
              ),
              SizedBox(height: 2.35.h,),
              //* Type Text
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text("Choisir un type :", style: Styles.textStyle),
              ),
              //* Type Dropdown
              SizedBox(height: 2.35.h,),
              Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: DropDownButton(dropdownValues: type_list),
              ),
              //* Description text
              SizedBox(height: 2.35.h,),
              Padding(padding: EdgeInsets.only(left: 15),child: Text("Ajouter une description : ",style: Styles.textStyle,),),
              //* Description Text Area
              SizedBox(height: 2.35.h,),
              Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: TextField(
                  controller: _controllerDescription,
                  onChanged: (value){
                    setState(() {
                      if (value.isEmpty){
                        _isButtonDisable = true;
                      }
                      else _isButtonDisable = false;
                    });
                  },
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Ajouter une breve description du point noir et l'adresse .. etc ",
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 1.5),borderRadius: BorderRadius.all(Radius.circular(15)))
                  ),
                  keyboardType: TextInputType.text,
              
                ),
              ),
            ],
        ),
      ),
    );
  }
}
