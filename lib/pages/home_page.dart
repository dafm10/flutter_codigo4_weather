import 'package:flutter/material.dart';
import 'package:flutter_codigo4_weather/services/api_services.dart';
import 'package:flutter_codigo4_weather/ui/general/colors.dart';
import 'package:flutter_codigo4_weather/ui/widgets/general_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final TextEditingController _searchEditingController = TextEditingController();
  final APIService _apiService = APIService();
  String city = "";
  String country = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _getDataWeather(){
    String search = _searchEditingController.text;
    _apiService.getDataWeather(search).then((value) {
      if(value != null){
        city = value.name;
        country = value.sys.country;
        setState(() {

        });
      }
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
      ),
      body: SingleChildScrollView(
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
                    "27",
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
                    _getDataWeather();
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
                      onTap: (){
                        print(index);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        width: _width * 0.205,
                        decoration: BoxDecoration(
                          color: Color(0xff363940),
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
    );
  }
}
