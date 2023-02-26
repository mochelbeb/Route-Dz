import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../widgets/custom_buttons.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Stack(
        children: [
          //* Map Area
          Align(
            alignment: const AlignmentDirectional(0, 0),
            child: Container(
              width: w,
              height: h * 1,
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
          //* Map Button
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
          //* Search Bar
          Align(
            alignment: const AlignmentDirectional(-0.6, -0.91),
            child: Container(
              width: w * 0.693,
              child: TextFormField(
                controller: _controller,
                onChanged: (_) => EasyDebounce.debounce('_controller',
                    const Duration(milliseconds: 2000), () => {}),
                autofocus: true,
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
          //* Liste Button
          Align(
            alignment: AlignmentDirectional(-0.8, 0.9),
            child: MyCustomButton_widget2(
              onPressed: () {},
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
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          //* Menu Button
          Align(
            alignment: AlignmentDirectional(0.87, -0.91),
            child: MyCustomButton_widget1(
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
          ),
          //* Location Button
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
