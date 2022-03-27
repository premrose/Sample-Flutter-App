class Model {
  final String end_address, start_address, duration, distance, roadPath, roadTime, travelMode, htmlInstructions;

  Model({
    required this.duration,
    required this.distance,
    required this.end_address,
    required this.start_address,
    required this.roadPath,
    required this.roadTime,
    required this.travelMode,
    required this.htmlInstructions,
  });

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model (
      distance: json['distance']['text'],
      duration: json['duration']['text'],
      end_address: json['end_address'].toString(),
      start_address: json['start_address'].toString(),
      roadPath: json['steps'][0]['distance']['text'].toString(),
      roadTime: json['steps'][0]['duration']['text'].toString(),
      travelMode: json['steps'][0]['travel_mode'].toString(),
      htmlInstructions: json['steps'][0]['html_instructions'].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'duration': duration,
    'distance': distance,
    'end_address': end_address,
    'start_address': start_address,
    'roadPath': roadPath,
    'roadTime': roadTime,
    'travel_mode': travelMode,
    'html_instructions': htmlInstructions,
  };
}