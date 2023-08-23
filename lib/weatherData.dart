class WeatherData {
  final String? icon;
  final String? city;
  final String? date;
  final String? description;
  final double? temp;

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
  getWeatherIcon() {
    switch (icon) {
      case '01d':
        return '☀️';
      case '01n':
        return '🌙';
      case '02d':
        return '⛅️';
      case '02n':
        return '⛅️';
      case '03d':
        return '☁️';
      case '03n':
        return '☁️';
      case '04d':
        return '☁️';
      case '04n':
        return '☁️';
      case '09d':
        return '🌧';
      case '09n':
        return '🌧';
      case '10d':
        return '🌦';
      case '10n':
        return '🌦';
      case '11d':
        return '⛈';
      case '11n':
        return '⛈';
      case '13d':
        return '🌨';
      case '13n':
        return '🌨';
      case '50d':
        return '🌫';
      case '50n':
        return '🌫';
      default:
        return 'Error';
    }
  }
  getCity() {
    return city;
  }
  getDate() {
    return date;
  }
  getDescription() {
    return description;
  }
  getTemp() {
    return temp;
  }
}