import 'package:flutter/material.dart';
import 'package:flutter_samples/shimmer_effect/food.dart';
import 'package:flutter_samples/shimmer_effect/food_data.dart';
import 'package:flutter_samples/shimmer_effect/shimmer_widget.dart';

class ShimmerEffectPage extends StatefulWidget {
  const ShimmerEffectPage({Key? key}) : super(key: key);

  @override
  _ShimmerEffectPageState createState() => _ShimmerEffectPageState();
}

class _ShimmerEffectPageState extends State<ShimmerEffectPage> {
  List<Food> _foodList = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 5));
    _foodList = List.of(foodList);
    setState(() => _isLoading = false);
  }

  Widget _buildFood(Food food) {
    return ListTile(
      leading: CircleAvatar(
        radius: 32,
        backgroundImage: NetworkImage(food.urlImage),
      ),
      title: Text(
        food.title,
        style: TextStyle(fontSize: 16),
      ),
      subtitle: Text(
        food.description,
        style: TextStyle(fontSize: 14),
      ),
    );
  }

  Widget _buildFoodShimmer() {
    return ListTile(
      leading: ShimmerWidget.circular(width: 64, height: 64),
      title: Align(
        alignment: Alignment.centerLeft,
        child: ShimmerWidget.rectangular(
          width: MediaQuery.of(context).size.width * 0.3,
          height: 16,
        ),
      ),
      subtitle: ShimmerWidget.rectangular(height: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shimmer Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadData,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _isLoading ? 10 : _foodList.length,
        itemBuilder: (context, index) {
          if (_isLoading) {
            return _buildFoodShimmer();
          } else {
            final food = _foodList[index];
            return _buildFood(food);
          }
        },
      ),
    );
  }
}
