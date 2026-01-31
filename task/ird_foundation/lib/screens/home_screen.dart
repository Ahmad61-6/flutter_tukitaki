import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onMenuTap;
  const HomeScreen({super.key, required this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Location", style: GoogleFonts.raleway(color: Colors.grey)),
                          const Row(
                            children: [
                              Text("Jakarta", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                              Icon(Icons.keyboard_arrow_down),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: onMenuTap,
                        icon: const Badge(child: Icon(Icons.notifications_none, size: 30)),
                      )
                    ],
                  ),
                  const SizedBox(height: 25),
                  _buildSearchBar(),
                  const SizedBox(height: 25),
                  _buildCategoryList(),
                  const SizedBox(height: 25),
                  _buildSectionHeader("Near from you"),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 280,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 20),
                children: [
                  _featuredCard("Dreamsville House", "Jl. Sultan Iskandar Muda", "1.8 km"),
                  _featuredCard("Ascot House", "Jl. Cilandak Tengah", "2.1 km"),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverToBoxAdapter(child: _buildSectionHeader("Best for you")),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) => _bestForYouItem(),
              childCount: 5,
            ),
          ),
        ],
      ),
    );
  }

  // --- Sub-Widgets ---

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(15)),
            child: const TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.search, color: Colors.grey),
                hintText: "Search address, or near you",
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: const Color(0xFF0A8ED9), borderRadius: BorderRadius.circular(15)),
          child: const Icon(Icons.tune, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildCategoryList() {
    List categories = ["House", "Apartment", "Hotel", "Villa"];
    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          bool isFirst = index == 0;
          return Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: isFirst ? const Color(0xFF0A8ED9) : Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                categories[index],
                style: TextStyle(color: isFirst ? Colors.white : Colors.grey[600]),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _featuredCard(String name, String address, String distance) {
    return Container(
      width: 240,
      margin: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1580587771525-78b9dba3b914?q=80&w=1000&auto=format&fit=crop'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 15, right: 15,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(10)),
              child: Row(children: [const Icon(Icons.location_on, color: Colors.white, size: 14), Text(distance, style: const TextStyle(color: Colors.white))]),
            ),
          ),
          Positioned(
            bottom: 15, left: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                Text(address, style: const TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _bestForYouItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network('https://images.unsplash.com/photo-1512917774080-9991f1c4c750?q=80&w=200&auto=format&fit=crop', width: 80, height: 80, fit: BoxFit.cover),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Orchard House", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const Text("Rp. 2.500.000.000 / Year", style: TextStyle(color: Color(0xFF0A8ED9), fontSize: 12)),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.bed, size: 16, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text("6 Bedroom", style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                    const SizedBox(width: 15),
                    const Icon(Icons.bathtub, size: 16, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text("4 Bathroom", style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const Text("See more", style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}