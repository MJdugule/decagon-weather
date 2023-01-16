import 'package:decagon_weather/core/constant/app_asset.dart';
import 'package:decagon_weather/core/constant/app_divider.dart';
import 'package:decagon_weather/core/constant/app_textstyle.dart';
import 'package:decagon_weather/features/weather_page/domain/entities/weather_entries.dart';
import 'package:decagon_weather/features/weather_page/presentation/provider/five_weather_notifier.dart';
import 'package:decagon_weather/features/weather_page/presentation/provider/weather_notifier.dart';
import 'package:decagon_weather/features/weather_page/presentation/provider/weather_state.dart';
import 'package:decagon_weather/features/weather_page/presentation/widgets/image_display.dart';
import 'package:decagon_weather/features/weather_page/presentation/widgets/min_main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  WeatherState? state;
  WeatherEntities? weatherEntities;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<WeatherNotifier>(builder: (context, value, child) {
        value.requestDeviceLocation(context);
        if (value.state is Loaded) {
          return Column(
            children: [
              ImageDisplay(
                  weatherEntities: value.entities!,
                  weather: value.entities!.main.temp.toString()),
              MinMax(
                  entities: value.entities!,
                  weather: value.entities!.main.temp.toString()),
              spacedDivider,
              Consumer<FiveDayWeatherNotifier>(
                  builder: (context, fivevalue, child) {
                fivevalue.requestDeviceLocation(context);
                //print(fivevalue.fiveDaysEntities!.list.first.weather!.first.id);
                return const Text("data");
              })
            ],
          );
        } else if (value.state is Loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (value.state is LoadedFiveDay) {}
        //print(value.entities);
        if (value.fiveDaysEntities != null) {}

        return Column(
          children: [
            const Text("Loading"),
            Expanded(
              child: Container(
                color: const Color.fromARGB(255, 92, 131, 142),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "16°",
                                style: AppTextStyle.kTodayTextStyle,
                              ),
                              Text(
                                "min",
                                style: AppTextStyle.kTodayTextStyle,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "15°",
                                style: AppTextStyle.kTodayTextStyle,
                              ),
                              Text(
                                "current",
                                style: AppTextStyle.kTodayTextStyle,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "15°",
                                style: AppTextStyle.kTodayTextStyle,
                              ),
                              Text(
                                "max",
                                style: AppTextStyle.kTodayTextStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    spacedDivider,
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            return ListTile(
                              dense: false,
                              textColor: Colors.white,
                              leading: Text(
                                "data",
                                style: AppTextStyle.kWeekNameTextStyle,
                              ),
                              title: const Center(
                                  child: ImageIcon(
                                AssetImage(AppAsset.rain),
                                size: 18,
                                color: Colors.white,
                              )),
                              trailing: const Text("70°"),
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
