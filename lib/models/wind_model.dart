
class Wind {
  Wind({
    required this.speed,
    required this.deg,
    this.gust,
  });

  double speed;
  int deg;
  double? gust;

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
    speed:  json["speed"].toDouble(),
    deg: json["deg"],
    gust: json["gust"] != null ? json["gust"].toDouble() : 0,
  );

  Map<String, dynamic> toJson() => {
    "speed": speed,
    "deg": deg,
    "gust": gust,
  };
}