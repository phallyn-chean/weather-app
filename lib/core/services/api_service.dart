class ApiService {
  String apiKey = "4f723647112d83b018a0d0d40d534016";

  String apiUrl(lat, lon) {
    return "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&appid=$apiKey";
  }
}
