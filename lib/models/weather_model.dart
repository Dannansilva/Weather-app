class weather {
  final String cityName;
  final double temperature;
  final String mainCondition;

  weather({
    required this.cityName,
    required this.mainCondition,
    required this.temperature,
  });
  factory weather.fromJson(Map<String, dynamic> json) {
    return weather(
        cityName: json['name'],
        mainCondition: json['main']['temp'].toDouble(),
        temperature: json['weather'][0]['main']);
  }
}
