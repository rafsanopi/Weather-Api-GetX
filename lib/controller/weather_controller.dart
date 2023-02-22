import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class WeatherController extends GetxController {
  var isLoading = true.obs;
  var temperature = 0.0.obs;
  var description = "".obs;
  var icon = "".obs;
  var countryName = "".obs;

  Future<void> fetchWeather(String city) async {
    isLoading.value = true;

    String api = "1ac68d4683b65b3542756524b842d9b1";
    final url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$api&units=metric";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        //   print(data);
        temperature.value = data['main']['temp'];
        description.value = data['weather'][0]['description'];
        icon.value = data['weather'][0]['icon'];
        countryName.value = data["name"];
        // print(forecast);
      }
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    fetchWeather("dhaka");
    super.onInit();
  }
}



//All Arguments

      // temperature.value = data['main']['temp'];
      // description.value = data['weather'][0]['description'];
      // icon.value = data['weather'][0]['icon'];
      // humidity.value = data['main']['humidity'];
      // pressure.value = data['main']['pressure'];
      // windSpeed.value = data['wind']['speed'];
      // windDirection.value = data['wind']['deg'];
      // clouds.value = data['clouds']['all'];
      // sunrise.value = DateTime.fromMillisecondsSinceEpoch(
      //     data['sys']['sunrise'] * 1000);
      // sunset.value =
      //     DateTime.fromMillisecondsSinceEpoch(data['sys']['sunset'] * 1000);

//7 day forcast

// class Forecast {
//   final DateTime dt;
//   final double temperature;
//   final String description;
//   final String icon;

//   Forecast(this.dt, this.temperature, this.description, this.icon);
// }

 //
        // temperature.value = data['list'][0]['temp']['day'];
        // description.value = data['list'][0]['weather'][0]['description'];
        // icon.value = data['list'][0]['weather'][0]['icon'];

        // for (var forecast in data['list']) {
        //   final dt = DateTime.fromMillisecondsSinceEpoch(forecast['dt'] * 1000);
        //   final temperature = forecast['main']['temp'].toDouble();
        //   final description = forecast['weather'][0]['description'];
        //   final icon = forecast['weather'][0]['icon'];
        //   final newForecast = Forecast(dt, temperature, description, icon);
        //    forecasts.add(newForecast);
        // }


  // var forecasts = List<Forecast>.empty(growable: true).obs;
