import 'package:flutter/material.dart';
import 'package:flutter_codigo4_weather/services/api_services.dart';
import 'package:flutter_codigo4_weather/ui/general/colors.dart';
import 'package:flutter_codigo4_weather/ui/widgets/general_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchEditingController =
      TextEditingController();
  final APIService _apiService = APIService();
  String city = "";
  String country = "";
  String temp = "";
  bool isLoading = false;
  double latitud = 0;
  double longitud = 0;
  int indexSelected = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDataWeatherLocation();
  }

  _getDataWeatherLocation() async {
/*    Position _position = await Geolocator.getCurrentPosition(
      // la precisión que va a tener va a ser alta: high, medium, best, low, etc
      desiredAccuracy: LocationAccuracy.high,
    );
    latitud = _position.latitude;
    longitud = _position.longitude;
    print(_position);*/
  Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((position) {
    _apiService.getDataWeatherLocation(position).then((value) {
      if(value != null){
        city = value.name;
        country = value.sys.country;
        temp = (value.main.temp - 273.15).toStringAsFixed(0);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              "Hubo un error, por favor inténtalo nuevamente.",
            ),
            backgroundColor: Colors.redAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
      // cuando se tiene los valores, isLoading pasa a false
      isLoading = false;
      setState(() {

      });
    });
  });
  }

  _getDataWeather() {
    String search = _searchEditingController.text;
    _apiService.getDataWeather(search).then((value) {
      if (value != null) {
        city = value.name;
        country = value.sys.country;
        temp = (value.main.temp - 273.15).toStringAsFixed(0);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              "Hubo un error, por favor inténtalo nuevamente.",
            ),
            backgroundColor: Colors.redAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
      isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: COLOR_PRIMARY,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: const Icon(Icons.menu),
        title: const Text(
          "Weather App",
          style: TextStyle(fontSize: 16.0),
        ),
        actions: [
          IconButton(
            onPressed: () {
              isLoading = true;
              setState(() {

              });
              _getDataWeatherLocation();
            },
            icon: Icon(Icons.location_on),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  divider20,
                  SvgPicture.asset(
                    "assets/images/bx-sun.svg",
                    color: Colors.white,
                    height: _height * 0.07,
                  ),
                  divider10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        temp,
                        style: TextStyle(
                          fontSize: _height * 0.12,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            "ºC",
                            style: TextStyle(
                              fontSize: _height * 0.025,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  divider20,
                  Text(
                    "$city, $country",
                  ),
                  divider20,
                  TextField(
                    controller: _searchEditingController,
                    cursorColor: COLOR_PRIMARY,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: COLOR_PRIMARY,
                    ),
                    decoration: InputDecoration(
                      hintText: "Enter city",
                      hintStyle: const TextStyle(
                        color: COLOR_PRIMARY,
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: COLOR_PRIMARY,
                      ),
                      filled: true,
                      fillColor: Color(0xffe2e2e2),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                  ),
                  divider20,
                  Container(
                    height: _height * 0.06,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: COLOR_SECONDARY,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      onPressed: () {
                        isLoading = true;
                        setState(() {});
                        _getDataWeather();
                        _searchEditingController.clear();
                      },
                      child: const Text(
                        "Search",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                  divider20,
                  Container(
                    height: _height * 0.24,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      physics: const BouncingScrollPhysics(),
                      itemCount: 7,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            print(index);
                            indexSelected = index;
                            setState(() {

                            });
                          },
                          child: Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            width: _width * 0.205,
                            decoration: BoxDecoration(
                              color: indexSelected == index ? COLOR_SECONDARY : Color(0xff363940) ,
                              borderRadius: BorderRadius.circular(60.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12.withOpacity(0.3),
                                  blurRadius: 10.0,
                                  offset: const Offset(4, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "9 AM",
                                  style: TextStyle(),
                                ),
                                SvgPicture.asset(
                                  "assets/images/bx-sun.svg",
                                  color: Colors.white,
                                  height: _height * 0.04,
                                ),
                                Text(
                                  "24ºC",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
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
          isLoading
              ? Container(
                  color: COLOR_PRIMARY.withOpacity(0.5),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: COLOR_SECONDARY,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
