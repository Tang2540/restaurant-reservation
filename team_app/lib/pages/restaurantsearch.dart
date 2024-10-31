import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import '../component/favoritesmodel.dart';
import 'favoritepage.dart';

class RestaurantSearchPage extends StatefulWidget {
  const RestaurantSearchPage({super.key});

  @override
  _RestaurantSearchPageState createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  final _formKey = GlobalKey<FormState>();
  String _searchQuery = '';
  List<String> _filteredRestaurants = [];

  // Sample restaurant data with details
  final Map<String, Map<String, String>> restaurantDetails = {
    'MK Restaurants - Future Park Rangsit': {
      'address':
          '94 Phahonyothin Rd. G Floor, Future Park Rangsit, Robinson Zone, Prachathipat, Thanyaburi District, Pathum Thani 12130',
      'phone': '025678888',
      'status': 'Close',
      'image': 'assets/restaurant5_image.png',
    },
    'Audrey Café': {
      'address':
          'Zpell Rangsit 2/F, Prachathipat, Thanyaburi District, Pathum Thani 12130',
      'phone': '029876543',
      'status': 'Open',
      'image': 'assets/restaurant6_image.png',
    },
    'Laem Charoen Seafood': {
      'address':
          'Zpell Rangsit 2/F, Prachathipat, Thanyaburi District, Pathum Thani 12130',
      'phone': '025678999',
      'status': 'Open',
      'image': 'assets/restaurant7_image.png',
    },
    'Yu Ting Yuan': {
      'address':
          'Four Seasons Hotel Bangkok, 300/1 Charoen Krung Rd, Yannawa, Sathon, Bangkok 10120',
      'phone': '022345678',
      'status': 'Open',
      'image': 'assets/restaurant8_image.png',
    },
    'BKK Social Club': {
      'address':
          'Four Seasons Hotel Bangkok, 300/1 Charoen Krung Rd, Yannawa, Sathon, Bangkok 10120',
      'phone': '022345679',
      'status': 'Close',
      'image': 'assets/restaurant9_image.png',
    },
    'Peacock Alley': {
      'address':
          'Waldorf Astoria Bangkok, 151 Ratchadamri Rd, Lumphini, Pathum Wan, Bangkok 10330',
      'phone': '022345680',
      'status': 'Open',
      'image': 'assets/restaurant10_image.png',
    },
    'Riva del Fiume': {
      'address':
          'Four Seasons Hotel Bangkok, 300/1 Charoen Krung Rd, Yannawa, Sathon, Bangkok 10120',
      'phone': '022345681',
      'status': 'Close',
      'image': 'assets/restaurant11_image.png',
    },
    'Gordon Ramsay Bread Street Kitchen and Bar': {
      'address':
          'Empshere Mall, 622 Sukhumvit Rd, Khlong Tan, Khlong Toei, Bangkok 10110',
      'phone': '022345682',
      'status': 'Open',
      'image': 'assets/restaurant12_image.png',
    },
    'The Loft & Champagne Bar': {
      'address':
          'Waldorf Astoria Bangkok, 151 Ratchadamri Rd, Lumphini, Pathum Wan, Bangkok 10330',
      'phone': '022345683',
      'status': 'Open',
      'image': 'assets/restaurant13_image.png',
    },
    'Bull & Bear': {
      'address':
          'Waldorf Astoria Bangkok, 151 Ratchadamri Rd, Lumphini, Pathum Wan, Bangkok 10330',
      'phone': '022345684',
      'status': 'Close',
      'image': 'assets/restaurant14_image.png',
    },
    'Savelberg Thailand': {
      'address': '110 Wireless Rd, Lumphini, Pathum Wan, Bangkok 10330',
      'phone': '022345685',
      'status': 'Open',
      'image': 'assets/restaurant15_image.png',
    },
    'Le Normandie by Alain Roux': {
      'address':
          'Mandarin Oriental Bangkok, 48 Oriental Ave, Bang Rak, Bangkok 10500',
      'phone': '022345686',
      'status': 'Open',
      'image': 'assets/restaurant16_image.png',
    },
    'Mezzaluna': {
      'address': 'State Tower, 1055 Silom Rd, Silom, Bang Rak, Bangkok 10500',
      'phone': '022345687',
      'status': 'Open',
      'image': 'assets/restaurant17_image.png',
    },
    'Sühring': {
      'address': '10 Yen Akat Rd, Chong Nonsi, Yan Nawa, Bangkok 10120',
      'phone': '022345688',
      'status': 'Open',
      'image': 'assets/restaurant18_image.png',
    },
    'Gaa': {
      'address':
          '68/4 Soi Langsuan, Ploenchit Rd, Lumphini, Pathum Wan, Bangkok 10330',
      'phone': '022345689',
      'status': 'Open',
      'image': 'assets/restaurant19_image.png',
    },
    'Paste Bangkok': {
      'address':
          'Gaysorn Village, 999 Ploenchit Rd, Lumphini, Pathum Wan, Bangkok 10330',
      'phone': '022345690',
      'status': 'Close',
      'image': 'assets/restaurant20_image.png',
    },
  };

  List<double> ratings = [];

  @override
  void initState() {
    super.initState();
    _filteredRestaurants = restaurantDetails.keys.toList();
    _generateRandomRatings();
  }

  void _generateRandomRatings() {
    Random random = Random();
    for (var i = 0; i < restaurantDetails.length; i++) {
      double rating =
          (random.nextBool() ? 4.0 : 4.5) + (random.nextBool() ? 0.5 : 0);
      ratings.add(rating);
    }
  }

  void _searchRestaurant(String query) {
    setState(() {
      _filteredRestaurants = restaurantDetails.keys
          .where((restaurant) =>
              restaurant.toLowerCase().contains(query.toLowerCase()) ||
              restaurantDetails[restaurant]!['address']!
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    });
  }

  void _selectRestaurant(String restaurantName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RestaurantDetailsPage(
            restaurantName: restaurantName,
            rating: ratings[_filteredRestaurants.indexOf(restaurantName)],
            details: restaurantDetails[restaurantName]!),
      ),
    );
  }

  Widget _buildStars(double rating) {
    List<Widget> stars = [];
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;

    for (int i = 0; i < fullStars; i++) {
      stars.add(const Icon(Icons.star, color: Colors.amber));
    }

    if (hasHalfStar) {
      stars.add(const Icon(Icons.star_half, color: Colors.amber));
    }

    for (int i = stars.length; i < 5; i++) {
      stars.add(const Icon(Icons.star_border, color: Colors.amber));
    }

    return Row(children: stars);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Search'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Search for a restaurant',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  _searchQuery = value;
                  _searchRestaurant(_searchQuery);
                },
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _filteredRestaurants.isNotEmpty
                  ? ListView.builder(
                      itemCount: _filteredRestaurants.length,
                      itemBuilder: (context, index) {
                        final restaurantName = _filteredRestaurants[index];
                        final details = restaurantDetails[restaurantName]!;

                        return Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: InkWell(
                            onTap: () => _selectRestaurant(restaurantName),
                            child: Row(
                              children: [
                                Image.asset(
                                  details['image']!,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        restaurantName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      _buildStars(ratings[_filteredRestaurants
                                          .indexOf(restaurantName)]),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Status: ${details['status']}',
                                        style: TextStyle(
                                          color: details['status'] == 'Open'
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(child: Text('No results found')),
            ),
          ],
        ),
      ),
    );
  }
}

class RestaurantDetailsPage extends StatefulWidget {
  final String restaurantName;
  final double rating;
  final Map<String, String> details;

  const RestaurantDetailsPage({
    Key? key,
    required this.restaurantName,
    required this.rating,
    required this.details,
  }) : super(key: key);

  @override
  State<RestaurantDetailsPage> createState() => _RestaurantDetailsPageState();
}

class _RestaurantDetailsPageState extends State<RestaurantDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  String _userComment = '';

  void _addToFavorites() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context
          .read<FavoritesModel>()
          .addFavorite(widget.restaurantName, _userComment);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                '${widget.restaurantName} added to favorites with comment')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FavoritesPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurantName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                widget.details['image']!,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Address: ${widget.details['address']}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Phone: ${widget.details['phone']}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Status: ${widget.details['status']}',
              style: TextStyle(
                fontSize: 16,
                color: widget.details['status'] == 'Open'
                    ? Colors.green
                    : Colors.red,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Rating: ${widget.rating.toString()}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return AddCommentForm(
                          restaurantName: widget.restaurantName);
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Add to Favorites'),
              ),
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text('Reserve')),
            )
          ],
        ),
      ),
    );
  }
}

class AddCommentForm extends StatefulWidget {
  final String restaurantName;

  const AddCommentForm({Key? key, required this.restaurantName})
      : super(key: key);

  @override
  _AddCommentFormState createState() => _AddCommentFormState();
}

class _AddCommentFormState extends State<AddCommentForm> {
  final _formKey = GlobalKey<FormState>();
  String _userComment = '';

  void _addToFavorites() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context
          .read<FavoritesModel>()
          .addFavorite(widget.restaurantName, _userComment);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                '${widget.restaurantName} added to favorites with comment')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Your Comment'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your comment';
                }
                return null;
              },
              onSaved: (value) {
                _userComment = value ?? '';
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addToFavorites,
              child: const Text('Add to Favorites'),
            ),
          ],
        ),
      ),
    );
  }
}
