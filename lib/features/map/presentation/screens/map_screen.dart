import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:surf_summer_school_2025_test_task/features/places/domain/domain.dart';
import 'package:surf_summer_school_2025_test_task/features/places/presentation/list/bloc/place_bloc.dart';
import 'dart:typed_data';
import 'dart:ui';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import '../widgets/map_place_details.dart';

@RoutePage()
class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final YandexMapController _mapController;
  Point? _userLocation;
  Uint8List? _mapPoint;

  @override
  void initState() {
    super.initState();
    // заглушка геолокации Москва
    _userLocation = const Point(latitude: 55.7, longitude: 37.6);
    _createGreenDotIcon();
  }

  Future<void> _createGreenDotIcon() async {
    const size = 50.0;
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint()..color = Colors.green;
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2, paint);
    final image =
        await recorder.endRecording().toImage(size.toInt(), size.toInt());
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    setState(() {
      _mapPoint = byteData!.buffer.asUint8List();
    });
  }

  Future<void> _initLocationLayer() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      await _mapController.toggleUserLayer(visible: true);
      _updateUserLocation();
    }
  }

  Future<void> _updateUserLocation() async {
    final position = await _mapController.getUserCameraPosition();
    if (position != null) {
      setState(() {
        _userLocation = position.target;
      });
      await _centerMapOnUser();
    }
  }

  List<PlacemarkMapObject> _getPlacemarksFromState(PlaceState state) {
    if (_mapPoint == null || state is! PlaceLoaded) return [];

    return state.places
        .where((place) => place.lat != null && place.lng != null)
        .map((place) => PlacemarkMapObject(
              mapId: MapObjectId('place_${place.id}'),
              point: Point(latitude: place.lat!, longitude: place.lng!),
              icon: PlacemarkIcon.single(
                PlacemarkIconStyle(
                  image: BitmapDescriptor.fromBytes(_mapPoint!),
                  scale: 1.0,
                ),
              ),
              onTap: (mapObject, point) {
                _showPlaceDetails(context, place);
              },
            ))
        .toList();
  }

  void _showPlaceDetails(BuildContext context, PlaceEntity place) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => MapPlaceDetailsWidget(place: place),
    );
  }

  Future<void> _centerMapOnUser() async {
    if (_userLocation != null) {
      await _mapController.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: _userLocation!,
            zoom: 12,
          ),
        ),
        animation: const MapAnimation(
          type: MapAnimationType.linear,
          duration: 0.3,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Text('Карта'),
        ),
      ),
      body: BlocBuilder<PlaceBloc, PlaceState>(
        builder: (context, state) {
          return Stack(
            children: [
              YandexMap(
                onMapCreated: (controller) async {
                  _mapController = controller;
                  await _initLocationLayer();
                },
                mapObjects: _getPlacemarksFromState(state),
              ),
              if (state is PlaceLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
              Positioned(
                bottom: 20,
                right: 20,
                child: FloatingActionButton(
                  mini: true,
                  onPressed: _centerMapOnUser,
                  child: const Icon(Icons.my_location),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
