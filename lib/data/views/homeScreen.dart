import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voyager/data/views/detailScreen.dart';

class ExploreScreen extends StatelessWidget {
  final _controller = Get.put(ExploreController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FE), // Light blue background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildSearchBar(),
              const SizedBox(height: 20),
              _buildCategoryTabs(),
              const SizedBox(height: 20),
              _buildSectionTitle('Popular'),
              const SizedBox(height: 10),
              _buildPopularSection(),
              const SizedBox(height: 20),
              _buildSectionTitle('Recommended'),
              const SizedBox(height: 10),
              _buildRecommendedSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Explore',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Aspen, USA',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
        const Icon(Icons.location_pin, color: Colors.blue),
      ],
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Find things to do',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildCategoryTabs() {
    final tabs = ['Location', 'Hotels', 'Food', 'Adventure', 'Activities'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: tabs.map((tab) {
          return Obx(() {
            final isSelected = _controller.selectedTab.value == tab;
            return GestureDetector(
              onTap: () => _controller.selectTab(tab),
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    if (isSelected)
                      const BoxShadow(
                        color: Colors.blueAccent,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                  ],
                ),
                child: Text(
                  tab,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          });
        }).toList(),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Text(
          'See all',
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildPopularSection() {
    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _controller.popularPlaces.length,
        separatorBuilder: (_, __) => const SizedBox(width: 15),
        itemBuilder: (context, index) {
          final place = _controller.popularPlaces[index];
          return PlaceCard(place: place);
        },
      ),
    );
  }

  Widget _buildRecommendedSection() {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _controller.recommendedPlaces.length,
        separatorBuilder: (_, __) => const SizedBox(width: 15),
        itemBuilder: (context, index) {
          final place = _controller.recommendedPlaces[index];
          return PlaceCard(
            place: place,
            isSmall: true,
          );
        },
      ),
    );
  }
}

class PlaceCard extends StatelessWidget {
  final Place place;
  final bool isSmall;

  const PlaceCard({Key? key, required this.place, this.isSmall = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(DetailScreen());
      },
      child: Container(
        width: isSmall ? 150 : 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: AssetImage(place.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.yellow, size: 14),
                        Text(
                          place.rating.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExploreController extends GetxController {
  var selectedTab = 'Location'.obs;

  final popularPlaces = [
    Place(
        name: 'Alley Palace',
        rating: 4.1,
        imageUrl: 'assets/images/palace.png'),
    Place(
        name: 'Coeurdes Alpes',
        rating: 4.5,
        imageUrl: 'assets/images/palace2.png'),
  ];

  final recommendedPlaces = [
    Place(
        name: 'Explore Aspen',
        rating: 4.3,
        imageUrl: 'assets/images/palace3.png'),
    Place(
        name: 'Luxurious Aspen',
        rating: 4.2,
        imageUrl: 'assets/images/palace4.png'),
  ];

  void selectTab(String tab) {
    selectedTab.value = tab;
  }
}

class Place {
  final String name;
  final double rating;
  final String imageUrl;

  Place({required this.name, required this.rating, required this.imageUrl});
}
