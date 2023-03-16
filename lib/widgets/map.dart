import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MyMap extends StatelessWidget {
  const MyMap({super.key});

  @override
  Widget build(BuildContext context) {
    return MapboxMap(
      accessToken: "sk.eyJ1IjoibW9oYW1lZC1pc2xhbSIsImEiOiJjbGY5a2E0bmkyMjU4M3pudHhnOXlnYmFhIn0.19k4OxrqxtMQuQhXnyDO_Q",
      onMapCreated: (c){},
      initialCameraPosition: CameraPosition(
        target: LatLng(36.38214832844181, 3.8946823228767466),
        zoom: 14.0, 
      )
    );
  }
}