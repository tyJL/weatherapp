class WeatherData {
  final String icon;
  final String city;
  final String date;
  final String description;
  final double temp;

  WeatherData({
    required this.icon,
    required this.city,
    required this.date,
    required this.description,
    required this.temp,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      icon: json['icon'],
      city: json['name'],
      date: json['dt'],
      description: json['weather'][0]['description'],
      temp: json['main']['temp'],
    );
  }
}