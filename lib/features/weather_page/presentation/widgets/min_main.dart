import 'package:decagon_weather/core/constant/app_colour.dart';
import 'package:decagon_weather/core/constant/app_textstyle.dart';
import 'package:decagon_weather/core/utils/enums.dart';
import 'package:decagon_weather/features/weather_page/domain/entities/weather_entries.dart';
import 'package:flutter/material.dart';

class MinMax extends StatelessWidget {
  final WeatherEntities entities;
  final String weather;
  const MinMax({
    super.key,
    required this.entities,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: weather == WeatherEnum.cloudy.name
            ? AppColor.kcloudy
            : weather == WeatherEnum.sunny.name
                ? AppColor.ksunny
                : AppColor.krainny,
      ),
      child: Padding(
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
                  "${entities.main.tempMin}°",
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
                  "${entities.main.temp}°",
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
                  "${entities.main.tempMax}°",
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
    );
  }
}
