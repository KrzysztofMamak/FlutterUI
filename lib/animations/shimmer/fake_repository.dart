import 'package:flutter_samples/animations/shimmer/data.dart';

class FakeRepository {
  Future<List<Food>> mockRequest() async => await Future.delayed(
        const Duration(seconds: 5),
        () => foodData,
      );
}
