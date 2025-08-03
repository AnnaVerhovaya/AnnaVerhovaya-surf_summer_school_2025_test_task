import 'package:equatable/equatable.dart';

class MapPoint extends Equatable {
  const MapPoint({
    required this.title,
    this.description,
    this.latitude,
    this.longitude,
  });

  final String title;
  final String? description;
  final double? latitude;
  final double? longitude;

  @override
  List<Object?> get props => [title, latitude, longitude];
}
