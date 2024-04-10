import 'package:json_annotation/json_annotation.dart';
part 'currentweather_model.g.dart';

CurrentWeatherModel getCurrentWeatherModel(Map<String, dynamic> json) {
  return CurrentWeatherModel.fromJson(json);
}

@JsonSerializable()
class CurrentWeatherModel {
  @JsonKey(name: 'coord')
  final Coord? coord;

  @JsonKey(name: 'weather')
  final List<Weather>? weather;

  @JsonKey(name: 'base')
  final String? base;

  @JsonKey(name: 'main')
  final Main? main;

  @JsonKey(name: 'visibility')
  final int? visibility;

  // @JsonKey(name: 'wind')
  // final Wind? wind;

  // @JsonKey(name: 'clouds')
  // final Clouds? clouds;

  @JsonKey(name: 'dt')
  final int? dt;

  // @JsonKey(name: 'sys')
  // final Sys? sys;

  @JsonKey(name: 'timezone')
  final int? timezone;

  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'cod')
  final int? cod;

  CurrentWeatherModel({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    // this.wind,
    // this.clouds,
    this.dt,
    // this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) => _$CurrentWeatherModelFromJson(json);
  Map<String, dynamic> toJson() => _$CurrentWeatherModelToJson(this);
}

@JsonSerializable()
class Coord {
  @JsonKey(name: 'lon')
  final double? lon;

  @JsonKey(name: 'lat')
  final double? lat;

  Coord({
    this.lon,
    this.lat,
  });

  factory Coord.fromJson(Map<String, dynamic> json) => _$CoordFromJson(json);
  Map<String, dynamic> toJson() => _$CoordToJson(this);
}

@JsonSerializable()
class Weather {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'main')
  final String? main;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'icon')
  final String? icon;

  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => _$WeatherFromJson(json);
  Map<String, dynamic> toJson() {
    return _$WeatherToJson(this);
  }
}

@JsonSerializable()
class Main {
  @JsonKey(name: 'temp')
  final double? temp;

  @JsonKey(name: 'feels_like')
  final double? feelsLike;

  @JsonKey(name: 'temp_min')
  final double? tempMin;

  @JsonKey(name: 'temp_max')
  final double? tempMax;

  @JsonKey(name: 'pressure')
  final int? pressure;

  @JsonKey(name: 'humidity')
  final int? humidity;

  Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
  });

  factory Main.fromJson(Map<String, dynamic> json) => _$MainFromJson(json);
  Map<String, dynamic> toJson() {
    return _$MainToJson(this);
  }
}

@JsonSerializable()
class Wind {
  @JsonKey(name: 'speed')
  final double? speed;

  @JsonKey(name: 'deg')
  final int? deg;

  Wind({
    this.speed,
    this.deg,
  });

  factory Wind.fromJson(Map<String, dynamic> json) {
    return _$WindFromJson(json);
  }
  Map<String, dynamic> toJson() {
    return _$WindToJson(this);
  }
}

@JsonSerializable()
class Clouds {
  @JsonKey(name: 'all')
  final int? all;

  Clouds({
    this.all,
  });

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return _$CloudsFromJson(json);
  }
  Map<String, dynamic> toJson() {
    return _$CloudsToJson(this);
  }
}

@JsonSerializable()
class Sys {
  @JsonKey(name: 'type')
  final int? type;

  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'country')
  final String? country;

  @JsonKey(name: 'sunrise')
  final int? sunrise;

  @JsonKey(name: 'sunset')
  final int? sunset;

  Sys({
    this.type,
    this.id,
    this.country,
    this.sunrise,
    this.sunset,
  });

  factory Sys.fromJson(Map<String, dynamic> json) {
    return _$SysFromJson(json);
  }
  Map<String, dynamic> toJson() {
    return _$SysToJson(this);
  }
}
