// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_weather_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CurrentWeatherStore on _CurrentWeatherStoreBase, Store {
  late final _$currentWeatherAtom =
      Atom(name: '_CurrentWeatherStoreBase.currentWeather', context: context);

  @override
  CurrentWeatherModel get currentWeather {
    _$currentWeatherAtom.reportRead();
    return super.currentWeather;
  }

  @override
  set currentWeather(CurrentWeatherModel value) {
    _$currentWeatherAtom.reportWrite(value, super.currentWeather, () {
      super.currentWeather = value;
    });
  }

  late final _$serviceAtom =
      Atom(name: '_CurrentWeatherStoreBase.service', context: context);

  @override
  CurrentWeatherService get service {
    _$serviceAtom.reportRead();
    return super.service;
  }

  @override
  set service(CurrentWeatherService value) {
    _$serviceAtom.reportWrite(value, super.service, () {
      super.service = value;
    });
  }

  late final _$fetchWeatherDataAsyncAction = AsyncAction(
      '_CurrentWeatherStoreBase.fetchWeatherData',
      context: context);

  @override
  Future<void> fetchWeatherData() {
    return _$fetchWeatherDataAsyncAction.run(() => super.fetchWeatherData());
  }

  @override
  String toString() {
    return '''
currentWeather: ${currentWeather},
service: ${service}
    ''';
  }
}
