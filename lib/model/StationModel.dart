class StationModel{
  List<dynamic> station;

  StationModel(Map<String, dynamic> data) {
    station = data['stations'] ?? [];
  }
}