import 'package:flutter/material.dart';
import 'package:flutter_samples/animations/shimmer/data.dart';
import 'package:flutter_samples/animations/shimmer/fake_repository.dart';
import 'package:flutter_samples/animations/shimmer/food_list_view.dart';
import 'package:flutter_samples/animations/shimmer/food_page_view.dart';

class ShimmerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: FakeRepository().mockRequest(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final foodItems = snapshot.data as List<Food>;
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: FoodPageView(foodItems: foodItems)),
                const SliverToBoxAdapter(
                  child: Divider(indent: 12.0, endIndent: 12.0),
                ),
                FoodListView(foodItems: foodItems),
              ],
            );
          }
          return CustomScrollView(
            physics: NeverScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: FoodPageView(
                  foodItems: [],
                  isLoading: true,
                ),
              ),
              const SliverToBoxAdapter(
                child: Divider(indent: 12.0, endIndent: 12.0),
              ),
              FoodListView(
                foodItems: [],
                isLoading: true,
              ),
            ],
          );
        },
      ),
    );
  }
}
