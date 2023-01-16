import 'package:decagon_weather/core/constant/app_asset.dart';
import 'package:decagon_weather/core/constant/app_textstyle.dart';
import 'package:decagon_weather/core/constant/ui_helpers.dart';
import 'package:decagon_weather/core/utils/enums.dart';
import 'package:decagon_weather/features/weather_page/domain/entities/weather_entries.dart';
import 'package:flutter/material.dart';

class ImageDisplay extends StatelessWidget {
  final WeatherEntities weatherEntities;
  final String weather;
  const ImageDisplay({super.key, required this.weatherEntities, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
            weather == WeatherEnum.cloudy.name
                ? AppAsset.cloudyS
                : weather == WeatherEnum.sunny.name
                    ? AppAsset.sunnyS
                    : AppAsset.rainyS,
            fit: BoxFit.cover,
            width: screenWidth(context)),
        Positioned(
            top: 20,
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${weatherEntities.main.temp}°",
                    style: AppTextStyle.kHeader4TextStyle,
                  ),
                  Text(
                    weather == WeatherEnum.cloudy.name
                        ? "CLOUDY"
                        : weather == WeatherEnum.sunny.name
                            ? "SUNNY"
                            : "RAINY",
                            style: AppTextStyle.kHeader4PictureTextStyle,
                  )
                ],
              ),
            )),
        // const Positioned(
        // top: 0,
        // bottom: 0,
        // left: 0,
        // right: 0,
        // child: ImageIcon(
        //   AssetImage(AppAsset.sun),
        // )),
      ],
    );
  }
}
