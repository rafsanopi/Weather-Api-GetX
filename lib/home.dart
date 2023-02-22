import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'controller/weather_controller.dart';

class HomePage extends StatelessWidget {
  final controller = Get.put(WeatherController());

  HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App with GetX"),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                controller.countryName.value.toString(),
                style: const TextStyle(fontSize: 40),
              ),
              Text(
                "${controller.temperature.value.toString()}°C",
                style: const TextStyle(fontSize: 30),
              ),
              Image.network(
                  "https://openweathermap.org/img/w/${controller.icon.value}.png"),
              Text(
                controller.description.value,
                style: const TextStyle(fontSize: 20),
              ),
              //
              //for 7 days forcast
              //
              // Expanded(
              //     child: ListView.builder(
              //         itemCount: controller.forecasts.length,
              //         itemBuilder: ((context, index) {
              //           final forecast = controller.forecasts[index];
              //           final date =
              //               DateFormat('MMM dd, yyyy').format(forecast.dt);
              //           final time = DateFormat('hh:mm a').format(forecast.dt);
              //           return ListTile(
              //             leading: Image.network(
              //               "https://openweathermap.org/img/w/${forecast.icon}.png",
              //               width: 50,
              //               height: 50,
              //             ),
              //             title: Text("$date $time"),
              //             subtitle: Text(
              //                 "${forecast.temperature.toString()}°C, ${forecast.description}"),
              //           );
              //         })))
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final city = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(
                title: const Text("Enter city name"),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onSubmitted: (value) {
                        Navigator.pop(context, value);
                      },
                    ),
                  ),
                ],
              );
            },
          );
          if (city != null) {
            controller.fetchWeather(city);
          }
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
