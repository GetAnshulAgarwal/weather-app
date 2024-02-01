import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget getWeatherIcon(int code) {
    switch (code) {
      case >= 200 && <= 300:
        return Image.asset('assets/thunder.jpg');
      case >= 300 && <= 400:
        return Image.asset('assets/heavy.jpg');
      case >= 500 && <= 600:
        return Image.asset('assets/rain.jpg');
      case >= 600 && <= 700:
        return Image.asset('assets/snow.jpg');
      case == 800:
        return Image.asset('assets/heat.jpg');
      case > 700 && <= 800:
        return Image.asset('assets/snow.jpg');
      case > 800 && <= 804:
        return Image.asset('assets/sunny.jpg');
      default:
        return Image.asset('assets/sunny.jpg');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Align(
                  alignment: const AlignmentDirectional(3, -0.3),
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(-3, -0.3),
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
                Align(
                    alignment: const AlignmentDirectional(0, -1.2),
                    child: Container(
                      height: 300,
                      width: 600,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFAB40),
                      ),
                    )),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.transparent),
                  ),
                ),
                BlocBuilder<WeatherBloc, WeatherBlocState>(
                  builder: (context, state) {
                    if (state is WeatherBlocSuccess) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.height,
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '📍${state.weather.areaName}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              'Good-morning',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            getWeatherIcon(state.weather.weatherConditionCode!),
                            // Image.asset('assets/heavy.jpg'),
                            Center(
                              child: Text(
                                '${state.weather.temperature!.celsius!.round()}°C',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 55,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                state.weather.weatherMain!.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: Text(
                                DateFormat('EEEE  dd .')
                                    .add_jm()
                                    .format(state.weather.date!),
                                // 'Saturday 27 - 01:27AM',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/sun.jpg',
                                      scale: 8,
                                    ),
                                    const SizedBox(width: 5),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'SunRise',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          DateFormat()
                                              .add_jm()
                                              .format(state.weather.sunrise!),
                                          // '2.20AM',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/moon.jpg',
                                      scale: 8,
                                    ),
                                    const SizedBox(width: 5),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'SunSet',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          DateFormat()
                                              .add_jm()
                                              .format(state.weather.sunset!),
                                          //  '2.20 pm',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              child: Divider(
                                color: Colors.grey,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/max.jpg',
                                      scale: 8,
                                    ),
                                    const SizedBox(width: 5),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          ' Max Temperature',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          "${state.weather.tempMax!.celsius!.round()} °C",
                                          //'8°C',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/min.jpg',
                                      scale: 8,
                                    ),
                                    const SizedBox(width: 5),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Min Temperature',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          "${state.weather.tempMin!.celsius!.round()} °C",
                                          //'12°C',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                )
              ],
            ),
          )),
    );
  }
}
